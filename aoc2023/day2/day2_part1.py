with open("data_in.txt") as data:
    possibles_sum = 0

    for index, game in enumerate(data.readlines(), 1):
        
        possible = True

        for set_ in game.split(":")[1].split(";"):
            for color_data in set_.split(","):
                amount, color = color_data.split()
                if color == "red" and int(amount) > 12:
                    possible = False
                elif color == "green" and int(amount) > 13:
                    possible = False
                elif color == "blue" and int(amount) > 14:
                    possible = False

        if possible:
            possibles_sum += index
    
    print(possibles_sum)