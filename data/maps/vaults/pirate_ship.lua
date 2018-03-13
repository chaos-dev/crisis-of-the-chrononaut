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

setStatusAll{room_map = {can_open=true}}
border = 0
no_tunnels = true
rotates = {"default", "90", "180", "270", "flipx", "flipy"}

defineTile('~', "DEEP_WATER")
defineTile('#', "SHIP_WALL")
defineTile('|', "SHIP_RAIL")
defineTile('.', "SHIP_FLOOR")
defineTile('+', "SHIP_DOOR", nil, nil, nil, {room_map = {can_open=true}})
defineTile('*', "MAST")
defineTile('=', "CANNON")
defineTile('P', "SHIP_FLOOR", nil, "PIRATE")
defineTile('C', "SHIP_FLOOR", nil, "CAPTAIN")

return {
[[~~~~~~~~~~~~~]],
[[~~~~~~|~~~~~~]],
[[~~~~~~|~~~~~~]],
[[~~~~~|.|~~~~~]],
[[~~~~|..P|~~~~]],
[[~~~|.....|~~~]],
[[~~~|....P|~~~]],
[[~~|.......|~~]],
[[~~|P......|~~]],
[[~~|.......|~~]],
[[~|.........|~]],
[[~=....*....=~]],
[[~|........P|~]],
[[~|.........|~]],
[[~|....*....|~]],
[[~=.........=~]],
[[~|.........|~]],
[[~|.........|~]],
[[~#####+#####~]],
[[~#.........#~]],
[[~#..C......#~]],
[[~##.......##~]],
[[~~#########~~]],
[[~~~~~~~~~~~~~]],
}
