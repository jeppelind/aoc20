local seats = {}
for line in io.lines('data.txt') do
  table.insert(seats, line)
end

function getSeatIDs()
  local totalRows = 128
  local totalColumns = 8
  local seatIDs = {}
  for _, seat in ipairs(seats) do
    local row = getValue(string.sub(seat, 1, 7), totalRows, 'F')
    local column = getValue(string.sub(seat, 8), totalColumns, 'L')
    local seatID = row * 8 + column
    seatIDs[seatID] = true
  end
  return seatIDs
end

function getValue(letters, maxNum, lowerSectionLetter)
  local minNum = 1
  for i = 1, string.len(letters) do
    local letter = string.sub(letters, i, i)
    local diff = math.abs(minNum - maxNum)
    local change = math.floor(diff / 2 + 0.5)
    if letter == lowerSectionLetter then
      maxNum = maxNum - change
    else
      minNum = minNum + change
    end
  end
  return minNum - 1 -- Result expected to be zero indexed
end

function getEmptySeatWithSurroundingOccupied()
  local seatIDs = getSeatIDs()
  for i = 1, #seatIDs do
    if seatIDs[i] == nil and seatIDs[i-1] ~= nil and seatIDs[i+1] ~= nil then
      return i
    end
  end
end

print('Empty seat:', getEmptySeatWithSurroundingOccupied())