tiles = {"|": "NS", 
        "-": "WE",
        "L": "NE",
        "J": "NW",
        "7": "SW",
        "F": "SE",
        "S": "NSWE",
        ".": ""}
connections = {"N": "S", "S": "N", "W": "E", "E": "W"}
direction_to_vector = {"N": (-1, 0), "S": (1, 0), "W": (0, -1), "E": (0, 1)}
grid = []

def has_connection(direction, pipe):
    # print(f"{direction}: {pipe} = {connections[direction] in tiles[pipe]}")
    return connections[direction] in tiles[pipe]

def get_neighbor(position, direction):
    return grid[position[0] + direction_to_vector[direction][0]][position[1] + direction_to_vector[direction][1]]

def get_new_position(position, direction):
    return tuple(map(sum, zip(position, direction_to_vector[direction])))

def get_tile(position):
    return grid[position[0]][position[1]]
  
with open("test1.txt") as data:
    grid = [line.strip() for line in data.readlines()]
    final = [list(line) for line in grid]
    
    # find start
    start = tuple()
    for r, row in enumerate(grid):
        for c, column in enumerate(row):
            if column == "S":
                start = (r, c)
                break
        if start:
            break
    
    loop = [start]
    start_neighbors = [get_new_position(start, direction) for direction in tiles["S"] if has_connection(direction, get_neighbor(start, direction))]
    agents = start_neighbors
    while agents[0] != agents[1]:
        for a, agent in enumerate(agents):
            agents[a] = get_new_position(agent, [direction for direction in tiles[get_tile(agent)] if get_new_position(agent, direction) not in loop][0])
            loop.append(agent)
    
    counter = 0
    for r, line in enumerate(final):
        crossed = 0
        
        for c, char in enumerate(line):
            if (r, c) in loop and ((r, c - 1) not in loop or (r, c + 1) not in loop):
                crossed += 1
            elif (r, c) not in loop:
                if not crossed % 2:
                    final[r][c] = "."
                else:
                    final[r][c] = "I"
                    counter += 1
            if (r, c) in loop:
                final[r][c] = "*"
         
    # visualize for smaller datasets
    for line in final:
        print("".join(line))
        
    print(counter)
    