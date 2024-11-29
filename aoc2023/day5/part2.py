with open("data.txt") as data:
    seed_ranges = data.readline().strip().split(":")[1].split()
    seeds = []
    for start in range(0, len(seed_ranges), 2):
        for _ in range(int(seed_ranges[start]) + int(seed_ranges[start+1]) - 1):
            seeds.append(int(seed_ranges[start]) + _)
                
    # print(seeds)
    step_identifiers = [[None for _ in range(len(seeds))] for i in range(8)]
    step_identifiers[0] = [int(seed) for seed in seeds]
    # print(step_identifiers)
    map_data = [section.split('\n') for section in data.read().split('\n\n')]
    # print(map_data)
    for map_idx, _map in enumerate(map_data):
        next_step = min(map_idx + 1, 7)
        for seed_idx, seed in enumerate(step_identifiers[map_idx]):
            for map_line in _map:
                if map_line != '' and map_line[0] in "1234567890":
                    destination_start, source_start, length = map_line.split()
                    
                    if int(source_start) <= int(seed) <= int(source_start) + int(length) - 1 and step_identifiers[next_step][seed_idx] is None:
                        offset = int(seed) - int(source_start) 
                        step_identifiers[next_step][seed_idx] = int(destination_start) + int(offset)
                        # print(f"{seed} => {int(destination_start) + int(offset)}")
            if step_identifiers[next_step][seed_idx] is None:
                step_identifiers[next_step][seed_idx] = step_identifiers[map_idx][seed_idx]
    # print(step_identifiers)       
    print(min(step_identifiers[7]))