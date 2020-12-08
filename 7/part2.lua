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

function getChildBagCount(parentBag, bags)
  local childBags = 0
  for name, count in pairs(parentBag) do
    childBags = childBags + count + count * getChildBagCount(bags[name], bags)
  end
  return math.floor(childBags)
end

local targetBag = "shiny gold"
local bagList = getBagList('data.txt')
print('Bags contained in "' .. targetBag .. '":', getChildBagCount(bagList[targetBag], bagList))