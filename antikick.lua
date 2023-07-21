local kickMeta = getrawmetatable(game)

setreadonly(kickMeta, false)

kickMeta.__index = function(instance, method)
   if method == 'Kick' or method == 'kick' then
      return nil
   end
   return kickMeta.__index(instance, method)
end
