instructions = [line.rstrip('\n')
                for line in open('input.txt', 'r').readlines()]
cycle = 1
pointer = 0
register = 1

CRT = [['.' for i in range(40)] for j in range(6)]
row_sizes = [(40 * (i + 1)) for i in range(6)]
row_pointer = 0

need = {'noop': 1, 'addx': 2}
queue = None

while cycle < 240:
    # START
    if queue == None:
        _type = 'noop' if instructions[pointer].startswith('noop') else 'addx'
        _add = 0 if instructions[pointer].startswith(
            'noop') else int(instructions[pointer].split()[1])

        queue = [_add, need[_type]]

    # DURING
    if cycle > row_sizes[row_pointer]:
        row_pointer += 1

    # END
    if (queue[1] == 1):
        register += queue[0]
        pointer += 1
        queue = None
    else:
        queue[1] -= 1

    if register - (cycle % 40) in [0, 1, -1]:
        CRT[row_pointer][cycle % 40] = '#'

    cycle += 1


for line in CRT:
    for char in line:
        print(char, end='')
    print()
