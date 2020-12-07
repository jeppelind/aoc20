function getGroupAnswers()
  local groups = {{}}
  for line in io.lines('data.txt') do
    if line == '' then
      table.insert(groups, {})
    else
      for i = 1, string.len(line) do
        local char = string.sub(line, i, i)
        groups[#groups][char] = true
      end
    end
  end
  return groups
end

function getPositiveAnswersTotal()
  local total = 0
  local groupAnswers = getGroupAnswers()
  for _, group in ipairs(groupAnswers) do
    for _, val in pairs(group) do
      total = total + 1
    end
  end
  return total
end

print('Sum of positive answers:', getPositiveAnswersTotal())