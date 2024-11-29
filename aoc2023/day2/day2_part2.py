with open("data_in.txt") as data:
    powers_sum = 0

    for index, game in enumerate(data.readlines(), 1):
        
        maximums = {"red": 0, "green": 0, "blue": 0}

        for set_ in game.split(":")[1].split(";"):
            for color_data in set_.split(","):
                amount, color = color_data.split()
                maximums[color] = max(int(amount), maximums[color])

        powers_sum += maximums["red"] * maximums["green"] * maximums["blue"]
    
    print(powers_sum)