function getSeats(source)
  local list = {}
  for line in io.lines(source) do
    local row = {}
    for i = 1, string.len(line) do
      table.insert(row, string.sub(line, i, i))
    end
    table.insert(list, row)
  end
  return list
end

function getFinalOccupiedSeatCount(seats)
  local finalSeating = getFinalSeating(seats)
  local occupiedSeats = 0
  for _, row in ipairs(finalSeating) do
    for _, seat in ipairs(row) do
      if seat == '#' then
        occupiedSeats = occupiedSeats + 1
      end
    end
  end
  return occupiedSeats
end

function getFinalSeating(previousSeating)
  local isSeatingFinal = true
  local updatedSeating = {}
  for rowIdx, row in ipairs(previousSeating) do
    local newRow = {}
    table.insert(updatedSeating, newRow)
    for seatIdx, seat in ipairs(row) do
      local seatChar = seat
      if seat ~= '.' then
        local occupiedAdjacentSeats = getVisiblyOccupiedSeats(rowIdx, seatIdx, previousSeating)
        if seat == 'L' and occupiedAdjacentSeats == 0 then
          seatChar = '#'
        elseif seat == '#' and occupiedAdjacentSeats > 4 then
          seatChar = 'L'
        end
      end
      if seat ~= seatChar then
        isSeatingFinal = false
      end
      table.insert(newRow, seatChar)
    end
  end

  if isSeatingFinal then
    return updatedSeating
  else
    return getFinalSeating(updatedSeating)
  end
end

function getVisiblyOccupiedSeats(rowIdx, seatIdx, seats)
  local occupied = 0
  local directions = {{0,-1}, {1,-1}, {1,0}, {1,1}, {0,1}, {-1,1}, {-1,0}, {-1,-1}}
  for _, direction in ipairs(directions) do
    if isSeatOccupiedInDirection(rowIdx, seatIdx, direction, seats) then
      occupied = occupied + 1
    end
  end
  return occupied
end

function isSeatOccupiedInDirection(rowIdx, seatIdx, direction, seats)
  local row = rowIdx + direction[2]
  local column = seatIdx + direction[1]
  if seats[row] == nil or seats[row][column] == nil then return false end -- end of table

  local nextSeat = seats[row][column]
  if nextSeat == '#' then
    return true
  elseif nextSeat == 'L' then
    return false
  else
    return isSeatOccupiedInDirection(row, column, direction, seats)
  end
end

function printSeats(seats)
  for _, row in pairs(seats) do
    local rowString = ''
    for _, seat in pairs(row) do
      rowString = rowString .. seat
    end
    print(rowString)
  end
end

local seats = getSeats('data.txt')
print('Occupied seats:', getFinalOccupiedSeatCount(seats))