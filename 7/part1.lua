function trim(str)
  return string.match(str, '^%s*(.-)%s*$')
end

function getBagList(source)
  local bagList = {}
  for line in io.lines(source) do
    local bagCount = 1
    local key = nil
    for str in string.gmatch(line, '(.-)bag') do
      if bagCount == 1 then
        key = trim(str)
        bagList[key] = {}
      else
        local quantity, bagType = string.match(str, '(%d)(.*)')
        if quantity and bagType then
          bagList[key][trim(bagType)] = quantity
        end
      end
      bagCount = bagCount + 1
    end
  end
  return bagList
end

function getNumberOfParentBags(target, bags)
  local count = 0
  for name, contents in pairs(bags) do
    if name ~= target then
      if bagContainsTarget(target, contents, bags) then
        count = count + 1
      end
    end
  end
  return count
end

function bagContainsTarget(target, bagContents, bags)
  if bagContents[target] ~= nil then
    return true
  else
    for key, _ in pairs(bagContents) do
      if bagContainsTarget(target, bags[key], bags) then
        return true
      end
    end
  end
  return false
end

local targetBag = "shiny gold"
local bagList = getBagList('data.txt')
print('Bags containing "' .. targetBag .. '":', getNumberOfParentBags(targetBag, bagList))