function getInstruction(source)
  local list = {}
  for line in io.lines(source) do
    local operation, argument = string.match(line, '(%w+)%s+([+-]%d+)')
    table.insert(list, { operation = operation, argument = tonumber(argument) })
  end
  return list
end

function runInstructions(instructions)
  local ACCUMULATOR = 'acc' JUMP = 'jmp' NO_OP = 'nop'
  local accumulatorValue = 0
  local usedInstructionSteps = {}
  local nextInstruction = 1
  while usedInstructionSteps[nextInstruction] == nil do -- only run each instruction once
    usedInstructionSteps[nextInstruction] = true
    local instruction = instructions[nextInstruction]
    if instruction.operation == ACCUMULATOR then
      accumulatorValue = accumulatorValue + instruction.argument
    end
    nextInstruction = instruction.operation == JUMP and nextInstruction + instruction.argument or nextInstruction + 1
  end
  print("Accumulator value:", accumulatorValue)
end

local instructions = getInstruction('data.txt')
runInstructions(instructions)