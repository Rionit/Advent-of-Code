grid = [line.rstrip('\n').strip() for line in open('input.txt', 'r')]

directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
best_view = 0

for row in range(len(grid)):
    for column in range(len(grid[row])):

        # border
        if row == 0 or column == 0 or row == (len(grid) - 1) or column == (len(grid[row]) - 1):
            continue

        direction_scores = [0 for i in range(4)]

        for direction_id, direction in enumerate(directions):
            x = row
            y = column
            while True:
                x += direction[0]
                y += direction[1]

                if x < 0 or y < 0 or y == len(grid) or x == len(grid[y]):
                    break

                if grid[x][y] >= grid[row][column]:
                    direction_scores[direction_id] += 1
                    break

                direction_scores[direction_id] += 1

        current_view = 1
        for score in direction_scores:
            current_view *= score

        if current_view > best_view:
            best_view = current_view

print(best_view)
