local lon = 0 lat = 0
local directions = { 'N', 'E', 'S', 'W' }
local currentDirection = 2

function updateDirectionWithValue(direction, value)
  if direction == 'N' then
    lat = lat + value
  elseif direction == 'S' then
    lat = lat - value
  elseif direction == 'E' then
    lon = lon + value
  elseif direction == 'W' then
    lon = lon - value
  end
end

for line in io.lines('data.txt') do
  local instruction, value = string.match(line, '(%a+)(%d+)')
  value = tonumber(value)
  if instruction == 'L' or instruction == 'R' then
    local indexChange = math.floor(value / 90)
    currentDirection = instruction == 'L' and currentDirection - indexChange or currentDirection + indexChange
    if currentDirection < 1 then
      currentDirection = currentDirection + #directions
    elseif currentDirection > #directions then
      currentDirection = currentDirection - #directions
    end
  elseif instruction == 'F' then
    updateDirectionWithValue(directions[currentDirection], value)
  else
    updateDirectionWithValue(instruction, value)
  end
end

print(math.abs(lon) + math.abs(lat))