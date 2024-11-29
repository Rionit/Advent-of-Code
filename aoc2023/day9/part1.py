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
    
    cum_sum_of_cum_sums = sum([value for row in [[differences[len(differences) - 1] for differences in data_set] for data_set in data_sets] for value in row])
    
    print(cum_sum_of_cum_sums)