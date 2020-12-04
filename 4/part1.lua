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
  local requiredKeys = {'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'}
  for _, passport in ipairs(passports) do
    if tableContainsKeys(passport, requiredKeys) then
      table.insert(validPassports, passport)
    end
  end
  return validPassports
end

function tableContainsKeys(table, keys)
  for i = 1, #keys do
    if table[keys[i]] == nil then
      return false
    end
  end
  return true
end

local passports = getPassportsFromFile('data.txt')
local validPassports = getValidPassports(passports)

print(#validPassports)