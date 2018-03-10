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

return {
  name = "Apocalypse",
  year = "Unknown",
  location = "Unknown",
  level_range = {1, 1},
  max_level = 10,
  width = 50, height = 50,
  persistent = "zone",
  all_lited = true,
  generator =  {
    map = {
      class = "engine.generator.map.Town",
      building_change = 80,
      max_building_w = 8, max_building_h = 8,
      edge_entrances = {6, 4},
      floor = "APO_FLOOR",
      wall = "APO_WALL",
      external_floor = "APO_DIRT",
      external_wall = "APO_WALL",
      gate = "APO_GATE",
      up = "UP",
      down = "DOWN",
      door = "APO_DOOR",
      nb_rooms = false,
      rooms = false,
    },
    actor = {
    },
  },

  levels = { },

  post_process = function(level)
    -- Tear down walls
    local num_open = rng.dice(15,20)
    local count = 0
    while count < num_open do
      local radius = 3
      local tx, ty = rng.range(radius, level.map.w-radius-1), rng.range(radius, level.map.h-radius-1)
      for x=(tx-radius),(tx+radius) do
        for y=(ty-radius),(ty+radius) do
          local dist = math.sqrt((x-tx)*(x-tx) + (y-ty)*(y-ty))
          local odds = math.max(0, 1.0-(dist/radius)^5)*100
          local place_open = rng.percent(odds)
          if (place_open) then
            local m = game.zone:makeEntityByName(level, "terrain", "APO_DIRT")
            if m then
              game.zone:addEntity(level, m, "terrain", x, y)
            end
          end
        end
      end
      count = count + 1
    end

    -- Create craters
    local num_craters = rng.dice(5,7)
    local count = 0
    while count < num_craters do
      local radius = rng.range(3, 6)
      local tx, ty = rng.range(radius, level.map.w-radius-1), rng.range(radius, level.map.h-radius-1)
      for x=(tx-radius),(tx+radius) do
        for y=(ty-radius),(ty+radius) do
          local dist = math.sqrt((x-tx)*(x-tx) + (y-ty)*(y-ty))
          local odds = math.max(0, 1.0-(dist/radius)^5)*100
          local place_crater = rng.percent(odds)
          if (place_crater) then
            local m = game.zone:makeEntityByName(level, "terrain", "RUBBLE")
            if m then
              game.zone:addEntity(level, m, "terrain", x, y)
            end
          end
        end
      end
      count = count + 1
    end
  end,

  on_turn = function(self)
    if not self.num_new_portals then self.num_new_portals = 0 end
    -- Update the portal count once every player turn
    if (game.turn % 10 == 1) then
      local fill_ratio = 1/9
      local map_area = self.width*self.height
      local scaling = 0.5 + game.turn_counter / game.max_turns
      local portals_per_turn = fill_ratio*map_area / game.max_turns * scaling
      self.num_new_portals = self.num_new_portals + portals_per_turn
    end
    -- If the number of new portals > 1, then spawn a new portal
    while self.num_new_portals > 1 do
      if rng.percent(5) then
        game:addPortal(game.zone, game.level, "startingroom")
      else
        game:addPortal(game.zone, game.level, "cretaceous")
      end
      self.num_new_portals = self.num_new_portals - 1
    end

    -- Spawn entites from the portal
    if (game.turn % 10 == 0) then
      for _, portal in pairs(game.portals) do
        if portal.zone == game.zone.short_name and rng.percent(100) then
          if game.monsters and game.monsters[portal.change_zone] and
            table.getn(game.monsters[portal.change_zone]) > 0 then
            local m = rng.table(game.monsters[portal.change_zone])
            if not m then
              print("[PORTALS] ERROR! Could not get a random monster from ", portal.change_zone)
            elseif not m.type then
              print("[PORTALS] ERROR! Got a weird type for monster from", portal.change_zone)
              print("          Table contents:")
              for k, v in pairs(m) do
                print("          ", k, " : ", v)
              end
            else
              local tx, ty = util.findFreeGrid(portal.x, portal.y, 2, "block_move", {[engine.Map.ACTOR]=true}) 
              m:move(tx, ty, true)
              game.level:addEntity(m)
              if game.player:canSee(m) and game.player:hasLOS(tx, ty) then
                game.log("You see a "..m.name.." emerge from the nearby rift!")
              end
              print("[PORTAL] Added a "..m.name.." to the level.")
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
          else
            print("[PORTALS] Tried to spawn a creature, but no monster list set up for "..portal.change_zone)
          end
        end
      end
    end
  end,
}
