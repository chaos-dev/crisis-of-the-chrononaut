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
  name = "Cretaceous Era",
  year = "150 Million Years Ago",
  location = "Unknown",
  level_range = {1, 1},
  max_level = 10,
  width = 100, height = 100,
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
        nb = {3, 6},
        size = {w=25, h=25},
        pond = {{0.6, "DINO_TALLGRASS"}, {0.8, "DINO_TALLGRASS"}},
      },
      --add_road = true,
      --road = "DEEP_WATER",
    },
    actor = {
      class = "engine.generator.actor.Random",
      nb_npc = {10, 20},
    },
  },
  levels = { },

  on_turn = function(self)
    if game.turn % 100 == 0 then
      game:addPortal(game.zone, game.level, "startingroom")
    end
  end,
}
