-- Crisis of the Chrononaut
-- Copyright (C) 2018 Chaos-Dev
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "engine.class"
require "engine.GameTurnBased"
require "engine.interface.GameTargeting"
require "engine.KeyBind"
local Savefile = require "engine.Savefile"
local DamageType = require "engine.DamageType"
local Zone = require "engine.Zone"
local Map = require "engine.Map"
local Level = require "engine.Level"
local Birther = require "engine.Birther"

local Grid = require "mod.class.Grid"
local Actor = require "mod.class.Actor"
local Player = require "mod.class.Player"
local NPC = require "mod.class.NPC"

local HotkeysDisplay = require "engine.HotkeysDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local DebugConsole = require "engine.DebugConsole"
local FlyingText = require "engine.FlyingText"
local Tooltip = require "engine.Tooltip"

local QuitDialog = require "mod.dialogs.Quit"


module(..., package.seeall, class.inherit(engine.GameTurnBased, engine.interface.GameTargeting))

function _M:init()
  engine.GameTurnBased.init(self, engine.KeyBind.new(), 1000, 100)

  -- Pause at birth
  self.paused = true

  -- The max length of game
  self.max_turns = 2000

  -- Same init as when loaded from a savefile
  self:loaded()
end

function _M:run()
  self.uiset:activate()

  --Setup tooltip
  self.tooltip = Tooltip.new(nil, nil, {255, 255, 255}, {30, 30, 30})

  -- Setup inputs
  self:setupCommands()
  self:setupMouse()

  -- Starting from here we create a new game
  if not self.player then self:newGame() end

  -- Setup the targetting system
  engine.interface.GameTargeting.init(self)

  self.uiset.hotkeys_display.actor = self.player
  self.uiset.npcs_display.actor = self.player

  -- Ok everything is good to go, activate the game in the engine!
  self:setCurrent()

  if self.level then self:setupDisplayMode(false, "postinit") end

  game.log("Welcome to Crisis of the Chrononaut!")
end

function _M:newGame()
  self.player = Player.new{name=self.player_name, game_ender=true}
  Map:setViewerActor(self.player)
  self:setupDisplayMode()

  self.creating_player = true
  local birth = Birther.new(nil, self.player, {"base", "role" }, function()
    self:changeLevel(1, "startingroom")
    print("[PLAYER BIRTH] resolve...")
    self.player:resolve()
    self.player:resolve(nil, true)
    self.player.energy.value = self.energy_to_act
    self.paused = true
    self.creating_player = false
    print("[PLAYER BIRTH] resolved!")
  end)
  self:registerDialog(birth)
end

function _M:loaded()
  local ui_w, ui_h = core.display.size()
  engine.GameTurnBased.loaded(self)
  Zone:setup{npc_class="mod.class.NPC", grid_class="mod.class.Grid", }

  self.uiset = (require("mod.class.uiset."..(config.settings.cotc.uiset_mode or "cotc"))).new()

  Map:setViewerActor(self.player)
  self:setupDisplayMode(false, "init")
  self:setupDisplayMode(false, "postinit")
  if self.player then self.player.changed = true end
  self.key = engine.KeyBind.new()
end

function _M:setupDisplayMode()
  if not mode or mode == "init" then
    Map:resetTiles()
  end

  if not mode or mode == "postinit" then
    print("[DISPLAY MODE] 32x32 ASCII/background")

    local tw, th = 32, 32
    local map_x, map_y, map_w, map_h = self.uiset:getMapSize()
    local ui_w, ui_h = core.display.size()
    local pot_th = math.pow(2, math.ceil(math.log(th-0.1) / math.log(2.0)))
    local fsize = math.floor( pot_th/th*(0.7 * th + 5) )
    Map:setViewPort(map_x, map_y, map_w, map_h, tw, th, nil, fsize, true)
    -- Map:setViewPort(sidebar_w, 0, ui_w - sidebar_w, ui_h, 32, 32, nil, 22, true)
    Map:resetTiles()
    Map.tiles.use_images = false

    if self.level then
      self.level.map:recreate()
      engine.interface.GameTargeting.init(self)
      self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8)
    end

    self:setupMiniMap()
  end
end

function _M:setupMiniMap()
  if self.level and self.level.map and self.level.map.finished then
    self.uiset:setupMinimap(self.level)
  end
end

function _M:save()
  return class.save(self, self:defaultSavedFields{}, true)
end

function _M:getSaveDescription()
  return {
    name = self.player.name,
    description = ([[Exploring level %d of %s.]]):format(self.level.level, self.zone.name),
  }
end

function _M:leaveLevel(level, lev, old_lev)
  if level:hasEntity(self.player) then
    level.exited = level.exited or {}
    if lev > old_lev then
      level.exited.down = {x=self.player.x, y=self.player.y}
    else
      level.exited.up = {x=self.player.x, y=self.player.y}
    end
    level.last_turn = game.turn
    level:removeEntity(self.player)
  end
end

function _M:isTargetingPlayer(entity)
  local dist = math.sqrt((entity.x - game.player.x)^2 + (entity.y - game.player.y)^2) 
  return entity.ai_target and entity.ai_target.actor and
         entity.ai_target.actor.player and
         game.player:canSee(entity) and
         (game.player:hasLOS(entity.x, entity.y) or dist < 4)
end

function _M:changeLevel(lev, zone, teleport, portal_ID)
  local old_lev = (self.level and not zone) and self.level.level or -1000

  -- Store creature info for this zone
  if game.zone and game.level then
    if not game.monsters then game.monsters = {} end
    -- Initialize and/or clear any old monster storage
    game.monsters[game.zone.short_name] = {}
    -- FIXME: Add levels
    for uid, e in pairs(game.level.entities) do
      if not e.player then
        if self:isTargetingPlayer(e) then
          e.following = true
          e.follow_dist = math.sqrt((e.x - game.player.x)^2 + (e.y - game.player.y)^2)
          print("[PORTAL] Following distance set to "..e.follow_dist)
        end
        table.insert(game.monsters[game.zone.short_name], e)
        print("UID:", uid, "Name:", e.name, "Life:", e.life, "Max Life:", e.max_life)
      end
    end
    local count = 0
    for _ in pairs(game.monsters[game.zone.short_name]) do count = count + 1 end
    print("[PORTAL] Copied", count, "entities into the game state for", game.zone.short_name)
  end

  if zone then
    if self.zone then
      self.zone:leaveLevel(false, lev, old_lev)
      self.zone:leave()
    end
    if type(zone) == "string" then
      self.zone = Zone.new(zone)
    else
      self.zone = zone
    end
  end
  self.zone:getLevel(self, lev, old_lev)

  -- Move to the stairs
  if not teleport then
    if lev > old_lev then
      self.player:move(self.level.default_up.x, self.level.default_up.y, true)
    else
      self.player:move(self.level.default_down.x, self.level.default_down.y, true)
    end
    self.level:addEntity(self.player)
  end

  -- Add any missing portals
  if self.portal_queue and self.portal_queue[self.zone.short_name] then
    for k, ID in pairs(self.portal_queue[self.zone.short_name]) do
      local match_ID = self.portals[ID].match
      local destination = self.portals[ID].zone
      self:addMatchingPortal(self.zone, self.level, destination, match_ID, ID)
    end
    self.portal_queue[self.zone.short_name] = nil
  end

  -- Move to a matching portal
  if teleport then
    print("[PORTAL] Teleporting to ", zone, lev)
    -- Place the player on the matching portal
    local match_ID = game.portals[portal_ID].match
    local tx, ty = game.portals[match_ID].x, game.portals[match_ID].y
    game.player.traveling = true
    self.player:move(tx, ty, true)
    self.level:addEntity(self.player)
    game.player.traveling = false
    game.portal_last_used = table.clone(game.portals[match_ID])
  end

  -- Update the minimap
  self:setupMiniMap()

  -- Allow custom dialogs/actions upon entering the area
  if self.zone.on_enter then
    self.zone.on_enter(lev, old_lev, zone)
  end

  -- Make sure the moved entities are properly deleted
  if game.zone and game.level and game.deleted and game.deleted[game.zone.short_name] then
    for _, match in pairs(game.deleted[game.zone.short_name]) do
      local found_match = false
      for _, e in pairs(game.level.entities) do
        if e.name == match.name and e.life == match.life and e.max_life == match.max_life then
          found_match = true
          game.log("[PORTAL] Removed entity", e.name, "from zone", game.zone.short_name)
          game.level:removeEntity(e, true)
          break
        end
      end
    end
  end
end

function _M:getPlayer()
  return self.player
end

--- Says if this savefile is usable or not
function _M:isLoadable()
  return not self:getPlayer(true).dead
end

function _M:tick()
  if self.level then
    self:targetOnTick()

    engine.GameTurnBased.tick(self)
    -- Fun stuff: this can make the game realtime, although calling it in display() will make it work better
    -- (since display is on a set FPS while tick() ticks as much as possible
    -- engine.GameEnergyBased.tick(self)
  end
  -- When paused (waiting for player input) we return true: this means we wont be called again until an event wakes us
  if self.paused and not savefile_pipe.saving then return true end
end

--- Called every game turns
function _M:onTurn()
  -- Increment turn counter
  if not self.turn_counter then self.turn_counter = 0 end
  if game.turn % 10 == 0 then
    self.turn_counter = self.turn_counter + 1
  end

  --Actually do zone on turn stuff
  if self.zone then
    if self.zone.on_turn then self.zone:on_turn() end
  end

  -- Process overlay effects
  self.level.map:processEffects()
end

function _M:updateFOV()
  self.player:playerFOV()
end

function _M:displayMap(nb_keyframes)
  -- Now the map, if any
  if self.level and self.level.map and self.level.map.finished then
    local map = self.level.map
    if map.changed then self:updateFOV() end

    -- Display the map
    map:display(nil, nil, nb_keyframes, false, nil)

    -- Display any targeting system
    if self.target then self.target:display() end
  end
end


function _M:display(nb_keyframes)
  -- If switching resolution, blank everything but the dialog
  if self.change_res_dialog then engine.GameTurnBased.display(self, nb_keyframes) return end

  -- Now the UI
  self.uiset:display(nb_keyframes)

  if self.player then self.player.changed = false end

  engine.GameTurnBased.display(self, nb_keyframes)

  -- Tooltip is displayed over all else
  self:targetDisplayTooltip()
end

--- Setup the keybinds
function _M:setupCommands()
  -- Make targeting work
  self.normal_key = self.key
  self:targetSetupKey()

  -- One key handled for normal function
  self.key:unicodeInput(true)
  self.key:addCommands{
    [{"_g","ctrl"}] = function() if config.settings.cheat then
      collectgarbage("collect")
      local nb = 0
      for k, e in pairs(__uids) do nb = nb + 1 end
      game.log("NB: " .. nb)
    end end,
  }
  self.key:addBinds
  {
    -- Movements
    MOVE_LEFT = function() self.player:moveDir(4) end,
    MOVE_RIGHT = function() self.player:moveDir(6) end,
    MOVE_UP = function() self.player:moveDir(8) end,
    MOVE_DOWN = function() self.player:moveDir(2) end,
    MOVE_LEFT_UP = function() self.player:moveDir(7) end,
    MOVE_LEFT_DOWN = function() self.player:moveDir(1) end,
    MOVE_RIGHT_UP = function() self.player:moveDir(9) end,
    MOVE_RIGHT_DOWN = function() self.player:moveDir(3) end,
    MOVE_STAY = function() self.player:useEnergy() end,

    RUN_LEFT = function() self.player:runInit(4) end,
    RUN_RIGHT = function() self.player:runInit(6) end,
    RUN_UP = function() self.player:runInit(8) end,
    RUN_DOWN = function() self.player:runInit(2) end,
    RUN_LEFT_UP = function() self.player:runInit(7) end,
    RUN_LEFT_DOWN = function() self.player:runInit(1) end,
    RUN_RIGHT_UP = function() self.player:runInit(9) end,
    RUN_RIGHT_DOWN = function() self.player:runInit(3) end,

    -- Hotkeys
    HOTKEY_1 = function() self.player:activateHotkey(1) end,
    HOTKEY_2 = function() self.player:activateHotkey(2) end,
    HOTKEY_3 = function() self.player:activateHotkey(3) end,
    HOTKEY_4 = function() self.player:activateHotkey(4) end,
    HOTKEY_5 = function() self.player:activateHotkey(5) end,
    HOTKEY_6 = function() self.player:activateHotkey(6) end,
    HOTKEY_7 = function() self.player:activateHotkey(7) end,
    HOTKEY_8 = function() self.player:activateHotkey(8) end,
    HOTKEY_9 = function() self.player:activateHotkey(9) end,
    HOTKEY_10 = function() self.player:activateHotkey(10) end,
    HOTKEY_11 = function() self.player:activateHotkey(11) end,
    HOTKEY_12 = function() self.player:activateHotkey(12) end,
    HOTKEY_SECOND_1 = function() self.player:activateHotkey(13) end,
    HOTKEY_SECOND_2 = function() self.player:activateHotkey(14) end,
    HOTKEY_SECOND_3 = function() self.player:activateHotkey(15) end,
    HOTKEY_SECOND_4 = function() self.player:activateHotkey(16) end,
    HOTKEY_SECOND_5 = function() self.player:activateHotkey(17) end,
    HOTKEY_SECOND_6 = function() self.player:activateHotkey(18) end,
    HOTKEY_SECOND_7 = function() self.player:activateHotkey(19) end,
    HOTKEY_SECOND_8 = function() self.player:activateHotkey(20) end,
    HOTKEY_SECOND_9 = function() self.player:activateHotkey(21) end,
    HOTKEY_SECOND_10 = function() self.player:activateHotkey(22) end,
    HOTKEY_SECOND_11 = function() self.player:activateHotkey(23) end,
    HOTKEY_SECOND_12 = function() self.player:activateHotkey(24) end,
    HOTKEY_THIRD_1 = function() self.player:activateHotkey(25) end,
    HOTKEY_THIRD_2 = function() self.player:activateHotkey(26) end,
    HOTKEY_THIRD_3 = function() self.player:activateHotkey(27) end,
    HOTKEY_THIRD_4 = function() self.player:activateHotkey(28) end,
    HOTKEY_THIRD_5 = function() self.player:activateHotkey(29) end,
    HOTKEY_THIRD_6 = function() self.player:activateHotkey(30) end,
    HOTKEY_THIRD_7 = function() self.player:activateHotkey(31) end,
    HOTKEY_THIRD_8 = function() self.player:activateHotkey(32) end,
    HOTKEY_THIRD_9 = function() self.player:activateHotkey(33) end,
    HOTKEY_THIRD_10 = function() self.player:activateHotkey(34) end,
    HOTKEY_THIRD_11 = function() self.player:activateHotkey(35) end,
    HOTKEY_THIRD_12 = function() self.player:activateHotkey(36) end,
    HOTKEY_PREV_PAGE = function() self.player:prevHotkeyPage() end,
    HOTKEY_NEXT_PAGE = function() self.player:nextHotkeyPage() end,

    -- Actions
    CHANGE_LEVEL = function()
      local e = self.level.map(self.player.x, self.player.y, Map.TERRAIN)
      if self.player:enoughEnergy() and e.change_level then
        self:changeLevel(e.change_zone and e.change_level or self.level.level + e.change_level, e.change_zone)
      else
        self.log("There is no way out of this level here.")
      end
    end,

    REST = function()
      self.player:restInit()
    end,

    USE_TALENTS = function()
      self.player:useTalents()
    end,

    SAVE_GAME = function()
      self:saveGame()
    end,

    SHOW_CHARACTER_SHEET = function()
      self:registerDialog(require("mod.dialogs.CharacterSheet").new(self.player))
    end,

    -- Exit the game
    QUIT_GAME = function()
      self:onQuit()
    end,

    SCREENSHOT = function() self:saveScreenshot() end,

    EXIT = function()
      local menu menu = require("engine.dialogs.GameMenu").new{
        "resume",
        "keybinds",
        "video",
        "save",
        "quit"
      }
      self:registerDialog(menu)
    end,

    -- Lua console, you probably want to disable it for releases
    LUA_CONSOLE = function()
      self:registerDialog(DebugConsole.new())
    end,

    -- Toggle monster list
    TOGGLE_NPC_LIST = function()
      self.show_npc_list = not self.show_npc_list
      self.player.changed = true
    end,

    TACTICAL_DISPLAY = function()
      if Map.view_faction then
        self.always_target = nil
        Map:setViewerFaction(nil)
      else
        self.always_target = true
        Map:setViewerFaction("players")
      end
    end,

    LOOK_AROUND = function()
      self.log("Looking around... (direction keys to select interesting things, shift+direction keys to move freely)")
      local co = coroutine.create(function() self.player:getTarget{type="hit", no_restrict=true, range=2000} end)
      local ok, err = coroutine.resume(co)
      if not ok and err then print(debug.traceback(co)) error(err) end
    end,
  }
  self.key:setCurrent()
end

function _M:setupMouse(reset)
  if reset == nil or reset then self.mouse:reset() end
  self.mouse:registerZone(Map.display_x, Map.display_y, Map.viewport.width, Map.viewport.height, function(button, mx, my, xrel, yrel, bx, by, event)
    -- Handle targeting
    if self:targetMouse(button, mx, my, xrel, yrel, event) then return end

    -- Handle the mouse movement/scrolling
    self.player:mouseHandleDefault(self.key, self.key == self.normal_key, button, mx, my, xrel, yrel, event)
  end)

  self.uiset:setupMouse(self.mouse)

  if not reset then self.mouse:setCurrent() end
end

--- Ask if we really want to close, if so, save the game first
function _M:onQuit()
  self.player:restStop()

  if not self.quit_dialog then
    self.quit_dialog = QuitDialog.new()
    self:registerDialog(self.quit_dialog)
  end
end

--- Requests the game to save
function _M:saveGame()
  -- savefile_pipe is created as a global by the engine
  savefile_pipe:push(self.save_name, "game", self)
  self.log("Saving game...")
end

--[[

When a portal spawns, the portal knows its own information, the ID of
its match, and the zone of its match.  But the corresponding portal
can't be spawned yet, since the zone is not active.  So the portal
just pushes its own ID to a queue.

Then, when the player changes to that level (by stepping on that portal
or any other portals), the game pulls up that ID. It then goes to make a
matching portal.  The process is pretty similar except that it already knows
the ID and the matching ID, and there's no log messages/actions.

So how does the game know where to take a player when they step on a portal?
First, we change to the corresponding level. That will trigger the
creation of the matching portal, if necessary.  Then, we use the matching ID
to look up the x, y coordinates of the matching portal.

]]--

function _M:addPortal(zone, level, short_name)
  print("[PORTALS] Adding a portal to that leads to", short_name)
  local m = zone:makeEntityByName(level, "terrain", "PORTAL")
  if m then
    -- Give the portal its unique ID
    m.ID = self:getUniqueID()
    m.change_zone = short_name

    -- Find a place for the portal
    local x, y = rng.range(0, level.map.w-1), rng.range(0, level.map.h-1)
    local tx, ty = util.findFreeGrid(x, y, 5, false, {[engine.Map.ACTOR]=true})
    if not tx then return end

    -- Set up the portal properties in game
    if not self.portals then self.portals = {} end
    local match_ID = self:getUniqueID()
    self.portals[m.ID] = {match=match_ID, zone=zone.short_name,
                          change_zone=short_name, x=tx, y=ty}
    if not self.portal_queue then self.portal_queue = {} end
    if not self.portal_queue[short_name] then self.portal_queue[short_name] = {} end
    table.insert(self.portal_queue[short_name], m.ID)

    -- Add the portal to the map
    game.zone:addEntity(level, m, "terrain", tx, ty)
    if game.player:canSee(m) and game.player:hasLOS(tx, ty) then
      game.log("You see a flash, and another shimmering portal appears.")
    end
  end
end

function _M:addMatchingPortal(zone, level, name, ID, match_ID)
  print("[PORTALS] Adding a matching portal to that leads to", name)
  local m = zone:makeEntityByName(level, "terrain", "PORTAL")
  if m then
    -- Give the portal its unique ID
    m.ID = ID
    m.change_zone = name

    -- Find a place for the portal
    local x, y = rng.range(0, level.map.w-1), rng.range(0, level.map.h-1)
    local tx, ty = util.findFreeGrid(x, y, 5, false, {[engine.Map.ACTOR]=true})
    if not tx then return end

    -- Set up the portal properties in game
    if not self.portals then self.portals = {} end
    self.portals[m.ID] = {match=match_ID, zone=zone.short_name,
                          change_zone=name, x=tx, y=ty}

    -- Add the portal to the map
    game.zone:addEntity(level, m, "terrain", tx, ty)
  end
end

function _M:getUniqueID()
  if not self.IDCount then
    self.IDCount = 0
  else
    self.IDCount = self.IDCount + 1
  end
  return self.IDCount
end

function _M:placeAtPortal(portal, m, following)
  local tx, ty = util.findFreeGrid(portal.x, portal.y, 2, "block_move", {[engine.Map.ACTOR]=true}) 
  if not tx then
    print("[PORTAL] Could not place monster. No available space.")
    return false
  else
    m:move(tx, ty, true)
    game.level:addEntity(m)
    if game.player:canSee(m) and game.player:hasLOS(tx, ty) then
      if not following then
        game.log("You see a "..m.name.." emerge from a nearby rift!")
      else
        game.log("You see a "..m.name.." follow you through the nearby rift!")
      end
    end
    print("[PORTAL] Added a "..m.name.." to the level.")
    return true
  end
end

function _M:markForDeletion(portal, m)
  -- Mark the entity for deletion
  if not game.deleted then game.deleted = {} end
  if not game.deleted[portal.change_zone] then
    game.deleted[portal.change_zone] = {}
  end
  table.insert(game.deleted[portal.change_zone],
  {name=m.name, life=m.life, max_life=m.max_life})

  -- Delete the entity from the list of entities on other levels
  local flag = true
  for key, entity in pairs(game.monsters[portal.change_zone]) do
    if entity.uid == m.uid then
      game.monsters[portal.change_zone][key] = nil
      flag = false
      break
    end
  end
  if flag then print("[PORTALS] Error: Could not find entity to delete!") end
end
