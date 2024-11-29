instructions = [line.rstrip('\n')
                for line in open('input.txt', 'r').readlines()]
cycle = 1
pointer = 0
register = 1

cycles_of_interest = [(20 + 40 * i) for i in range(6)]

strength = 0

need = {'noop': 1, 'addx': 2}
queue = None

while pointer < len(instructions):
    # START
    if queue == None:
        _type = 'noop' if instructions[pointer].startswith('noop') else 'addx'
        _add = 0 if instructions[pointer].startswith(
            'noop') else int(instructions[pointer].split()[1])

        queue = [_add, need[_type]]

    # DURING
    if cycle in cycles_of_interest:
        strength += register * cycle

    # END
    if (queue[1] == 1):
        register += queue[0]
        pointer += 1
        queue = None
    else:
        queue[1] -= 1

    cycle += 1

print(strength)
