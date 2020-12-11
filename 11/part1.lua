function tableDeepCompare(t1, t2, ignoreMeta)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  local mt = getmetatable(t1)
  if not ignoreMeta and mt and mt.__eq then return t1 == t2 end
  for k1, v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not tableDeepCompare(v1,v2) then return false end
  end
  for k2, v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not tableDeepCompare(v1,v2) then return false end
  end
  return true
end

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
  local updatedSeating = {}
  for rowIdx, row in ipairs(previousSeating) do
    local newRow = {}
    table.insert(updatedSeating, newRow)
    for seatIdx, seat in ipairs(row) do
      local seatChar = seat
      if seat ~= '.' then
        local occupiedAdjacentSeats = getOccupiedAdjacentSeats(seatIdx, rowIdx, previousSeating)
        if seat == 'L' and occupiedAdjacentSeats == 0 then
          seatChar = '#'
        elseif seat == '#' and occupiedAdjacentSeats > 3 then
          seatChar = 'L'
        end
      end
      table.insert(newRow, seatChar)
    end
  end
  if tableDeepCompare(previousSeating, updatedSeating) then
    return updatedSeating
  else
    return getFinalSeating(updatedSeating)
  end
end

function getOccupiedAdjacentSeats(seatIdx, rowIdx, seats)
  local occupied = 0
  for row = rowIdx-1, rowIdx+1 do
    if row > 0 and row <= #seats then
      for seat = seatIdx-1, seatIdx+1 do
        if (seat ~= seatIdx or row ~= rowIdx) then
          if seats[row][seat] == '#' then
            occupied = occupied + 1
          end
        end
      end
    end
  end
  return occupied
end

local seats = getSeats('data.txt')
print('Occupied seats:', getFinalOccupiedSeatCount(seats))