local passwords = {}
for line in io.lines('data.txt') do
  table.insert(passwords, line)
end

local validPasswords = {}
for _,passwordData in ipairs(passwords) do
  local pattern = '(%d+)-(%d+)%s+(%a+):%s+(%a+)'
  local minCount, maxCount, letter, password = string.match(passwordData, pattern)
  local letterCount = select(2, string.gsub(password, letter, ''))
  if letterCount >= tonumber(minCount) and letterCount <= tonumber(maxCount) then
    table.insert(validPasswords, password)
  end
end

print('Total passwords:', #passwords)
print('Valid passwords:', #validPasswords)