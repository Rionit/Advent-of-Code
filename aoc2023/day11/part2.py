with open("data.txt") as data:
    universe = [line.strip() for line in data.readlines()]
    transposed_universe = list(map(list, zip(*universe)))
    galaxies_count = sum([line.count("#") for line in universe]) 
    positions = [(row, col) for row, line in enumerate(universe) for col, char in enumerate(line) if char == '#']
    
    pairs = [(x, y) for x in range(galaxies_count) for y in range(galaxies_count) if x != y and x < y]
    
    # # print modified universe
    # for line in expanded_universe:
    #     print("".join(line))

    total_distance = 0
    for pair in pairs:
        x1 = positions[pair[0]][0]
        x2 = positions[pair[1]][0]
        y1 = positions[pair[0]][1]
        y2 = positions[pair[1]][1]
        
        expanded_rows = len([row for row in universe[min(x1, x2):max(x1, x2)] if row == "." * len(row)])
        expanded_cols = len([col for col in transposed_universe[min(y1, y2):max(y1, y2)]  if "." * len(col) == "".join(col)])
        
        col_diff = abs(x2 - x1) + (expanded_cols * 1000000) - expanded_cols
        row_diff = abs(y2 - y1) + (expanded_rows * 1000000) - expanded_rows
        # print(f"{(pair[0] + 1, pair[1] + 1)}: {row_diff} + {col_diff}")
        total_distance += row_diff + col_diff
        
    print(total_distance)