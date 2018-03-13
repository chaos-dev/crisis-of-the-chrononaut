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
  type="cretaceous", subtype="dinosaur",
  display = "k", color=colors.WHITE,
  ai = "simple", ai_state = { talent_in=3, },
}

newEntity{
  base = "BASE_DINOSAUR",
  name = "velociraptor",
  desc = "It looks like a six-foot turkey. A six-foot turkey with six-inch retractable claw that it will use to slice your belly and spill out your intestines.",
  display = "r", color=colors.RED,
  level_range = {1, nil}, exp_worth = 3,
  stats = { str=19 },
  rarity = 1,
  max_life = resolvers.rngavg(20, 48),
  combat = { dam=10 },
  faction = "carnivore",
  combat_armor = 5,
}

newEntity{
  base = "BASE_DINOSAUR",
  name = "pteranodon",
  desc = "A huge animal that looks like a cross between a lizard, a bat, and a bird.",
  display='V', color=colors.RED,
  level_range = {6, 10}, exp_worth = 1,
  stats = { str=21 },
  rarity = 3,
  max_life = resolvers.rngavg(51, 107),
  combat = { dam=13 },
  faction = "carnivore",
  combat_armor = 6,
}

newEntity{
  base = "BASE_DINOSAUR",
  name = "triceratops",
  desc = "A huge animal that looks like a cross between a lizard, a bat, and a bird.",
  display='W', color=colors.RED,
  level_range = {1, nil}, exp_worth = 9,
  rarity = 2,
  max_life = resolvers.rngavg(140,252),
  combat_armor = 8,
  combat = { dam=23 },
  faction = "herbivore",
}

newEntity{
  define_as = "BASE_CAVEMAN",
  type="ice_age", subtype="humanoid",
  display = "@",
  ai = "simple",
  stats = { str=12 },
  combat_armor = 0,
  faction = "cavemen",
  max_life = resolvers.rngavg(6, 27),
  combat = { dam=1 },
  rarity = 3,
  body = { INVEN = 40, WEAPON = 1, ARMOR = 1, SHIELD = 1 }
}

newEntity{
  base = "BASE_CAVEMAN",
  define_as = "CAVEMAN",
  name = "caveman",
  desc = "A large caveman.  He's holding a spear and wears a thick animal hide.",
  color=colors.DARK_BLUE,
  level_range = {1, nil}, exp_worth = 1,
  resolvers.equip{
    {type="weapon", subtype="spear", name = "crude spear"},
    {type="armor", subtype="fur", name="fur coat"}
  },
  can_talk = "caveman",
}

newEntity{
  base = "BASE_CAVEMAN",
  define_as = "CAVEWOMAN",
  name = "cavewoman",
  desc = "A large cavewoman.  She seems more muscular than any woman you've ever met.",
  color=colors.PURPLE,
  level_range = {1, nil}, exp_worth = 1,
  resolvers.equip{
    {type="armor", subtype="fur"}
  },
  can_talk = "cavewoman",
}

newEntity{
  define_as = "GIANT_BEAVER",
  type="ice_age", subtype="animal",
  name = "giant beaver",
  desc = "A beaver that's almost as long as you are tall.",
  display = 'b',
  color=colors.DARK_UMBER,
  ai = "simple",
  stats = { str = 14 },
  combat_armor = 2,
  faction = "herbivore",
  max_life = resolvers.rngavg(3, 24),
  combat = { dam=6 },
  level_range = {1, nil}, exp_worth = 2,
  rarity = 1,
}

newEntity{
  define_as = "SABRE",
  type="ice_age", subtype="animal",
  name = "sabre-toothed tiger",
  desc = "As if tigers weren't scary enough, this one has huge fangs.",
  display = 't',
  color=colors.ORANGE,
  ai = "simple",
  stats = { str = 23 },
  combat_armor = 3,
  faction = "carnivore",
  max_life = resolvers.rngavg(24, 66),
  combat = { dam=12 },
  level_range = {1, nil}, exp_worth = 4,
  rarity = 2,
}

newEntity{
  define_as = "LION",
  type="arena", subtype="animal",
  name = "lion",
  desc = "A fierce looking lion.",
  display = 'l',
  color=colors.GOLD,
  ai = "simple",
  stats = { str = 23 },
  combat_armor = 3,
  faction = "carnivore",
  max_life = resolvers.rngavg(24, 66),
  combat = { dam=12 },
  level_range = {1, nil}, exp_worth = 4,
  rarity = 2,
}

newEntity{
  define_as = "BASE_PIRATE",
  type="pirate", subtype="humanoid",
  color=colors.OLIVE_DRAB,
  ai = "simple",
  combat_armor = 0,
  combat = { dam=1 },
  rarity = 3,
  body = { INVEN = 40, WEAPON = 1, ARMOR = 1, SHIELD = 1 }
}

newEntity{
  base = "BASE_PIRATE",
  define_as = "PIRATE",
  name = "Pirate",
  display = 'P',
  desc = "A greasy looking pirate.",
  level_range = {1, nil}, exp_worth = 1,
  stats = { str=12 },
  max_life = resolvers.rngavg(6, 27),
  resolvers.equip{
    {type="weapon", subtype="sword", name = "longsword"},
  },
}

newEntity{
  base = "BASE_PIRATE",
  define_as = "CAPTAIN",
  name = "Pirate captain",
  desc = "Judging by his fancy hat, you're guessing this is the captain.",
  display = 'C',
  level_range = {1, nil}, exp_worth = 3,
  max_life = resolvers.rngavg(27, 54),
  stats = { str=18 },
  resolvers.equip{
    {type="weapon", subtype="sword", name = "longsword"},
  },
}
