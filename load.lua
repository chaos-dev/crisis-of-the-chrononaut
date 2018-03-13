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

-- This file loads the game module, and loads data
local KeyBind = require "engine.KeyBind"
local DamageType = require "engine.DamageType"
local ActorStats = require "engine.interface.ActorStats"
local ActorResource = require "engine.interface.ActorResource"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorAI = require "engine.interface.ActorAI"
local ActorLevel = require "engine.interface.ActorLevel"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Birther = require "engine.Birther"
local UIBase = require "engine.ui.Base"
local ActorInventory = require "engine.interface.ActorInventory"

dofile('/data/colors.lua')

-- Init settings
dofile("/mod/settings.lua")

-- Useful keybinds
KeyBind:load("move,inventory,actions,interface,debug")

-- Additional entity resolvers
dofile("/mod/resolvers.lua")

-- Damage types
DamageType:loadDefinition("/data/damage_types.lua")

-- Talents
ActorTalents:loadDefinition("/data/talents.lua")

-- Timed Effects
ActorTemporaryEffects:loadDefinition("/data/timed_effects.lua")

-- Actor resources
ActorResource:defineResource("Power", "power", nil, "power_regen", "Power represent your ability to use special talents.")

-- Actor stats
ActorStats:defineStat("Strength",	"str", 10, 1, 100, "Strength represets your ability to cause damage.")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")

-- Factions
dofile('/data/factions.lua')

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

-- Equipment slots
ActorInventory:defineInventory("WEAPON", "Weapon", true, "Weapon used for melee or ranged combat")
ActorInventory:defineInventory("ARMOR", "Armor", true, "Armor worn to protect the torso.")
ActorInventory:defineInventory("SHIELD", "Shield", true, "Shields carried in your free hand.")

-- Gui Specification
UIBase.ui = "simple"

return {require "mod.class.Game" }
