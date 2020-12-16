local lon = 0 lat = 0
local waypoint = { x = 10, y = 1}

function updateWaypoint(direction, value)
  if direction == 'N' then
    waypoint.y = waypoint.y + value
  elseif direction == 'S' then
    waypoint.y = waypoint.y - value
  elseif direction == 'E' then
    waypoint.x = waypoint.x + value
  elseif direction == 'W' then
    waypoint.x = waypoint.x - value
  end
end

for line in io.lines('data.txt') do
  local instruction, value = string.match(line, '(%a+)(%d+)')
  value = tonumber(value)
  if instruction == 'L' or instruction == 'R' then
    local rotations = math.floor(value / 90)
    for i = 1, rotations do
      local newY = instruction == 'R' and waypoint.x * -1 or waypoint.x
      local newX = instruction == 'R' and waypoint.y or waypoint.y * -1
      waypoint.x = newX
      waypoint.y = newY
    end
  elseif instruction == 'F' then
    lon = lon + waypoint.x * value
    lat = lat + waypoint.y * value
  else
    updateWaypoint(instruction, value)
  end
end

print(math.abs(lon) + math.abs(lat))