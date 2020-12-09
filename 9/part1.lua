function getNumbers(source)
  local list = {}
  for line in io.lines(source) do
    table.insert(list, tonumber(line))
  end
  return list
end

function getFirstNumberNotSumOfPrevious(numbers, preambleSize)
  for i = preambleSize + 1, #numbers do
    local currNum = numbers[i]
    if not isSumOfPreviousPreamble(currNum, i-preambleSize, i-1, numbers) then
      return currNum
    end
  end
end

function isSumOfPreviousPreamble(target, startIdx, endIdx, numbers) 
  for i = startIdx, endIdx do
    for j = startIdx + 1, endIdx do
      if numbers[i] + numbers[j] == target then
        return true
      end
    end
  end
  return false
end

local preambleSize = 25
local numbers = getNumbers('data.txt')
print('First not sum of previous:', getFirstNumberNotSumOfPrevious(numbers, preambleSize))