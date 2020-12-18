function parseData(source)
  io.input(source)
  local values = {}
  local timestamp = tonumber(io.read('*line'))
  string.gsub(io.read('*line'), '%d+', function(d) table.insert(values, tonumber(d)) end)
  return timestamp, values
end

function getClosestDepature(target, values)
  local closest = 9999999
  local busID = nil
  for _, bus in ipairs(values) do
    local waitTime = (math.ceil(target / bus) * bus) - target
    if waitTime < closest then
      closest = waitTime
      busID = bus
    end
  end
  return busID, closest
end

local timestamp, data = parseData('data.txt')
local busID, waitTime = getClosestDepature(timestamp, data)
print(busID * waitTime)