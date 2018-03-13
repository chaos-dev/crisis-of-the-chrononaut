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
    define_as = "BASE_SPEAR",
    slot = "WEAPON",
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 3,
    rarity = 5,
    name = "a generic spear",
    desc = [[A spear from ice age times.]],
}

newEntity{ base = "BASE_SPEAR",
    name = "crude spear",
    level_range = {1, 10},
    wielder = {
      combat = { dam = 3, },
    }
}

newEntity{
  define_as = "SWORD",
  slot = "WEAPON",
  type = "weapon", subtype="sword",
  name = "longsword",
  display = "\\", color=colors.GREY,
    level_range = {1, nil},
  encumber = 3,
  rarity = 5,
  wielder = {
    combat = { dam = 4, },
  },
  desc = [[A longsword]],
}

newEntity{
  define_as = "GREATSWORD",
  slot = "WEAPON",
  type = "weapon", subtype="sword",
  display = "\\", color=colors.GREY,
    level_range = {1, nil},
  encumber = 3,
  rarity = 5,
  wielder = {
    combat = { dam = 5, },
  },
  desc = [[A greatsword]],
}

newEntity{
    define_as = "FUR_ARMOR",
    slot = "ARMOR",
    type = "armor", subtype="fur",
    display = "(", color=colors.CHOCOLATE,
    encumber = 3,
    rarity = 5,
    name = "fur coat",
    desc = [[A heavy coat of fur.]],
    wielder = {
      combat_armor = 3
    }
}

newEntity{
    define_as = "FULL_PLATE",
    slot = "ARMOR",
    type = "armor", subtype="plate",
    display = "[", color=colors.GREY,
    encumber = 3,
    rarity = 5,
    name = "plate armor",
    desc = [[A full set of plate armor.]],
    wielder = {
      combat_armor = 8
    }
}

newEntity{
    define_as = "CHAINMAIL",
    slot = "ARMOR",
    type = "armor", subtype="plate",
    display = "(", color=colors.GREY,
    encumber = 3,
    rarity = 5,
    name = "chainmail",
    desc = [[A full set of chainmail.]],
    wielder = {
      combat_armor = 5
    }
}

newEntity{
    define_as = "WOODEN_SHIELD",
    slot = "SHIELD",
    type = "shield", subtype="wooden",
    display = "o", color=colors.CHOCOLATE,
    encumber = 3,
    rarity = 5,
    name = "wooden shield",
    desc = [[A small wooden shield.]],
    wielder = {
      combat_armor = 1
    }
}

newEntity{
    define_as = "METAL_SHIELD",
    slot = "SHIELD",
    type = "shield", subtype="metal",
    display = "o", color=colors.GREY,
    encumber = 3,
    rarity = 5,
    name = "metal shield",
    desc = [[A large metal shield.]],
    wielder = {
      combat_armor = 2
    }
}
