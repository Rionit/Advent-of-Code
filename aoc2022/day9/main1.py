# '+' = R|U ; '-' = L|D
def get_distance(tail, head):
    return (head[0] - tail[0], head[1] - tail[1])


def check_segment(tail, head):
    distance = get_distance(tail, head)
    if abs(distance[0]) + abs(distance[1]) == 4:
        return [head[0] - int(distance[0] / abs(distance[0])), head[1] - int(distance[1] / abs(distance[1]))]
    for i in range(2):
        if abs(distance[i]) > 1:
            tail = head.copy()
            tail[i] -= int(distance[i] / abs(distance[i]))
    return tail


head = [0, 0]
tails = [[0, 0] for i in range(9)]
visited = {}
instructions = {'U': [1, 0], 'D': [-1, 0], 'R': [0, 1], 'L': [0, -1]}

for line in open('input.txt', 'r').readlines():
    instruction = line.rstrip('\n').split()
    for step in range(int(instruction[1])):
        head = [x + y for x, y in zip(head, instructions[instruction[0]])]
        for i in range(9):
            if i == 0:
                tails[i] = check_segment(tails[i], head)
            else:
                tails[i] = check_segment(tails[i], tails[i - 1])

        visited[f"{tails[8][0]}:{tails[8][1]}"] = True

print(len(visited.keys()))
