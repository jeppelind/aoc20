function parseData(source)
  io.input(source)
  local values = {}
  local timestamp = tonumber(io.read('*line'))
  for value in string.gmatch(io.read('*line'), '(%P+)') do
    table.insert(values, value)
  end
  return values
end

function getTimestamp(values)
  -- get departure time where all following buses leave 1 min after the previous one
  local buses = {}
  local offsets = {}
  for i, value in ipairs(values) do
    if value ~= 'x' then
      table.insert(buses, tonumber(value))
      table.insert(offsets, i-1) -- offset by one minute per bus
    end
  end

  print(buses[1], buses[1])
  local currentBus = 2 -- start checking at second bus
  local interval = buses[1]
  local timestamp = 0
  while currentBus <= #buses do
    timestamp = timestamp + interval
    local timestampOffset = timestamp + offsets[currentBus]
    if timestampOffset / buses[currentBus] % 1 == 0 then
      print(buses[currentBus], timestamp)
      interval = interval * buses[currentBus] -- update interval by multiplying with current bus interval. Increasing timestamp in valid increments for previous bus.
      currentBus = currentBus + 1
    end
  end
  return timestamp
end

local startTime = os.clock()
local data = parseData('data.txt')
print('Got timestamp:', getTimestamp(data), 'Time taken: ' .. os.clock() - startTime)