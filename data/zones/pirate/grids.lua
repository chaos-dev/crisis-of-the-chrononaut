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
  define_as = "DEEP_WATER",
  name = "water",
  display = '~',
  color=colors.LIGHT_STEEL_BLUE,
  back_color=colors.STEEL_BLUE,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = false,
}

newEntity{
  define_as = "SAND",
  name = "sand",
  display = ' ',
  back_color=colors.TAN,
}

newEntity{
  define_as = "SHIP_FLOOR",
  name = "wooden floor",
  display = ' ',
  back_color=colors.LIGHT_UMBER,
}

newEntity{
  define_as = "SHIP_RAIL",
  name = "wooden floor",
  display = '|',
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
}

newEntity{
  define_as = "SHIP_WALL",
  name = "wooden wall",
  display = '#',
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
}

newEntity{
  define_as = "MAST",
  name = "wooden mast",
  display = '*',
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
}

newEntity{
  define_as = "CANNON",
  name = "metal cannon",
  display = '#',
  color=colors.SLATE,
  back_color=colors.LIGHT_UMBER,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = false,
}

newEntity{
  define_as = "SHIP_DOOR",
  name = "wooden door",
  display = '+',
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
  notice = true,
  always_remember = true,
  block_sight = true,
  door_opened = "SHIP_DOOR_OPEN",
}

newEntity{
  define_as = "SHIP_DOOR_OPEN",
  name = "open door",
  display = "'",
  color=colors.LIGHT_UMBER,
  back_color=colors.UMBER,
  always_remember = true,
  door_closed = "SHIP_DOOR_OPEN",
}
