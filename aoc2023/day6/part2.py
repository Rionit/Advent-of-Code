with open("data.txt") as data:
    time = "".join(data.readline().split(":")[1].split())
    record = "".join(data.readline().split(":")[1].split())
    ways = 0
    for speed in range(int(time)):
        if (int(time) - speed) * speed > int(record):
            ways += 1
    print(ways)