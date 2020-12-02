local values = {}
for line in io.lines('data.txt') do
  table.insert(values, tonumber(line))
end
table.sort(values)

-- find three entries that sum to target
function getThreeValuesSumToTarget(targetValue)
  local firstNum = nil
  local secondNum = nil
  local thirdNum = nil
  while #values > 0 do
    firstNum = table.remove(values, 1)
    for i = 1, #values-1 do
      secondNum = values[i]
      for j = 2, #values do
        thirdNum = values[j]
        total = firstNum + secondNum + thirdNum
        if total == targetValue then
          return firstNum, secondNum, thirdNum
        elseif total > targetValue then
          break
        end
      end
    end
  end
end

local n1, n2, n3 = getThreeValuesSumToTarget(2020)
print('Multiplied value:', n1 * n2 * n3)