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
local Mouse = require "engine.Mouse"

module(..., package.seeall, class.make)

function _M:init(x, y, w, h, bgcolor, font, size)
  self.display_x = x
  self.display_y = y
  self.w, self.h = w, h
  self.bgcolor = bgcolor
  self.font = core.display.newFont(font, size)
  self.fontbig = core.display.newFont(font, size * 2)
  self.mouse = Mouse.new()
  self.tex_cache = {textures={}, texture_bars={}}
  self:resize(x, y, w, h)
  self.first_appearance = true
end

local function glTexFromArgs(tex, tw, th, _, _, w, h)
  return {_tex = tex, _tex_w = tw, _tex_h = th, w=w, h=h}
end

--- Resize the display area
function _M:resize(x, y, w, h)
  self.display_x, self.display_y = x, y
  self.mouse.delegate_offset_x = x
  self.mouse.delegate_offset_y = y
  self.w, self.h = w, h
  self.font_h = self.font:lineSkip()
  self.font_w = self.font:size(" ")
  self.bars_x = self.font_w * 15
  self.bars_w = self.w - self.bars_x - 5

  self.surface = core.display.newSurface(w, h)
  self.surface_line = core.display.newSurface(w, self.font_h)
  self.texture = self.surface:glTexture()

  self.items = {}
end

function _M:makeTexture(text, x, y, r, g, b, max_w)
  max_w = max_w or self.w
  -- Check for cache
  local cached = self.tex_cache.textures[text]
  local cached_ok = cached and cached.r == r and cached.g == g and cached.b == b and cached.max_w == max_w
  if not cached_ok then
    local item = self.font:draw(text, max_w, r, g, b, true)[1]
    item = {r=r, g=g, b=b, max_w = max_w, item}
    self.tex_cache.textures[text] = item
    cached = item
  end
  self.items[#self.items+1] = {cached[1], x=x, y=y}

  return self.w, self.font_h, x, y
end

local function samecolor(c1, c2)
  return (c1 == c2) or (c1.r == c2.r and c1.g == c2.g and c1.b == c2.b)
end

function _M:makeTextureBar(text, nfmt, val, max, reg, x, y, r, g, b, bar_col, bar_bgcol)
  local cached = self.tex_cache.texture_bars[text]
  -- it's a bunch of number comparisons so it's sufficiently fast for jit
  local cached_ok = cached and (nfmt == cached.nfmt) and (val == cached.val) and (max == cached.max) and (reg == cached.reg) and
  (r == cached.r) and (g == cached.g) and (b == cached.b) and samecolor(bar_col, cached.bar_col) and samecolor(bar_bgcol, cached.bar_bgcol)
  if not cached_ok then
    local items = {}
    local text_w = self.font:size(text)
    items[#items+1] = function(disp_x, disp_y)
      core.display.drawQuad(disp_x + self.bars_x, disp_y, self.bars_w, self.font_h, bar_bgcol.r, bar_bgcol.g, bar_bgcol.b, 255)
    end
    items[#items+1] = function(disp_x, disp_y)
      core.display.drawQuad(disp_x + self.bars_x, disp_y, self.bars_w * val / max, self.font_h, bar_col.r, bar_col.g, bar_col.b, 255)
    end
    items[#items+1] = {self.font:draw(text, self.w, r, g, b, true)[1], x=0, y=0}
    items[#items+1] = {self.font:draw((nfmt or "%d/%d"):format(val, max), self.w, r, g, b, true)[1], x=self.bars_x + 3, y=0}

    if reg and reg ~= 0 then
      local reg_txt = (" (%s%.2f)"):format((reg > 0 and "+") or "",reg)
      local reg_txt_w = self.font:size(reg_txt)
      items[#items+1] = {tex, x = self.bars_x + self.bars_w - self.font:size(reg_txt) - 3, y=0}
    end
    cached = {nfmt=nfmt, val=val, max=max, reg=reg, r=r, g=g, b=b, bar_col=bar_col, bar_bgcol=bar_bgcol, items}
    self.tex_cache.texture_bars[text] = cached
  end
  local items = cached[1]
  for i = 1,#items do
    if type(items[i]) == "table" then
      self.items[#self.items+1] = {items[i][1], x=x+items[i].x, y=y+items[i].y}
    else
      self.items[#self.items+1] = function(dx, dy) return items[i](dx + x, dy + y) end
    end
  end

  return self.w, self.font_h, x, y
end

-- Displays the stats
function _M:display()
  local player = game.player
  if not self.first_appearance and (not player or not player.changed or not game.level) then return end

  self.mouse:reset()
  self.items = {}

  local h = 6
  local x = 3

  self.font:setStyle("bold")
  self:makeTexture(("%s#{normal}#        Level: %2d"):format(player.name, player.level), x, h, 255, 255, 255, self.w) h = h + self.font_h
  self.font:setStyle("normal")

  local cur_exp, max_exp = player.exp, player:getExpChart(player.level+1)
  local exp = cur_exp / max_exp * 100

  h = h + self.font_h

  self:makeTextureBar("Exp:", "%d%%", exp, 100, nil, x, h, 255, 255, 255, { r=0, g=100, b=0 }, { r=0, g=50, b=0 }) h = h + self.font_h

  h = h + self.font_h

  if player.life < player.max_life*0.3 then
    local life = math.max(0, player.life)
    self:makeTextureBar("#FIREBRICK#Life:", nil, life, player.max_life, nil, x, h, 255, 255, 255, colors.FIREBRICK, colors.VERY_DARK_RED)
    h = h + self.font_h
  elseif player.life < player.max_life*0.5 then
    self:makeTextureBar("#DARK_RED#Life:", nil, player.life, player.max_life, nil, x, h, 255, 255, 255, colors.DARK_RED, colors.VERY_DARK_RED)
    h = h + self.font_h
  else
    local life = math.min(player.max_life, player.life)
    self:makeTextureBar("#CRIMSON#Life:", nil, life, player.max_life, nil, x, h, 255, 255, 255, colors.CRIMSON, colors.VERY_DARK_RED)
    h = h + self.font_h
  end


  --inform the player it's a worldmap
  h = h + self.font_h
  self:makeTexture(("%s"):format(game.zone.name), x, h, 240, 240, 170)
  h = h + self.font_h
  if game.zone.year then
    self:makeTexture(("Year: %s"):format(game.zone.year), x, h, 240, 240, 170)
  h = h + self.font_h
  end
  if game.zone.location then
    self:makeTexture(("Location: %s"):format(game.zone.location), x, h, 240, 240, 170)
  h = h + self.font_h
  end

  h = h + self.font_h

  if savefile_pipe.saving then
    h = h + self.font_h
    self:makeTextureBar("Saving:", "%d%%", 100 * savefile_pipe.current_nb / savefile_pipe.total_nb, 100, nil, x, h, colors.YELLOW.r, colors.YELLOW.g, colors.YELLOW.b,
    {r=49, g=54,b=42},{r=17, g=19, b=0})

    h = h + self.font_h
  end

  self.first_appearance = false
end

function _M:toScreen(nb_keyframes)
  self:display()

  for i = 1, #self.items do
    local item = self.items[i]
    if type(item) == "table" then
      local glow = 255
      if item.glow then
        glow = (1+math.sin(core.game.getTime() / 500)) / 2 * 100 + 120
      end
      local tex = item[1]
      tex._tex:toScreenFull(self.display_x + item.x, self.display_y + item.y, tex.w, tex.h, tex._tex_w, tex._tex_h, 1, 1, 1, glow / 255)
    else
      item(self.display_x, self.display_y)
    end
  end
end
