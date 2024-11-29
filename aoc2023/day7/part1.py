with open("data.txt") as data:
    
    hands = {hand: int(bid) for hand, bid in [line.replace("A", "E").replace("K", "D").replace("Q", "C").replace("J", "B").replace("T", "A").strip().split() for line in data.readlines()]}
    # cards = {label: strength for strength, label in enumerate("23456789TJQKA", 1)}
    # grouped_hands = {hand_type: [] for hand_type in Type}
    grouped_hands = []
    
    for hand in hands.keys():
        
        card_counts = {}
        
        for card in hand:
            card_counts[card] = 1 if card not in card_counts else card_counts[card] + 1
       
        sorted_card_counts = [count[1] for count in sorted(card_counts.items(), key=lambda item: item[1], reverse=True)]
        
        if sorted_card_counts[0] == 5:
            grouped_hands.append((hand, Type.FIVE_OF_A_KIND)) 
        elif sorted_card_counts[0] == 4:
            grouped_hands.append((hand, Type.FOUR_OF_A_KIND)) 
        elif sorted_card_counts[0] == 3 and sorted_card_counts[1] == 2:
            grouped_hands.append((hand, Type.FULL_HOUSE)) 
        elif sorted_card_counts[0] == 3:
            grouped_hands.append((hand, Type.THREE_OF_A_KIND)) 
        elif sorted_card_counts[0] == 2 and sorted_card_counts[1] == 2:
            grouped_hands.append((hand, Type.TWO_PAIR)) 
        elif sorted_card_counts[0] == 2:
            grouped_hands.append((hand, Type.ONE_PAIR)) 
        else:
            grouped_hands.append((hand, Type.HIGH_CARD)) 

    
    
    sorted_grouped_hands = sorted(grouped_hands, key=lambda item: (item[1], item[0]))
    total = 0        
    rank = 0
    for hand, _ in sorted_grouped_hands:
        rank += 1
        total += hands[hand] * rank
     
    # for group in grouped_hands.values():
    #     if not group: continue
    #     if len(group) == 1:
    #         rank += 1
    #         total += group[0][1] * rank
    #     elif len(group) >= 2:
    #         final_group = []
    #         for i in range(5):
                
    #             strengths = dict(sorted({hand[0]: cards[hand[0][i]] for hand in group if hand[0] not in [final[0] for final in final_group]}.items(), key=lambda item: item[1], reverse=False))
    #             unique_values = [[key, value] for key, value in zip(strengths.keys(), strengths.values()) if list(strengths.values()).count(value) == 1]
    #             # print(unique_values)
                
    #             if unique_values:
    #                 for hand in unique_values:
    #                     final_group.append(hand)

    #         for key, _ in sorted(final_group, key=lambda item: item[1], reverse=False):
    #             rank += 1
    #             total += hands[key] * rank
    print(total)
                