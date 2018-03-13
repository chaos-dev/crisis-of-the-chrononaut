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
border = 1
rotates = {"default", "90", "180", "270", "flipx", "flipy"}

defineTile('.', "ICE_GROUND")
defineTile('#', "ICE_WALL")
defineTile('+', "ICE_DOOR", nil, nil, nil, {room_map = {can_open=true}})
defineTile('^', "ICE_FIRE")
defineTile('(', "ICE_GROUND", "FUR_ARMOR")
defineTile('M', "ICE_GROUND", nil, "CAVEMAN")
defineTile('F', "ICE_GROUND", nil, "CAVEWOMAN")

return {
[[...........]],
[[....#.#....]],
[[...##+##...]],
[[..##...##..]],
[[.##(..M.##.]],
[[.##..^..##.]],
[[.##..F..##.]],
[[..##...##..]],
[[...#####...]],
[[....###....]],
[[...........]],
}
