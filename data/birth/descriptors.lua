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



newBirthDescriptor{
  type = "base",
  name = "base",
  desc = {
  },
  experience = 1.0,
  body = { INVEN = 10, WEAPON = 1, ARMOR = 1, SHIELD = 1 },

  copy = {
    max_level = 20,
    lite = 6,
    max_life = 25,
    stats = {str = 12},
  },
}

newBirthDescriptor{
  type = "role",
  name = "Destroyer",
  desc =
  {
    "Crashhhhh!",
  },
  talents = {
    [ActorTalents.T_KICK]=1,
  },
}
