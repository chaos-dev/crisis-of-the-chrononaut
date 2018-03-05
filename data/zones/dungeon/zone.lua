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

return {
  name = "Old ruins",
  level_range = {1, 1},
  max_level = 10,
  decay = {300, 800},
  width = 50, height = 50,
  persistent = "zone",
  generator =  {
    map = {
      class = "engine.generator.map.Roomer",
      nb_rooms = 10,
      rooms = {"simple", "pilar"},
      lite_room_chance = 100,
      ['.'] = "FLOOR",
      ['#'] = "WALL",
      up = "UP",
      down = "DOWN",
      door = "DOOR",
    },
    actor = {
      class = "engine.generator.actor.Random",
      nb_npc = {20, 30},
      --      guardian = "SHADE_OF_ANGMAR", -- The guardian is set in the static map
    },
  },
  levels =
  {
  },
  post_process = function(level)
    level.turn_counter = 0
  end,

  on_turn = function(self)
    if not game.level.turn_counter then return end
    --paranoia alert
    if game.level.turn_counter < 0 then game.level.turn_counter = 0 end

    game.level.turn_counter = game.level.turn_counter + 1

    --Every 5 player turns
    if game.level.turn_counter % 50 == 0 then
      --generate an opponent
      local m = game.zone:makeEntity(game.level, "actor", f, nil, true)
      if m then
        local x, y = rng.range(0, game.level.map.w-1), rng.range(0, game.level.map.h-1)
        local tries = 0
        while not m:canMove(x,y) and tries < 100 do
          x, y = rng.range(0, game.level.map.w-1), rng.range(0, game.level.map.h-1)
          tries = tries + 1
        end
        if tries < 100 then
          game.zone:addEntity(game.level, m, "actor", x, y)
          game.log("Added an entity!")
        else
          game.log("Failed to add an entity!")
        end
      end
    end
  end,
}
