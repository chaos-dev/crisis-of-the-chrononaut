-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009 - 2017 Nicolas Casalini
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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

return {
  name = "Apocalypse",
  year = "Unknown",
  location = "Unknown",
  level_range = {1, 1},
  max_level = 10,
  width = 100, height = 100,
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
      class = "engine.generator.actor.OnSpots",
      nb_npc = {0, 0},
      nb_spots = 5, on_spot_chance = 75
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
    if not self.portal_count then self.portal_count = 0 end
    if (game.turn % 10 == 1) then
      local fill_ratio = 1/9
      local map_area = self.width*self.height
      local scaling = 0.5 + game.turn_counter / game.max_turns
      local portals_per_turn = fill_ratio*map_area / game.max_turns * scaling
      self.portal_count = self.portal_count + portals_per_turn
    end
    while self.portal_count > 1 do
      if rng.percent(5) then
        game:addPortal(game.zone, game.level, "startingroom")
      else
        game:addPortal(game.zone, game.level, "cretaceous")
      end
      self.portal_count = self.portal_count - 1
    end
  end,
}
