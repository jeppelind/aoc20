local ACCUMULATOR = 'acc' JUMP = 'jmp' NO_OP = 'nop'

function getInstruction(source)
  local list = {}
  for line in io.lines(source) do
    local operation, argument = string.match(line, '(%w+)%s+([+-]%d+)')
    table.insert(list, { operation = operation, argument = tonumber(argument) })
  end
  return list
end

function runInstructions(instructions)
  local accumulatorValue = 0
  local usedInstructions = {}
  local nextInstruction = 1
  while true do
    if nextInstruction > #instructions then -- all instructions have run
      return accumulatorValue
    elseif usedInstructions[nextInstruction] then -- only run each instruction once
      return false
    end

    usedInstructions[nextInstruction] = true
    local instruction = instructions[nextInstruction]
    if instruction.operation == ACCUMULATOR then
      accumulatorValue = accumulatorValue + instruction.argument
    end
    nextInstruction = instruction.operation == JUMP and nextInstruction + instruction.argument or nextInstruction + 1
  end
end

function runUntilTermination(instructions)
  for i, instruction in ipairs(instructions) do
    if instruction.operation ~= ACCUMULATOR then
      local instructionsCopy = copyTable2(instructions)
      instructionsCopy[i].operation = instruction.operation == JUMP and NO_OP or JUMP
      local successfulRes = runInstructions(instructionsCopy)
      if successfulRes then
        return successfulRes
      end
    end
  end
end

function copyTable2(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copyTable2(k, s)] = copyTable2(v, s) end
  return res
end

local instructions = getInstruction('data.txt')
print('Accumulator value after full run:', runUntilTermination(instructions))