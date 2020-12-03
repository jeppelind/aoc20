local data = {}
for line in io.lines('data.txt') do
  table.insert(data, line)
end

function calculateTreesHit(verticalIncrement, horizontalIncrement)
  local treesHit = 0
  local rowPosition = 1
  for i = verticalIncrement+1, #data, verticalIncrement do
    rowPosition = rowPosition + horizontalIncrement
    local row = data[i]
    local rowPositionOverflow = rowPosition - string.len(row)
    if rowPositionOverflow > 0 then
      rowPosition = rowPositionOverflow
    end
    local charAtPos = string.sub(row, rowPosition, rowPosition)
    if charAtPos == '#' then
      treesHit = treesHit + 1
    end
  end
  return treesHit
end

local mutliplicativeTreesHit = 1
local paths = {{1, 1}, {1, 3}, {1, 5}, {1, 7}, {2, 1}}
for _, path in ipairs(paths) do
  local treesHitInPath = calculateTreesHit(path[1], path[2])
  mutliplicativeTreesHit = mutliplicativeTreesHit * treesHitInPath
end

print('Multiplicative trees hit:', mutliplicativeTreesHit)