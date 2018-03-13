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
  define_as = "NPC_GUARD",
  type = "human", subtype = "adult",
  name = "The Inventor",
  display = "I", color=colors.STEEL_BLUE,
  faction = "players",
  unique = true,
  desc = [[The great scientist Dmitri Aion.]],

  ai = "dumb_talented_simple", ai_state = { talent_in=3, },
  stats = { str=10 },
  combat_armor = 2,
  level_range = {1, 4}, exp_worth = 1,
  max_life = 25,
  combat = { dam=4 },
  stamina_cost = 8,

  body = { INVEN = 10, WEAPON=1, ARMOR=1, SHIELD=1 },
  copy = {
  },

  can_talk = "inventor",
  no_wander = "true",
}
