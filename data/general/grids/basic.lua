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

newEntity{
  define_as = "UP_WILDERNESS",
  name = "exit to the wilds",
  display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
  always_remember = true,
  notice = true,
  change_level = 1,
  change_zone = "wilderness",
}

newEntity{
  define_as = "DINO_PORTAL",
  name = "A strange, shimmering portal",
  display = 'O', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
  always_remember = true,
  notice = true,
  on_move = function(self, x, y, who)
    -- TODO: Allow portals to move other entities
    if not who.player then return end
    game:changeLevel(1, "cretaceous", {direct_switch=true})
  end
}

newEntity{
  define_as = "STARTINGROOM_PORTAL",
  name = "A strange, shimmering portal",
  display = 'O', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
  always_remember = true,
  notice = true,
  on_move = function(self, x, y, who)
    -- TODO: Allow portals to move other entities
    if not who.player then return end
    game:changeLevel(1, "startingroom", {direct_switch=true})
  end
}

newEntity{
  define_as = "UP",
  name = "previous level",
  display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
  notice = true,
  always_remember = true,
  change_level = -1,
}

newEntity{
  define_as = "DOWN",
  name = "next level",
  display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
  notice = true,
  always_remember = true,
  change_level = 1,
}

newEntity{
  define_as = "FLOOR",
  name = "floor", image = "terrain/marble_floor.png",
  display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

newEntity{
  define_as = "WALL",
  name = "wall", image = "terrain/granite_wall1.png",
  display = '#', color_r=255, color_g=255, color_b=255, back_color=colors.GREY,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = true,
  air_level = -20,
  dig = "FLOOR",
}

newEntity{
  define_as = "DOOR",
  name = "door", image = "terrain/granite_door1.png",
  display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
  notice = true,
  always_remember = true,
  block_sight = true,
  door_opened = "DOOR_OPEN",
  dig = "DOOR_OPEN",
}

newEntity{
  define_as = "DOOR_OPEN",
  name = "open door", image = "terrain/granite_door1_open.png",
  display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
  always_remember = true,
  door_closed = "DOOR",
}

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

newEntity{
  define_as = "DEEP_WATER",
  name = "water",
  display = '~',
  color_r = 62, color_g = 83, color_b = 100, back_color=colors.DINO_DARKBLUE,
  always_remember = true,
  does_block_move = true,
  can_pass = {pass_wall=1},
  block_sight = false,
  air_level = -20,
  dig = "DINO_WATER",
}
