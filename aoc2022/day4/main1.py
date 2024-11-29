from sys import stdin
total = 0
lines = [line.strip('\n').split(',') for line in stdin]
i = 0
size = 1
while i < len(lines):
    section = lines[i:i+size]
    for pair in section:
        ranges = [range.split('-') for range in pair]
        if int(ranges[0][0]) <= int(ranges[1][0]) and int(ranges[0][1]) >= int(ranges[1][1]):
            total += 1
        elif int(ranges[0][0]) >= int(ranges[1][0]) and int(ranges[0][1]) <= int(ranges[1][1]):
            total += 1
    # print(section)
    i += size
    size += 1

print(total)