function toBits(num,bits)
  bits = bits or math.max(1, select(2, math.frexp(num)))
  local t = {}       
  for b = bits, 1, -1 do
      t[b] = string.format(math.fmod(num, 2)) -- save as string without decimals
      num = math.floor((num - t[b]) / 2)
  end
  return t
end

function copyTable(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copyTable(k, s)] = copyTable(v, s) end
  return res
end

function getBinaryCombinations(bits, res)
  if res == nil then res = {} end

  local idx = nil
  for i,v in ipairs(bits) do
    if v == 'X' then
      idx = i
    end
  end

  if idx == nil then
    table.insert(res, table.concat(bits))
    return res
  end

  local t1 = copyTable(bits)
  local t2 = copyTable(bits)
  t1[idx] = '0'
  t2[idx] = '1'
  return getBinaryCombinations(t1, res), getBinaryCombinations(t2, res)
end

function runInstructions(source, memory)
  local mask = nil
  for line in io.lines(source) do
    local instruction, memoryAddr, value = string.match(line, '(%a+)%[*(%d*)]*%s=%s(%w+)')
    if instruction == 'mask' then
      mask = value
    elseif instruction == 'mem' then
      local bits = toBits(tonumber(memoryAddr), 36)

      for i = 1, string.len(mask) do
        local char = string.sub(mask, i, i)
        if char ~= '0' then
          bits[i] = char
        end
      end

      local bitAddresses = getBinaryCombinations(bits)
      for _, bitAddr in ipairs(bitAddresses) do
        memory[tonumber(bitAddr, 2)] = value
      end
    end
  end
end

function getSumarizedMemoryValues(memory)
  local sumValues = 0
  for _, value in pairs(memory) do
    sumValues = sumValues + value
  end
  return string.format('%.0f', sumValues) -- don't show .0 after int value
end

local memory = {}
runInstructions('data.txt', memory)
print('Sum of values in memory:', getSumarizedMemoryValues(memory))