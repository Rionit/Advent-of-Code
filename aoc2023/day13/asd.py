import math

def grow_lines(x, block):
    step = 1
    while (x_l := math.floor(x - step)) > 0 and (x_r := math.ceil(x + step)) < len(block):
        if block[x_l] != block[x_r]: return False
        # print(f"{block[x_l]} > {x} < {block[x_r]}")
        step += 1
    return True

def grow_columns(y, block):
    step = 1
    while (y_l := math.floor(y - step)) > 0 and (y_r := math.ceil(y + step)) < len(block):
        if block[y_l] != block[y_r]: return False
        # print(f"{block[y_l]} {y_l} > {y} < {y_r} {block[y_r]}")
        step += 1
    return True

with open("data.txt") as data:
    data_lines = [[line for line in block.strip().split('\n')] for block in data.read().strip().split('\n\n')]
    data_columns = [["".join(row) for row in list(zip(*block))] for block in data_lines]
    total = [0, 0]
    for block_lines, block_columns in zip(data_lines, data_columns):
        # print("="*40)
        # print("="*40)
        reflections = [0, 0]
        for x in range(1, len(block_lines) - 1):
            x += 0.5
            
            # LINES
            if block_lines[math.floor(x)] == block_lines[math.ceil(x)]:
                # print(f"{block_lines[math.floor(x)]} > {x} < {block_lines[math.ceil(x)]}")
                if grow_lines(x, block_lines) and x > reflections[0]:
                    reflections[0] = math.ceil(x)
                #     print("found reflecting lines")
                # print()
                
        for y in range(1, len(block_columns) - 1):
            y += 0.5
            # COLUMNS
            if block_columns[math.floor(y)] == block_columns[math.ceil(y)]:
                # print(f"{block_columns[math.floor(y)]} {math.floor(y)} > {y} < {math.ceil(y)} {block_columns[math.ceil(y)]}")
                if grow_columns(y, block_columns) and y > reflections[1]:
                    reflections[1] = math.ceil(y)
                    # print("found reflecting columns")
                # print()
        
        total[0] += reflections[0] * 100
        total[1] += reflections[1]
    print(total[1] + total[0])