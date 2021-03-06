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
--



require "engine.class"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"
local Chat = require "engine.Chat" 

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
  local reaction = self:reactionToward(target)
  if reaction < 0 then
    return self:attackTarget(target)
  elseif reaction >= 0 then
    if self.player and target.destructible then
      -- Used for the final boss
      return self:attackTarget(target)
    elseif self.player and target.can_talk then
      local chat = Chat.new(target.can_talk, target, self)
      chat:invoke()
    elseif target.player and self.can_talk then
      local chat = Chat.new(self.can_talk, self, target)
      chat:invoke()
    elseif self.move_others then
      -- Displace
      game.level.map:remove(self.x, self.y, Map.ACTOR)
      game.level.map:remove(target.x, target.y, Map.ACTOR)
      game.level.map(self.x, self.y, Map.ACTOR, target)
      game.level.map(target.x, target.y, Map.ACTOR, self)
      self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
    end
  end
end

--- Makes the death happen!
function _M:attackTarget(target, mult)
  if self.combat then
    local str_bonus = math.floor(self:getStr()-10)/2
    local target_str_bonus = math.floor(target:getStr()-10)/2
    local attack_roll = rng.dice(1,20) + str_bonus
    if attack_roll > 10 + target_str_bonus then
      local dam = self.combat.dam + str_bonus - target.combat_armor
      DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, math.max(0, dam))
    else
      if target == game.player then
        game.log("The %s misses you.", self.name)
      elseif self == game.player then
        game.log("You miss the %s.", target.name)
      end
    end
  end

  -- We use up our own energy
  self:useEnergy(game.energy_to_act)
end
