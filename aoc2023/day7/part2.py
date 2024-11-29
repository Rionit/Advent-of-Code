from enum import Enum

# Define an enumeration class
class Type(Enum):
    HIGH_CARD = 1
    ONE_PAIR = 2
    TWO_PAIR = 3
    THREE_OF_A_KIND = 4
    FULL_HOUSE = 5
    FOUR_OF_A_KIND = 6
    FIVE_OF_A_KIND = 7
    
    def __lt__(self, other):
        if isinstance(other, Type):
            return self.value < other.value
        return NotImplemented

    def __gt__(self, other):
        if isinstance(other, Type):
            return self.value > other.value
        return NotImplemented
    
    def __str__(self):
        return str(self.value)

with open("test2.txt") as data:
    
    hands = {hand: int(bid) for hand, bid in [line.replace("A", "E").replace("K", "D").replace("Q", "C").replace("J", "1").replace("T", "A").strip().split() for line in data.readlines()]}

    grouped_hands = []
    
    for hand in hands.keys():
        
        card_counts = {}
        
        for card in hand:
            card_counts[card] = 1 if card not in card_counts else card_counts[card] + 1
        
        sorted_card_counts = [count for card, count in sorted(card_counts.items(), key=lambda item: item[1], reverse=True) if card != "1"]
        
        
        # print(sorted_card_counts)
        _type = 0 
        if sorted_card_counts[0] == 5:
            _type = 7
        elif sorted_card_counts[0] == 4:
            _type = 6
        elif sorted_card_counts[0] == 3 and sorted_card_counts[1] == 2:
            _type = 5
        elif sorted_card_counts[0] == 3:
            _type = 4
        elif sorted_card_counts[0] == 2 and sorted_card_counts[1] == 2:
            _type = 3
        elif sorted_card_counts[0] == 2:
            _type = 2
        else:
            _type = 1

        if "1" in card_counts:
            joker_count = card_counts["1"]
            if joker_count == 1:
                if _type == 1 or _type == 6:
                    _type += 1
                elif _type == 2 or _type == 3 or _type == 4:
                    _type += 2
            elif joker_count == 2:
                if _type == 2 or _type == 5:
                    _type += 2
                elif _type == 2:
                    _type = 6
            elif joker_count == 3:
                if _type == 4 or _type == 5:
                    _type += 2
            elif joker_count == 4:
                _type = 7
        
        grouped_hands.append((hand, _type)) 
    
        
    sorted_grouped_hands = sorted(grouped_hands, key=lambda item: (item[1], item[0]))
    sorted_grouped_hands = sorted(grouped_hands, key=lambda item: item[1])
    print(sorted_grouped_hands)
    total = 0        
    rank = 0
    for hand, _ in sorted_grouped_hands:
        rank += 1
        total += hands[hand] * rank
     
    print(total)
                