import numpy

with open("data.txt") as data:
    
    times = data.readline().split(":")[1].split()
    records = data.readline().split(":")[1].split()
    
    ways = [0 for _ in range(len(times))]
    
    for i, (time, record) in enumerate(zip(times, records)):
        for speed in range(int(time)):
            if (int(time) - speed) * speed > int(record):
                ways[i] += 1
                
    print(numpy.prod(ways))