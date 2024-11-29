with open("data.txt") as data:
    instructions = data.readline().strip().replace("L", "0").replace("R", "1")
    data.readline()
    network = {node: directions[1:-1].split(",") for node, directions in [line.replace(" ", "").strip().split("=") for line in data.readlines()]}
    
    # print(network)
    instruction_pointer = 0
    steps = 0
    node = 'AAA'
    while node != 'ZZZ':
        instruction = instructions[instruction_pointer]
        # print(f"{instruction_pointer}: {instruction}")
        # print(f"{node} => {network[node][int(instruction)]}")
        node = network[node][int(instruction)]
        instruction_pointer += 1 if instruction_pointer + 1 < len(instructions) else -len(instructions) + 1
        steps += 1
    
    print(steps)
        