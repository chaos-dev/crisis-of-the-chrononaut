local Faction = require "engine.Faction"

Faction:add{name="dinosaur", reaction={}}
Faction:setInitialReaction("dinosaur", "players", -100, true)
