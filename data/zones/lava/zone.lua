-- Crisis of the Chrononaut
-- Copyright (C) 2009, 2010 Nicolas Casalini
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



return {
  name = "Primeval Earth",
  decay = {300, 800},
  level_range = {1, 1},
  max_level = 10,
  width = 75, height = 75,
  persistent = "zone",
  generator =  {
    map = {
      class = "engine.generator.map.Forest",
      sqrt_percent = 95,
      sqrt_percent2 = 40,
      floor = "LAVA_ROCK",
      floor2 = "HOT_ROCK",
      wall = "LAVA",
      up = "LAVA_ROCK",
      down = "LAVA_ROCK",
      door = "DOOR",
      do_ponds = {
        nb = {8, 10},
        size = {w=25, h=25},
        pond = {{0.6, "LAVA"}, {0.8, "LAVA"}},
      },
    },
    actor = {
      class = "engine.generator.actor.Random",
      nb_npc = {0,0},
    },
  },
  levels = { },

  post_process = function(self)
    -- Build up a lighting table
    local radius = 1
    self.map.lights = {}
    for x=1,self.map.w do
      for y=1,self.map.h do
        if self.map:checkEntity(x, y, game.level.map.TERRAIN, "lit") then
          for tx=math.max(1,x-radius),math.min(self.map.w,x+radius) do
            for ty=math.max(1,y-radius),math.min(self.map.h,y+radius) do
              local dist = math.sqrt((tx-x)*(tx-x) + (ty-y)*(ty-y))
              local light = math.max(1 - (dist/(radius+1))^3, 0)
              if not self.map.lights[tx] then self.map.lights[tx] = {} end
              if not self.map.lights[tx][ty] or self.map.lights[tx][ty] < light then
                self.map.lights[tx][ty] = light*20/17
              end
            end
          end
        end
      end
    end
    -- Apply lights
    for x=1,self.map.w do
      for y=1,self.map.h do
        if self.map.lights[x] and self.map.lights[x][y] then
          self.map.lites(x, y, self.map.lights[x][y])
        end
      end
    end
  end,

  on_turn = function(self)
    if (game.turn % 10 == 1) then
      if self.create_boss then
        local m = game.zone:makeEntityByName(game.level, "actor", "INTERLOPER")
        if m then
          local tx, ty = util.findFreeGrid(game.player.x, game.player.y, 5, false, {[engine.Map.ACTOR]=true})
          game.zone:addEntity(game.level, m, "actor", tx, ty)
          local Dialog = require("engine.ui.Dialog")
          Dialog:simpleLongPopup("You're not alone here...", "You hear a piercing shriek as a temoral rift opens nearby.  At first there appear to be nothing but shadows emerging out of the portal.  But your heart runs cold as you see the figure fully emerge.\n\nStanding in front of you is a nightmarish giant that seems to be made of shadows.  It has dark, hairless skin and lidless black eyes.  It clicks its long claws together as it advances toward you.", 500)
          self.boss_entered = true
          self.create_boss = false
        end
      end
      if not self.boss_entered and not self.create_boss then
        -- Create the boss next turn
        self.create_boss = true
      end
    end

    if not self.portal_count then self.portal_count = 0 end
    if (game.turn % 10 == 1) then
      local fill_ratio = 1/9
      local map_area = self.width*self.height
      local scaling = 0.5 + game.turn_counter / game.max_turns
      local portals_per_turn = fill_ratio*map_area / game.max_turns * scaling
      self.portal_count = self.portal_count + portals_per_turn
    end
    while self.portal_count > 1 do
      if rng.percent(50) then
        game:addPortal(game.zone, game.level, "pirate")
      else
        game:addPortal(game.zone, game.level, "arena")
      end
      self.portal_count = self.portal_count - 1
    end
  end,

  on_enter = function(self)
    -- Place the machine
    local m = game.zone:makeEntityByName(game.level, "actor", "MACHINE")
    local tx, ty = util.findFreeGrid(game.player.x, game.player.y, 5, false, {[engine.Map.ACTOR]=true})
    game.zone:addEntity(game.level, m, "actor", tx, ty)
  end,
}
