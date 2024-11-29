from sys import stdin
import re

lines = [line.strip('\n') for line in stdin]
i = 0
while lines[i] != '':
    i += 1

levels = []
for line in lines[:i-1]:
    levels.append(re.split(r'\s{4}|\s+', re.sub(r'[\[\]]', '', line)))

instructions = lines[i+1:]
number_of_stacks = len(lines[i-1].strip(' ').split())
stacks = [[] for i in range(number_of_stacks)]
for level in levels:
    for crate in range(number_of_stacks):
        if level[crate] != '':
            stacks[crate].append(level[crate])

for instruction in instructions:
    instruction = re.split(r'move\s|\sfrom\s|\sto\s', instruction)
    instruction.pop(0)  # na zacatku je jeden ''
    instruction = list(map(int, instruction))
    for moves in range(instruction[0]):
        crate = stacks[instruction[1]-1].pop(0)
        stacks[instruction[2]-1].insert(0, crate)
for last in stacks:
    print(last[0], end=' ')
print()
