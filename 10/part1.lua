function getAdapters(source)
  local list = {}
  for line in io.lines(source) do
    table.insert(list, tonumber(line))
  end
  return list
end

local adapters = getAdapters('data.txt')
table.sort(adapters)

local previousValue = 0
local diffOf1 = 0
local diffOf3 = 1 -- end device always has a diff of 3
for _, value in ipairs(adapters) do
local diff = value - previousValue
if diff == 1 then
  diffOf1 = diffOf1 + 1
elseif diff == 3 then
  diffOf3 = diffOf3 + 1
end
previousValue = value
end

print('1 diff:', diffOf1, '3 diff:', diffOf3, 'muliplied:', diffOf1 * diffOf3)