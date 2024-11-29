with open("data.txt") as data:
    data_lines = [[line for line in block.strip().split('\n')] for block in data.read().strip().split('\n\n')]
    data_columns = [["".join(row) for row in list(zip(*block))] for block in data_lines]
    total = [0, 0]
    for block_lines, block_columns in zip(data_lines, data_columns):
        # print("="*40)
        # print("="*40)
        reflections = [0, 0]
        for x in range(1, len(block_lines)):
            
            # LINES
            lines_left = block_lines[:x][::-1]
            lines_right = block_lines[x:]
            lines_left = lines_left[:len(lines_right)]
            lines_right = lines_right[:len(lines_left)]
            
            if lines_left == lines_right:
                reflections[0] = max(x, reflections[0])
            
        for y in range(1, len(block_columns)):
            # COLUMNS
            columns_left = block_columns[:y][::-1]
            columns_right = block_columns[y:]

            columns_left = columns_left[:len(columns_right)]
            columns_right = columns_right[:len(columns_left)]
            
            if columns_left == columns_right:
                reflections[1] = max(y, reflections[1])
        
        total[0] += reflections[0] * 100
        total[1] += reflections[1]
    print(total[1] + total[0])