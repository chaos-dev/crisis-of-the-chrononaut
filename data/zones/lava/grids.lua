-- Crisis of the Chrononaut
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

load("/data/general/grids/basic.lua")

newEntity{
  define_as = "LAVA",
  name = "Glowing Lava",
  display = '~',
  color = colors.LAVA_YELLOW, back_color=colors.LAVA_ORANGE,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = false,
  air_level = -20,
  dig = "LAVA",
  lit = true,
}

newEntity{
  define_as = "HOT_ROCK",
  name = "Molten volcanic rock",
  display = '~',
  color=colors.LAVA_ORANGE, back_color=colors.LAVA_RED,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = false,
  air_level = -20,
  dig = "HOT_ROCK",
  lit = true,
}

newEntity{
  define_as = "LAVA_ROCK",
  name = "Volcanic rock",
  display = ' ',
  color_r=255, color_g=255, color_b=255, back_color=colors.LAVA_BLACK,
}
