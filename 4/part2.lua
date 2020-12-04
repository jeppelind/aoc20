function getPassportsFromFile(filename)
  local passports = {{}}
  local currIdx = 1
  for line in io.lines(filename) do
    if line == '' then
      currIdx = currIdx + 1
      table.insert(passports, {})
    else
      for keyValue in string.gmatch(line, '%S+') do
        local key, value = string.match(keyValue, '(.*):(.*)')
        passports[currIdx][key] = value
      end
    end
  end
  return passports
end

function getValidPassports(passports)
  local validPassports = {}
  for _, passport in ipairs(passports) do
    if passportContainsValidValues(passport) then
      table.insert(validPassports, passport)
    end
  end
  return validPassports
end

function passportContainsValidValues(passport)
  return isValidNumberSpan(passport['byr'], 1920, 2002) and
    isValidNumberSpan(passport['iyr'], 2010, 2020) and
    isValidNumberSpan(passport['eyr'], 2020, 2030) and
    isValidHeight(passport['hgt']) and
    isValidHairColor(passport['hcl']) and
    isValidEyeColor(passport['ecl']) and
    isValidPassportID(passport['pid'])
end

function isValidNumberSpan(num, minVal, maxVal)
  return num ~= nil and tonumber(num) >= minVal and tonumber(num) <= maxVal
end

function isValidHeight(height)
  if height == nil then return false end
  local measurement = string.sub(height, -2)
  if measurement == 'cm' then
    return isValidNumberSpan(string.sub(height, 1, string.len(height)-2), 150, 193)
  elseif measurement == 'in' then
    return isValidNumberSpan(string.sub(height, 1, string.len(height)-2), 59, 76)
  end
  return false
end

function isValidHairColor(color)
  if color == nil then return false end
  local hash, colorCode = string.match(color, '(%W+)(%w+)')
  return hash == '#' and string.len(colorCode) == 6
end

function isValidEyeColor(color)
  local validColors = {['amb'] = true, ['blu'] = true, ['brn'] = true, ['gry'] = true,
                       ['grn'] = true, ['hzl'] = true, ['oth'] = true}
  return validColors[color] ~= nil
end

function isValidPassportID(id)
  return id ~= nil and string.len(string.match(id, '(%d+)')) == 9
end

local passports = getPassportsFromFile('data.txt')
local validPassports = getValidPassports(passports)

print('Num of valid passports:', #validPassports)