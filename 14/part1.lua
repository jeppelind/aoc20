local memory = {}
local mask = nil

function toBits(num,bits)
  bits = bits or math.max(1, select(2, math.frexp(num)))
  local t = {}       
  for b = bits, 1, -1 do
      t[b] = string.format(math.fmod(num, 2)) -- save as string without decimals
      num = math.floor((num - t[b]) / 2)
  end
  return t
end

for line in io.lines('data.txt') do
  local instruction, memoryAddr, value = string.match(line, '(%a+)%[*(%d*)]*%s=%s(%w+)')
  if instruction == 'mask' then
    mask = value
  elseif instruction == 'mem' then
    local bits = toBits(tonumber(value), 36)
    for i = 1, string.len(mask) do -- replace bit with bitmask
      if string.sub(mask, i, i) ~= 'X' then
        bits[i] = string.sub(mask, i, i)
      end
    end
    memory[memoryAddr] = tonumber(table.concat(bits), 2)
  end
end

local sumValues = 0
for _, value in pairs(memory) do
  sumValues = sumValues + value
end

print('Sum of values in memory:', sumValues)