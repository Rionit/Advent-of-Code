with open("data_in.txt") as data:
    lines = data.readlines()
    cards_winning_nums, cards_my_nums = [[line.split(":")[1].split("|")[0].strip().split() for line in lines], [line.split(":")[1].split("|")[1].strip().split() for line in lines]]
    
    total_points = 0
    
    for card, my_nums in enumerate(cards_my_nums):
        card_value_exp = -1
        
        for my_num in my_nums:
            if my_num in cards_winning_nums[card]:
                card_value_exp += 1
        
        total_points += pow(2, card_value_exp) if card_value_exp != -1 else 0

    print(total_points)        
        