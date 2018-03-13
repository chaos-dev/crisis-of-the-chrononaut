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
  name = "Ice Age",
  year = "9000 Years Ago",
  location = "Unknown",
  level_range = {1, 1},
  max_level = 10,
  width = 70, height = 70,
  persistent = "zone",
  all_lited = true,
  generator =  {
    map = {
      class = "engine.generator.map.Forest",
      sqrt_percent = 80,
      floor = "ICE_GROUND",
      wall = "ICE_TREE",
      up = "ICE_GROUND",
      down = "ICE_GROUND",
      door = "ICE_DOOR",
      do_ponds = {
        nb = {2, 4},
        size = {w=25, h=25},
        pond = {{0.6, "ICE_LAKE"}, {0.8, "ICE_LAKE"}},
      },
      nb_rooms = {5},
      rooms ={"lesser_vault"},
      lesser_vaults_list = {"small_hut"},
      filters = { {max_ood=2}, },
      lite_room_chance = 100,
    },
    actor = {
      class = "engine.generator.actor.Random",
      nb_npc = {10, 12},
      filters = {{type="ice_age"}},
    },
    object = {
    },
  },
  levels = { },

  on_enter = function(self)
    if game.player then
      -- Change the player to black so they stand out
      game.player.color_r = 0
      game.player.color_g = 0
      game.player.color_b = 0
      game.player._mo:invalidate()
      game.level.map:updateMap(game.player.x, game.player.y)
    end
  end,

  on_leave = function(self)
    if game.player then
      -- Change the player back to white
      game.player.color_r = 255
      game.player.color_g = 255
      game.player.color_b = 255
      game.player._mo:invalidate()
      game.level.map:updateMap(game.player.x, game.player.y)
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
      elseif rng.percent(50) then
        game:addPortal(game.zone, game.level, "arena")
      else
        game:addPortal(game.zone, game.level, "cretaceous")
      end
      self.portal_count = self.portal_count - 1
    end
  end,
}
