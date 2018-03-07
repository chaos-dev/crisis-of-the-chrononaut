-- Broken Bottle - 7DRL
-- Copyright (C) 2011 Darren Grey
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


newChat{
  id="inventor",
  text = [["Oh, where could that machine have gone? @playername@, I need your help to find it and stop it by any means necessary. Otherwise its Tachyon core might destabilize and rend apart time as we know it!"]],
  answers = {
    {[["Alright, I'll go find it!"]]},
    {[["Where might I find it?"]], jump="finding"},
  }
}

newChat{
  id="finding",
  text = [["Erm... well, it's certainly not here... And it might be in some other time or place for that matter. If I had the time machine, we might be able to travel to another time...

By jove, what is that strange light over there?!?"]],
  answers = {
    {[["I'm not sure.  I'll go investigate."]],
     action = function(npc, player)
       player:useEnergy(game.energy_to_act)
     end
   }
  }
}

return "inventor"
