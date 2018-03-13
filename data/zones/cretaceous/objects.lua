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

newEntity{
    define_as = "BASE_SPEAR",
    slot = "WEAPON",
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 3,
    rarity = 5,
    combat = {},
    name = "a generic spear",
    desc = [[A spear from ice age times.]],
}

newEntity{ base = "BASE_SPEAR",
    name = "crude spear",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = 10,
    },
}
