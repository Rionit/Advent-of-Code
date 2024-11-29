from sys import stdin
print(sum([(ord(letter) - 96 + (58 if letter.isupper() else 0)) for line in stdin for (idx, letter) in enumerate(line[:int(len(line)/2)]) if (letter in line[int(len(line)/2):]) and (idx == line[:int(len(line)/2)].index(letter))]))
# print([(ord(letter) - 96 + (58 if letter.isupper() else 0)) for line in stdin for (idx, letter) in enumerate(line[:int(len(line)/2)]) if (letter in line[int(len(line)/2):]) and (idx == line[:int(len(line)/2)].index(letter))])
    