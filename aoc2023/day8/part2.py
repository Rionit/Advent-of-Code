
# def process_node(node, instruction, network):
#     return network[node][int(instruction)]

# with open("data.txt") as data:
#     instructions = data.readline().strip().replace("L", "0").replace("R", "1")
#     data.readline()
#     network = {node: directions[1:-1].split(",") for node, directions in [line.replace(" ", "").strip().split("=") for line in data.readlines()]}
#     ends_in_a = [node for node in network if node.endswith('A')]
#     print(ends_in_a)

#     instruction_pointer = 0
#     steps = 0
#     nodes = ends_in_a
#     while len([node for node in nodes if node.endswith('Z')]) < len(ends_in_a):
#         instruction = instructions[instruction_pointer]
        
#         with concurrent.futures.ThreadPoolExecutor() as executor:
#             # Use concurrent.futures to parallelize the loop
#             nodes = list(executor.map(lambda n: process_node(n, instruction, network), nodes))
#         length = len([node for node in nodes if node.endswith('Z')])
#         if length > 0:
#             print(f"step {steps}: {length}")
#         instruction_pointer += 1 if instruction_pointer + 1 < len(instructions) else -len(instructions) + 1
#         steps += 1
    
#     print(steps)

import math

def process_node(node, instruction, network):
    return network[node][int(instruction)]

with open("data.txt") as data:
    instructions = data.readline().strip().replace("L", "0").replace("R", "1")
    data.readline()
    network = {node: directions[1:-1].split(",") for node, directions in [line.replace(" ", "").strip().split("=") for line in data.readlines()]}
    ends_in_a = [node for node in network if node.endswith('A')]
    print(ends_in_a)

    instruction_pointer = 0
    steps = 0
    nodes = ends_in_a
    end_nodes = []
    while len(end_nodes) < len(ends_in_a):
        instruction = instructions[instruction_pointer]
        steps += 1
        
        for n, node in enumerate(nodes):
            # print(f"{instruction}: {node} => {network[node][int(instruction)]}")
            nodes[n] = network[node][int(instruction)]
            if nodes[n].endswith('Z'): 
                end_nodes.append((nodes[n], steps))
                # print(f"step {steps}: {len(end_nodes)} found")
                
        nodes = [node for node in nodes if not node.endswith('Z')]
        instruction_pointer += 1 if instruction_pointer + 1 < len(instructions) else -len(instructions) + 1
        
        # if len([node for node in nodes if not node.endswith('Z')]) < len(nodes):
        #     print(end_nodes)
    
    
    print(math.lcm(*[step[1] for step in end_nodes]))