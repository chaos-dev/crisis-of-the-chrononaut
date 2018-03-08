-- ToME - Tales of Middle-Earth
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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

return {
  name = "Inventor's Workshop",
  level_scheme = "fixed",
  decay = {300, 800},
  max_level = 1,
  width = 13, height = 7,
  persistent = "zone",
  all_lited = true,
  all_remembered = true,

  generator =  {
    map = {
      class = "engine.generator.map.Static",
      map = "zones/startingroom",
    },
  },
  on_enter = function(lev, old_lev, newzone)
    local Dialog = require("engine.ui.Dialog")
    if not game.level.shown_warning then

      game.level.shown_warning = true
      Dialog:simpleLongPopup("@", [[
         You're working as an apprentice to a genius inventor.  He's got some
         crazy ideas about a "time-machine" that he thinks he'll get working
         soon.  But one morning, his hand slips, you hear something snap, and...

         There's a tremendous BOOM and a flash of light.  When your vision
         recovers, the machine is nowhere to be found.

         "That machine is still running!" shouts the inventor. "If we don't
         find it and shut it down, it could have cataclysmic effects!"

         "You have to find where that time-machine went, and shut it down!"
         ]], 500)
    end
  end,
  on_turn = function(self)
    if game.turn % 100 == 10 then
      game:addPortal(game.zone, game.level, "cretaceous")
    end
  end,
}
