function getNumbers(source)
  local list = {}
  for line in io.lines(source) do
    table.insert(list, tonumber(line))
  end
  return list
end

function getFirstNumberNotSumOfPreviousPreamble(numbers, preambleSize)
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

function getEncryptionWeakness(invalidNum, numbers)
  local sumNumbers = getContiguousNumbersSumToTarget(invalidNum, numbers)
  table.sort(sumNumbers)
  return sumNumbers[1] + sumNumbers[#sumNumbers] -- weakness is smallest and largest numbers combined
end

function getContiguousNumbersSumToTarget(target, numbers)
  for i = 1, #numbers do
    local sum = numbers[i]
    local sumNumbers = {numbers[i]}
    for j = i+1, #numbers do
      sum = sum + numbers[j]
      table.insert(sumNumbers, numbers[j])
      if sum == target then
        return sumNumbers
      elseif sum > target then
        j = #numbers
      end
    end
  end
end

local preambleSize = 25
local numbers = getNumbers('data.txt')
local invalidNum = getFirstNumberNotSumOfPreviousPreamble(numbers, preambleSize)
print('Encryption weakness:', getEncryptionWeakness(invalidNum, numbers))
