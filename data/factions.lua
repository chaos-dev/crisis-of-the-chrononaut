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

local Faction = require "engine.Faction"

Faction:add{name="ice_carnivore", reaction={}}
Faction:add{name="arena_carnivore", reaction={}}
Faction:add{name="dino_carnivore", reaction={}}
Faction:add{name="pirates", reaction={}}
Faction:add{name="herbivore", reaction={}}
Faction:add{name="machine", reaction={}}
Faction:add{name="boss", reaction={}}
Faction:add{name="cavemen", reaction={}}
Faction:setInitialReaction("ice_carnivore", "players", -50, true)
Faction:setInitialReaction("ice_carnivore", "pirates", -25, true)
Faction:setInitialReaction("ice_carnivore", "dino_carnivore", -25, true)
Faction:setInitialReaction("ice_carnivore", "arena_carnivore", -25, true)
Faction:setInitialReaction("ice_carnivore", "cavemen", -50, true)
Faction:setInitialReaction("ice_carnivore", "boss", -100, true)
Faction:setInitialReaction("ice_carnivore", "herbivore", -100, true)
Faction:setInitialReaction("dino_carnivore", "players", -50, true)
Faction:setInitialReaction("dino_carnivore", "pirates", -25, true)
Faction:setInitialReaction("dino_carnivore", "ice_carnivore", -25, true)
Faction:setInitialReaction("dino_carnivore", "arena_carnivore", -25, true)
Faction:setInitialReaction("dino_carnivore", "cavemen", -50, true)
Faction:setInitialReaction("dino_carnivore", "boss", -100, true)
Faction:setInitialReaction("dino_carnivore", "herbivore", -100, true)
Faction:setInitialReaction("arena_carnivore", "players", -50, true)
Faction:setInitialReaction("arena_carnivore", "pirates", -25, true)
Faction:setInitialReaction("arena_carnivore", "ice_carnivore", -25, true)
Faction:setInitialReaction("arena_carnivore", "dino_carnivore", -25, true)
Faction:setInitialReaction("arena_carnivore", "cavemen", -50, true)
Faction:setInitialReaction("arena_carnivore", "boss", -100, true)
Faction:setInitialReaction("arena_carnivore", "herbivore", -100, true)
Faction:setInitialReaction("pirates", "players", -25, true)
Faction:setInitialReaction("pirates", "arena_animal", -50, true)
Faction:setInitialReaction("pirates", "ice_carnivore", -50, true)
Faction:setInitialReaction("pirates", "dino_carnivore", -50, true)
Faction:setInitialReaction("pirates", "cavemen", -25, true)
Faction:setInitialReaction("pirates", "boss", -100, true)
Faction:setInitialReaction("pirates", "herbivore", 0, true)
Faction:setInitialReaction("cavemen", "players", 0, true)
Faction:setInitialReaction("cavemen", "arena_animal", -50, true)
Faction:setInitialReaction("cavemen", "ice_carnivore", -50, true)
Faction:setInitialReaction("cavemen", "dino_carnivore", -50, true)
Faction:setInitialReaction("cavemen", "pirates", -25, true)
Faction:setInitialReaction("cavemen", "boss", -100, true)
Faction:setInitialReaction("cavemen", "herbivore", 0, true)
Faction:setInitialReaction("boss", "players", -100, true)
