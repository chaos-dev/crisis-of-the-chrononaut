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
  define_as = "DINO_TREE",
  name = "large tree",
  display = 'T',
  color_r = 9, color_g = 47, color_b = 32, back_color=colors.DINO_DARKGREEN,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
  air_level = -20,
  dig = "FLOOR",
}

newEntity{
  define_as = "DINO_GRASS",
  name = "grass",
  display = ' ',
  color_r = 9, color_g = 47, color_b = 32, back_color=colors.DINO_GREEN,
  always_remember = true,
  does_block_move = false,
  can_pass = {pass_wall=1},
  block_sight = false,
  air_level = -20,
  dig = "DINO_GROUND",
}

newEntity{
  define_as = "DINO_TALLGRASS",
  name = "tall grass",
  display = 'v',
  color_r = 9, color_g = 47, color_b = 32, back_color=colors.DINO_GREEN,
  always_remember = true,
  does_block_move = false,
  can_pass = {pass_wall=1},
  block_sight = true,
  air_level = -20,
  dig = "DINO_GROUND",
}

newEntity{
  define_as = "DINO_GROUND",
  name = "dirt",
  display = ' ',
  color_r=255, color_g=255, color_b=255, back_color=colors.DINO_BROWN,
}
