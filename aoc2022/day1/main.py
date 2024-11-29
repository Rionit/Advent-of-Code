from sys import stdin
top = [-1, -2, -3]
cur_calories = 0
temp = 0
for line in stdin:
    if line == '\n':
        for i in range(3):
            if(cur_calories > top[i]):
                for j in range(3 - i):
                    temp = top[i+j]
                    top[i+j] = cur_calories
                    cur_calories = temp
                break
        cur_calories = 0
        continue
    cur_calories += int(line.strip(('\n')))
print(f"max: {top[0]+top[1]+top[2]}")