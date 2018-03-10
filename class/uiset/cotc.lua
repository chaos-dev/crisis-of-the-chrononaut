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
local UI = require "engine.ui.Base"
local UISet = require "mod.class.uiset.UISet"
local DebugConsole = require "engine.DebugConsole"
local HotkeysDisplay = require "engine.HotkeysDisplay"
local HotkeysIconsDisplay = require "engine.HotkeysIconsDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local PlayerDisplay = require "mod.class.PlayerDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local FlyingText = require "engine.FlyingText"
local Shader = require "engine.Shader"
local Tooltip = require "engine.Tooltip"
local Dialog = require "engine.ui.Dialog"
local Map = require "engine.Map"
local FontPackage = require "engine.FontPackage"

module(..., package.seeall, class.inherit(UISet))

local mmap_size = 400
local sidebar_w = mmap_size
local info_h = 200
local tool_h = 200

function _M:init()
    UISet.init(self)
end

function _M:activate()
  local size, size_mono, font, font_mono, font_mono_h, font_h

  font = config.settings.cotc.fonts.hud.style
  size = config.settings.cotc.fonts.hud.size
  font_mono = config.settings.cotc.fonts.tooltip.style
  size_mono = config.settings.cotc.fonts.tooltip.size

  local f = core.display.newFont(font, size)
  font_h = f:lineSkip()
  f = core.display.newFont(font_mono, size_mono)
  font_mono_h = f:lineSkip()
  self.init_font = font
  self.init_size_font = size
  self.init_font_h = font_h
  self.init_font_mono = font_mono
  self.init_size_mono = size_mono
  self.init_font_mono_h = font_mono_h

  local ui_w, ui_h = core.display.size()
  local info_y = mmap_size
  local tool_y = info_y + info_h
  local log_y = tool_y + tool_h
  self.player_display = PlayerDisplay.new(0, info_y, sidebar_w, tool_h, {255, 255, 255}, font_mono, size_mono)
  self.logdisplay = LogDisplay.new(0, log_y, sidebar_w, ui_h - log_y, nil, font, size, nil, nil)
  self.hotkeys_display = HotkeysDisplay.new(nil, 0, tool_y, sidebar_w, tool_h, nil, font_mono, size_mono)
  self.npcs_display = ActorsSeenDisplay.new(nil, 0, tool_y, sidebar_w, tool_h, nil, font_mono, size_mono)
  self.flyers = FlyingText.new()
  game:setFlyingText(self.flyers)

  game.log = function(style, ...)
    if type(style) == "number" then
      game.uiset.logdisplay(...)
    else
      game.uiset.logdisplay(style, ...)
    end
  end

  game.logSeen = function(e, style, ...)
    if e and game.level.map.seens(e.x, e.y) then game.log(style, ...) end
  end

  self.logPlayer = function(e, style, ...)
    if e == game.player then game.log(style, ...) end
  end

  game.logNewest = function()
    return game.uiset.logdisplay:getNewestLine()
  end
end

function _M:setupMinimap(level)
    level.map._map:setupMiniMapGridSize(4)
end

function _M:getMapSize()
    -- Pad the display to avoid the werid overlapping bug
    local padding = 32
    local w, h = core.display.size()
    return sidebar_w+padding, 0, w-sidebar_w-padding, h
end


function _M:displayUI()
end

function _M:display(nb_keyframes)
  game:displayMap(nb_keyframes)

  -- Minimap display
  if game.level and game.level.map then
    local map = game.level.map
    if game.player.x then
        game.minimap_scroll_x = util.bound(game.player.x - 50/2, 0, map.w - 50)
        game.minimap_scroll_y = util.bound(game.player.y - 50/2, 0, map.h - 50)
    else
        game.minimap_scroll_x, game.minimap_scroll_y = 0, 0
    end
    map:minimapDisplay(0, 0, game.minimap_scroll_x, game.minimap_scroll_y, mmap_size, mmap_size, 1)
  end

  -- We display the player's interface
  self.player_display:toScreen(nb_keyframes)
  self.logdisplay:toScreen()
  if game.show_npc_list then
    self.npcs_display:toScreen()
  else
    self.hotkeys_display:toScreen()
  end

  -- UI
  self:displayUI()
end

function _M:setupMouse(mouse)
  -- Scroll message log
  mouse:registerZone(self.logdisplay.display_x, self.logdisplay.display_y, game.w, game.h, function(button)
    if button == "wheelup" then self.logdisplay:scrollUp(1) end
    if button == "wheeldown" then self.logdisplay:scrollUp(-1) end
  end, {button=true})

  -- Use hotkeys with mouse
  mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, game.w, game.h, function(button, mx, my, xrel, yrel, bx, by, event)
    self.hotkeys_display:onMouse(button, mx, my, event == "button",
        function(text)
          game.tooltip:displayAtMap(nil, nil, game.w, game.h, tostring(text))
        end)
  end)
end
