def expand_universe(universe):
    expanded_universe = []
    for line in universe:
        if "." * len(line) == "".join(line):
            expanded_universe.append(["."] * len(line))
        expanded_universe.append(line)
    return expanded_universe

with open("data.txt") as data:
    universe = [line.strip() for line in data.readlines()]
    galaxies_count = sum([line.count("#") for line in universe])
    
    # transpose matrix
    transposed_universe = list(map(list, zip(*expand_universe(universe))))

    # transpose back
    expanded_universe = list(map(list, zip(*expand_universe(transposed_universe))))
    
    positions = [(row, col) for row, line in enumerate(expanded_universe) for col, char in enumerate(line) if char == '#']
    
    pairs = [(x, y) for x in range(galaxies_count) for y in range(galaxies_count) if x != y and x < y]
    

    # # print modified universe
    # for line in expanded_universe:
    #     print("".join(line))

    total_distance = 0
    for pair in pairs:
        col_diff = abs(positions[pair[1]][0] - positions[pair[0]][0])
        row_diff = abs(positions[pair[1]][1] - positions[pair[0]][1])
        print(f"{(pair[0] + 1, pair[1] + 1)}: {row_diff} + {col_diff}")
        total_distance += row_diff + col_diff
        
    print(total_distance)