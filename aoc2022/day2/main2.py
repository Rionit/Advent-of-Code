from sys import stdin

def check_rules(elf, me):
    win = ("AC", "CB", "BA")
    if elf == me:
        return 3
    elif ''.join((me, elf)) in win:
        return 6
    else:
        return 0

def get_me(elf, strategy):
    #         [x]:  y   <-- y defeats x
    defeat = {'C': 'A', 'B': 'C', 'A': 'B'} 
    if strategy == 'Z':
        # print(f"elf: {elf} me:{defeat[elf]} I had to win")
        return defeat[elf]
    elif strategy == 'X':
        # print(f"elf: {elf} me:{defeat[elf]} I had to lose")
        for me in ('A', 'B', 'C'): 
            if elf == defeat[me]:
                return me
    else:
        # print(f"elf: {elf} me:{defeat[elf]} I had to draw")
        return elf

score = 0
guide = {'A': 1, 'B': 2, 'C': 3}
for line in stdin:
    _round = line.strip('\n').split(' ')
    me = get_me(_round[0], _round[1])
    score += check_rules(_round[0], me) + guide[me]
    # print(f"{check_rules(_round[0], me)} + {guide[me]}")
print(f"score: {score}")