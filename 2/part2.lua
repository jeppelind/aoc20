local passwords = {}
for line in io.lines('data.txt') do
  table.insert(passwords, line)
end

local validPasswords = {}
for _,passwordData in ipairs(passwords) do
  local pattern = '(%d+)-(%d+)%s+(%a+):%s+(%a+)'
  local idx1, idx2, letter, password = string.match(passwordData, pattern)
  local char1 = string.sub(password, idx1, idx1)
  local char2 = string.sub(password, idx2, idx2)
  if char1 ~= char2 and (letter == char1 or letter == char2) then
    table.insert(validPasswords, password)
  end
end

print('Total passwords:', #passwords)
print('Valid passwords:', #validPasswords)