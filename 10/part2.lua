function getAdapters(source)
  local list = {}
  for line in io.lines(source) do
    table.insert(list, tonumber(line))
  end
  return list
end

function getTotalPaths(adapters)
local pathsToAdapter = {}
for i = 1, #adapters do -- Init table size
  pathsToAdapter[i] = 0
end

for i = 0, #adapters do
  local pathsToCurrentAdapter = i > 0 and pathsToAdapter[i] or 1 -- Start with one path
  local adapterValue = i > 0 and adapters[i] or 0 -- Start at value zero
  local nextIdx = i + 1
  local validIncrease = isValidIncrease(adapterValue, adapters[nextIdx])
  while validIncrease do
    pathsToAdapter[nextIdx] = pathsToAdapter[nextIdx] + pathsToCurrentAdapter -- Add current number of paths to upcoming index
    nextIdx = nextIdx + 1
    validIncrease = isValidIncrease(adapterValue, adapters[nextIdx])
  end
end
return pathsToAdapter[#adapters]
end

function isValidIncrease(from, to)
if to == nil then return false end
local diff = to - from
return diff <= 3
end

local adapters = getAdapters('data.txt')
table.sort(adapters)
print('Total possible arrangements:', getTotalPaths(adapters))