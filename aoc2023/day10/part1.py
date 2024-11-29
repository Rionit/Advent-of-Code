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
  
with open("test3.txt") as data:
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
    
    visited = [start]
    start_neighbors = [get_new_position(start, direction) for direction in tiles["S"] if has_connection(direction, get_neighbor(start, direction))]
    agents = start_neighbors
    counter = 1
    while agents[0] != agents[1]:
        for a, agent in enumerate(agents):
            final[agents[a][0]][agents[a][1]] = str(counter)
            agents[a] = get_new_position(agent, [direction for direction in tiles[get_tile(agent)] if get_new_position(agent, direction) not in visited][0])
            visited.append(agent)
        counter += 1
            
    final[agents[a][0]][agents[a][1]] = str(counter)

    # visualize for smaller datasets
    # for line in final:
    #     print("".join(line))
        
    print(counter)
    