-- Helpers for doing object-oriented programming. Example:
--
--   my = oo.namespace()
--
--   my.Shape = oo.class({x = 1})
--
--   function my.Shape:new()
--     return oo.instance(my.Shape, {r = 0, g = 255, b = 0})
--   end
--
--   function my.Shape:colour()
--     return {r, g, b}
--   end
--
--   my.Triangle = oo.subclass(my.Shape)
--
--   function my.Triangle:new()
--     local self = oo.instance(my.Triangle, my.Shape:new())
--     self.z = 3
--     return self
--   end

oo = {}

function oo.instance(klass, data)
  local result = data or {}
  klass.__index = klass
  setmetatable(result, klass)
  return result
end

oo.subclass = oo.instance

function oo.class(data)
  return data or {}
end

oo.namespace = oo.class
