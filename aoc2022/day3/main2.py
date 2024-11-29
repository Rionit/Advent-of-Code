from sys import stdin
total = 0
lines = [line.strip('\n') for line in stdin]
for i in range(1, int(len(lines)/3) + 1):
    group = lines[i*3-3:i*3]
    for letter in group[0]:
        if (letter in group[1]) and (letter in group[2]):
            total += (ord(letter) - 96 + (58 if letter.isupper() else 0))
            break
print(total)