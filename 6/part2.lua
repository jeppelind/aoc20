function getGroupAnswers()
  local groups = {{['groupSize'] = 0}}
  for line in io.lines('data.txt') do
    if line == '' then
      table.insert(groups, {['groupSize'] = 0})
    else
      local group = groups[#groups]
      group.groupSize = group.groupSize + 1
      for i = 1, string.len(line) do
        local char = string.sub(line, i, i)
        group[char] = group[char] and group[char] + 1 or 1
      end
    end
  end
  return groups
end

function getUnanimousPositiveAnswersTotal()
  local total = 0
  local groups = getGroupAnswers()
  for _, group in ipairs(groups) do
    for question, positiveCount in pairs(group) do
      if positiveCount == group.groupSize and question ~= 'groupSize' then
        total = total + 1
      end
    end
  end
  return total
end

print('Sum of unanimous positive answers:', getUnanimousPositiveAnswersTotal())