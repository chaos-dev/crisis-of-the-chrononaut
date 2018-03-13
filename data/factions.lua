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

Faction:add{name="carnivore", reaction={}}
Faction:add{name="herbivore", reaction={}}
Faction:add{name="machine", reaction={}}
Faction:add{name="boss", reaction={}}
Faction:add{name="cavemen", reaction={}}
Faction:setInitialReaction("carnivore", "players", -50, true)
Faction:setInitialReaction("carnivore", "machine", 100, true)
Faction:setInitialReaction("carnivore", "cavemen", -50, true)
Faction:setInitialReaction("carnivore", "boss", 100, true)
Faction:setInitialReaction("carnivore", "herbivore", -100, true)
Faction:setInitialReaction("boss", "players", -100, true)
