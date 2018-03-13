-- Crisis of the Chrononaut
-- Copyright (C) 2009, 2010 Nicolas Casalini
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
  name = "Gladiator Arena",
  year = "100 AD",
  location = "Roman Empire",
  level_scheme = "fixed",
  decay = {300, 800},
  max_level = 1,
  width = 26, height = 21,
  persistent = "zone",
  all_lited = true,
  all_remembered = true,

  generator =  {
    map = {
      class = "engine.generator.map.Static",
      map = "zones/arena",
    },
    actor = {
      class = "engine.generator.actor.Random",
      nb_npc = {8, 10},
      filters = {{type="arena"}},
    },
  },
  on_enter = function(lev, old_lev, newzone)
    local Dialog = require("engine.ui.Dialog")
    if not game.level.shown_warning then

      game.level.shown_warning = true
      Dialog:simpleLongPopup("@", [[
         ]], 500)
    end
  end,
  on_turn = function(self)
    if not self.portal_count then self.portal_count = 0 end
    if (game.turn % 10 == 1) then
      local fill_ratio = 1/2
      local map_area = self.width*self.height
      local scaling = 0.5 + game.turn_counter / game.max_turns
      local portals_per_turn = fill_ratio*map_area / game.max_turns * scaling
      self.portal_count = self.portal_count + portals_per_turn
    end
    while self.portal_count > 1 do
      if rng.percent(33) then
        game:addPortal(game.zone, game.level, "pirate")
      else
        game:addPortal(game.zone, game.level, "lava")
      end
      self.portal_count = self.portal_count - 1
    end
  end,
}
