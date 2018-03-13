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



load("/data/general/grids/basic.lua")

newEntity{
  define_as = "ICE_TREE",
  name = "Large pine tree",
  display = 'T',
  color=colors.DARK_TAN, back_color=colors.OLD_LACE,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
}

newEntity{
  define_as = "ICE_LAKE",
  name = "Frozen pond",
  display = '~',
  color=colors.STEEL_BLUE, back_color=colors.LIGHT_STEEL_BLUE,
}

newEntity{
  define_as = "ICE_GROUND",
  name = "Snow",
  display = ' ',
  back_color=colors.OLD_LACE,
}

newEntity{
  define_as = "ICE_WALL",
  name = "thatched wall",
  display = '#',
  color=colors.UMBER,
  back_color=colors.DARK_TAN,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
  air_level = -20,
  dig = "APO_FLOOR",
}

newEntity{
  define_as = "ICE_DOOR",
  name = "wooden door",
  display = '+',
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
  notice = true,
  always_remember = true,
  block_sight = true,
  door_opened = "ICE_DOOR_OPEN",
}

newEntity{
  define_as = "ICE_DOOR_OPEN",
  name = "open door",
  display = "'",
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
  always_remember = true,
  door_closed = "ICE_DOOR",
}

newEntity{
  define_as = "ICE_FIRE",
  name = "small fire",
  display = "^",
  color=colors.GOLD, back_color=colors.ORANGE,
  notice = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
}
