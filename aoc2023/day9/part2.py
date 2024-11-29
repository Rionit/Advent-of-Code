with open("data.txt") as data:
    histories = [[int(value) for value in line.strip().split()] for line in data.readlines()]
    data_sets = []
    for history in histories:
        
        data_set = [history]
        differences = history # just so it can get into while loop
        
        while differences.count(0) < len(differences) and differences:
            differences = []
            last_data = data_set[len(data_set) - 1]
            
            for i in range(1, len(last_data), 1): 
                differences.append(last_data[i] - last_data[i-1])
            
            data_set.append(differences)
            # print(data_set)
        
        data_sets.append(data_set)
    
    
    first_nums = [[differences[0] for differences in data_set] for data_set in data_sets]
    
    total = 0
    for first_num_set in first_nums:
        missing_value = 0
        for i in range(len(first_num_set) - 1, -1, -1):
            missing_value = first_num_set[i] - missing_value  
        total += missing_value
    
    print(total)