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

if config.settings.cotc_init_settings_ran then return end
config.settings.cotc_init_settings_ran = true

-- Init settings
config.settings.cotc = config.settings.cotc or {}

if not config.settings.cotc.uiset_mode then config.settings.cotc.uiset_mode = "cotc" end

-- Fonts
config.settings.cotc.fonts = config.settings.cotc.fonts or {}
config.settings.cotc.fonts.hud = config.settings.cotc.fonts.hud or {}
config.settings.cotc.fonts.hud.style = config.settings.cotc.fonts.hud.style or "/data/font/DroidSans.ttf"
config.settings.cotc.fonts.hud.size = config.settings.cotc.fonts.hud.size or 14
config.settings.cotc.fonts.tooltip = config.settings.cotc.fonts.tooltip or {}
config.settings.cotc.fonts.tooltip.style = config.settings.cotc.fonts.tooltip.style or "/data/font/DroidSansMono.ttf"
config.settings.cotc.fonts.tooltip.size = config.settings.cotc.fonts.tooltip.size or 14

print("[COTC] Loaded default settings")
