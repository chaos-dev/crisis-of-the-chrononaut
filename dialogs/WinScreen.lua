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


require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
  self.actor = actor

  -- TODO: Fix font...
  self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
  Dialog.init(self, "Character Sheet: "..self.actor.name, math.min(game.w * 0.7, 475), 250, nil, nil, font)

  self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}
  self.c_accept = Button.new{text="Exit to main menu",fct=function() self:onEnd("accept") end}

  self:loadUI{
    {left=0, top=0, ui=self.c_desc},
    {left=0, bottom=0, ui=self.c_accept},
  }

  self:setupUI()

  self:drawDialog()

  self.key:addBind("EXIT", function() util.showMainMenu() end)
end

function _M:onEnd(result)
  util.showMainMenu()
end

function _M:drawDialog()
  local player = self.actor
  local s = self.c_desc.s

  s:erase(0,0,0,0)

  local h = 0
  local w = 0
  local score = 0
  local temp = 0

  h = 0
  w = 0

  s:drawStringBlended(self.font, "Congraulations! You have won Crisis of the Chrononaut", w, h, 255, 255, 255, true) h = h + self.font_h
  s:drawStringBlended(self.font, "Name : "..(player.name or "Player"), w, h, 255, 255, 255, true) h = h + self.font_h

  self.c_desc:generate()
  self.changed = false
end
