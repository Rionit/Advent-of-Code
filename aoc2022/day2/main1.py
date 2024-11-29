from sys import stdin

def check_rules(elf, me):
    win = ("AC", "CB", "BA")
    if elf == me:
        return 3
    elif ''.join((me, elf)) in win:
        return 6
    else:
        return 0

score = 0
guide = {'X': 'A', 'Y': 'B', 'Z': 'C'}
for line in stdin:
    _round = line.strip('\n').split(' ')
    score += check_rules(_round[0], guide[_round[1]]) 
    score += list(guide.keys()).index(_round[1]) + 1
print(f"score: {score}")