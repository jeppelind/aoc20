local values = {}
for line in io.lines('data.txt') do
  table.insert(values, tonumber(line))
end
table.sort(values)

-- find two entries that sum to target
local TARGET = 2020
local targetFound = false
local firstNum = nil
local secondNum = nil
while not targetFound and #values > 0 do
  firstNum = table.remove(values, 1)
  for _,number in ipairs(values) do
    local total = firstNum + number
    if total == TARGET then
      targetFound = true
      secondNum = number
      break
    elseif total > TARGET then
      break
    end
  end
end

print('Multiplied value:', firstNum * secondNum)