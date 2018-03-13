-- Broken Bottle - 7DRL
-- Copyright (C) 2011 Darren Grey
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


--- Resolves equipment creation for an actor
function resolvers.equip(t)
  return {__resolver="equip", __resolve_last=true, t}
end

--- Actually resolve the equipment creation
function resolvers.calc.equip(t, e)
  print("Equipment resolver for", e.name)
  -- Iterate of object requests, try to create them and equip them
  for i, filter in ipairs(t[1]) do
    print("Equipment resolver", e.name, filter.type, filter.subtype, filter.defined)
    local o
    if not filter.defined then
      o = game.zone:makeEntity(game.level, "object", filter, nil, true)
    else
      local forced
      o, forced = game.zone:makeEntityByName(game.level, "object", filter.defined, filter.random_art_replace and true or false)
      -- If we forced the generation this means it was already found
      if forced then
        print("Serving unique "..o.name.." but forcing replacement drop")
        filter.random_art_replace.chance = 100
      end
    end
    if o then
      print("Zone made us an equipment according to filter!", o:getName())

      e:wearObject(o, true, false)

      game.zone:addEntity(game.level, o, "object")

    end
  end
  -- Delete the origin field
  return nil
end

--- Resolves inventory creation for an actor
function resolvers.inventory(t)
  return {__resolver="inventory", __resolve_last=true, t}
end
--- Actually resolve the inventory creation
function resolvers.calc.inventory(t, e)
  -- Iterate of object requests, try to create them and equip them
  for i, filter in ipairs(t[1]) do
    print("Inventory resolver", e.name, filter.type, filter.subtype)
    local o
    if not filter.defined then
      o = game.zone:makeEntity(game.level, "object", filter, nil, true)
    else
      o = game.zone:makeEntityByName(game.level, "object", filter.defined)
    end
    if o then
      print("Zone made us an inventory according to filter!", o:getName())
      e:addObject(t[1].inven and e:getInven(t[1].inven) or e.INVEN_INVEN, o)
      game.zone:addEntity(game.level, o, "object")

    end
  end
  e:sortInven()
  -- Delete the origin field
  return nil
end

--- Resolves drops creation for an actor
function resolvers.drops(t)
  return {__resolver="drops", __resolve_last=true, t}
end
--- Actually resolve the drops creation
function resolvers.calc.drops(t, e)
  t = t[1]
  if not rng.percent(t.chance or 100) then return nil end

  -- Iterate of object requests, try to create them and drops them
  for i = 1, (t.nb or 1) do
    local filter = t[rng.range(1, #t)]

    print("Drops resolver", e.name, filter.type, filter.subtype, filter.defined)
    local o
    if not filter.defined then
      o = game.zone:makeEntity(game.level, "object", filter, nil, true)
    else
      o = game.zone:makeEntityByName(game.level, "object", filter.defined)
    end
    if o then
      print("Zone made us a drop according to filter!", o:getName())
      e:addObject(e.INVEN_INVEN, o)
      game.zone:addEntity(game.level, o, "object")

    end
  end
  -- Delete the origin field
  return nil
end

--- Generic resolver, takes a function, executes at the end
function resolvers.genericlast(fct)
  return {__resolver="genericlast", __resolve_last=true, fct}
end
function resolvers.calc.genericlast(t, e)
  return t[1](e)
end
