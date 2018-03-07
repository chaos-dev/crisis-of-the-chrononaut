-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009 - 2017 Nicolas Casalini
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

load("/data/general/grids/basic.lua")

newEntity{
  define_as = "RUBBLE",
  name = "burnt rubble",
  display = '%', color_r=27, color_g=29, color_b=31, back_color=colors.APO_DARKBLUE,
  does_block_move = true,
  always_remember = true,
  can_pass = {pass_wall=1},
  block_sight = false,
}

newEntity{
  define_as = "APO_FLOOR",
  name = "floor",
  display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.APO_BLUE,
}

newEntity{
  define_as = "APO_DIRT",
  name = "floor",
  display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.APO_DIRT,
}

newEntity{
  define_as = "APO_WALL",
  name = "wall",
  display = '#', color_r=28, color_g=33, color_b=31, back_color=colors.APO_WALL,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
  air_level = -20,
  dig = "APO_FLOOR",
}

newEntity{
  define_as = "CRUMBLING_WALL",
  name = "crumbling wall",
  display = '#', color_r=28, color_g=33, color_b=31, back_color=colors.APO_DIRT,
  always_remember = true,
  dig = "APO_DIRT",
}

newEntity{
  define_as = "APO_DOOR",
  name = "door",
  display = '+', color_r=39, color_g=22, color_b=15,
  back_color=colors.APO_RED,
  notice = true,
  always_remember = true,
  block_sight = true,
  door_opened = "APO_DOOR_OPEN",
  dig = "APO_DOOR_OPEN",
}

newEntity{
  define_as = "APO_DOOR_OPEN",
  name = "open door",
  display = "'", color_r=48, color_g=43, color_b=41,
  back_color=colors.APO_BLUE,
  always_remember = true,
  door_closed = "APO_DOOR",
}

newEntity{
  define_as = "APO_GATE",
  name = "gate",
  display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
  notice = true,
  always_remember = true,
  block_sight = true,
  door_opened = "APO_GATE_OPEN",
  dig = "APO_GATE_OPEN",
}

newEntity{
  define_as = "APO_GATE_OPEN",
  name = "gate",
  display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
  always_remember = true,
  door_closed = "APO_GATE",
}
