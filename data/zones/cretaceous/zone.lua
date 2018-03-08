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
--



return {
  name = "Cretaceous Era",
  year = "150 Million Years Ago",
  location = "Unknown",
  level_range = {1, 1},
  max_level = 10,
  width = 200, height = 200,
  persistent = "zone",
  all_lited = true,
  generator =  {
    map = {
      class = "engine.generator.map.Forest",
      edge_entrances = {4, 6},
      sqrt_percent = 50,
      sqrt_percent2 = 50,
      floor = "DINO_GROUND",
      floor2 = "DINO_GRASS",
      wall = "DINO_TREE",
      up = "UP",
      down = "DOWN",
      door = "DOOR",
      do_ponds = {
        nb = {9, 12},
        size = {w=25, h=25},
        pond = {{0.6, "DINO_TALLGRASS"}, {0.8, "DINO_TALLGRASS"}},
      },
      --add_road = true,
      --road = "DEEP_WATER",
    },
    actor = {
      class = "engine.generator.actor.Random",
      nb_npc = {25, 35},
    },
  },
  levels = { },

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
        game:addPortal(game.zone, game.level, "apocalypse")
      end
      self.portal_count = self.portal_count - 1
    end
  end,
}
