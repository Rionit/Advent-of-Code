with open("data_in.txt") as data:
    lines = data.readlines()
    cards_winning_nums, cards_my_nums = [[line.split(":")[1].split("|")[0].strip().split() for line in lines], [line.split(":")[1].split("|")[1].strip().split() for line in lines]]
    
    total_points = 0
    instances = {card: 1 for card in range(len(lines))}
    
    for card, my_nums in enumerate(cards_my_nums):
        matching_nums = 0
        
        for my_num in my_nums:
            if my_num in cards_winning_nums[card]:
                matching_nums += 1
                instances[card + matching_nums] += instances[card]
        
        # print(f"{card}: {instances.values()}")
        total_points += instances[card]
    # print(instances)
    print(total_points)        
        