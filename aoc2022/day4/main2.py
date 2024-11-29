from sys import stdin
total = 0
lines = [line.strip('\n').split(',') for line in stdin]
i = 0
size = 1
while i < len(lines):
    section = lines[i:i+size]
    for pair in section:
        ranges = [range.split('-') for range in pair]
        if int(ranges[0][1]) < int(ranges[1][0]) or int(ranges[1][1]) < int(ranges[0][0]):
            pass
        else:
            total += 1

    # print(section)
    i += size
    size += 1

print(total)