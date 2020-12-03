local data = {}
for line in io.lines('data.txt') do
  table.insert(data, line)
end

local treesHit = 0
local rowPosition = 1

for i = 2, #data do
  rowPosition = rowPosition + 3
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

print('Trees hit:', treesHit)