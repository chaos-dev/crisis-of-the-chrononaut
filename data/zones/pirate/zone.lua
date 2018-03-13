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
  name = "Pirate Ship",
  year = "About 1700",
  location = "Off the Carolina Coast",
  level_range = {1, 1},
  max_level = 10,
  width = 70, height = 70,
  persistent = "zone",
  all_lited = true,
  no_level_connectivity = true,
  generator =  {
    map = {
      class = "engine.generator.map.Forest",
      sqrt_percent = 80,
      sqrt_percent2 = 20,
      floor = "SAND",
      floor2 = "DEEP_WATER",
      wall = "DEEP_WATER",
      up = "SAND",
      down = "SAND",
      nb_rooms = {1},
      rooms ={"lesser_vault"},
      lesser_vaults_list = {"pirate_ship"},
      lite_room_chance = 100,
      no_tunnels = true,
      do_ponds = {
        nb = {2, 4},
        size = {w=25, h=25},
        pond = {{0.6, "SAND"}, {0.8, "SAND"}},
      },
    },
    object = {
    },
  },
  levels = { },

  on_turn = function(self)
    if not self.portal_count then self.portal_count = 0 end
    if (game.turn % 10 == 1) then
      local fill_ratio = 1/2
      local map_area = 22*9
      local scaling = 0.5 + game.turn_counter / game.max_turns
      local portals_per_turn = fill_ratio*map_area / game.max_turns * scaling
      self.portal_count = self.portal_count + portals_per_turn
    end
    while self.portal_count > 1 do
      if rng.percent(2) then
        game:addPortal(game.zone, game.level, "cretaceous")
      elseif rng.percent(2) then
        game:addPortal(game.zone, game.level, "apocalypse")
      elseif rng.percent(33) then
        game:addPortal(game.zone, game.level, "arena")
      else
        game:addPortal(game.zone, game.level, "lava")
      end
      self.portal_count = self.portal_count - 1
    end
  end,
}
