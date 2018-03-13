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
  define_as = "MACHINE",
  type="machine", subtype="time",
  name = "Time machine",
  desc = "The broken time machine sits there, crackling and humming.",
  display = "M",
  color = colors.LAVA_BLUE, color_bg=colors.LAVA_ROCK,
  ai = "none",
  stats = { str=5 },
  combat_armor = 4,
  level_range = {1, 1}, exp_worth = 1,
  rarity = 1,
  max_life = 50,
  combat = { dam=0 },
  combat_armor = 1,
  faction = "machine",
  destructible = true,

  on_die = function()
    -- You've won the game!
    game.player.winner = true
    game:registerDialog(require("mod.dialogs.WinDialog").new(game.player))
  end,
}

newEntity{
  define_as = "INTERLOPER",
  faction = "boss",
  name = "Interloper",
  desc = "A nightmarish giant that seems to be made of shadows.  It has dark, hairless skin and lidless black eyes.  There are long claws on its hands, each bigger than your face.",
  display = "I",
  color = colors.LAVA_DARKESTBLUE, color_bg=colors.LAVA_ROCK,
  ai = "dumb_talented_simple",
  stats = { str=22 },
  combat_armor = 6,
  level_range = {1, 1}, exp_worth = 1,
  rarity = 1,
  max_life = 100,
  combat = { dam=10 },
  on_die = function()
    game.log("The interloper lets out a bone-chilling shriek as its body melts away into shadow.")
  end,
}
