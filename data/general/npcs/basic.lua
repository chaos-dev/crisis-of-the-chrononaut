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

local Talents = require("engine.interface.ActorTalents")

newEntity{
  define_as = "BASE_DINOSAUR",
  type = "dinosaur", subtype="dino",
  display = "k", color=colors.WHITE,
  ai = "dumb_talented_simple", ai_state = { talent_in=3, },
  stats = { str=5, dex=5, con=5 },
  combat_armor = 0,
  faction = "dinosaur",
}

newEntity{
  base = "BASE_DINOSAUR",
  name = "Velociraptor",
  desc = "It looks like a six-foot turkey. A six-foot turkey with six-inch retractable claw that it will use to slice your belly and spill out your intestines.",
  display = "r", color=colors.RED,
  level_range = {1, 4}, exp_worth = 1,
  rarity = 4,
  max_life = resolvers.rngavg(5,9),
  combat = { dam=2 },
}

newEntity{
  base = "BASE_DINOSAUR",
  name = "Pteranodon",
  desc = "A huge animal that looks like a cross between a lizard, a bat, and a bird.",
  display='V', color=colors.RED,
  level_range = {6, 10}, exp_worth = 1,
  rarity = 4,
  max_life = resolvers.rngavg(10,12),
  combat_armor = 3,
  combat = { dam=5 },
}
