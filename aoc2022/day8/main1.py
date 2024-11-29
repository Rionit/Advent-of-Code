
grid = [line.rstrip('\n').strip() for line in open('input.txt', 'r')]


visible_trees = {}

down = [0 for i in range(len(grid[0]))]
up = [0 for i in range(len(grid[0]))]

for row in range(len(grid)):
    left = 0
    right = 0

    for column in range(len(grid[row])):

        # border
        if row == 0:
            down[column] = int(grid[row][column])
            up[column] = int(grid[len(grid) - 1][column])
            visible_trees[f'{row}:{column}'] = 1
            visible_trees[f'{len(grid) - 1}:{column}'] = 1

        if column == 0:
            left = int(grid[row][column])
            right = int(grid[row][len(grid[row]) - 1 - column])
            visible_trees[f'{row}:{column}'] = 1
            visible_trees[f'{row}:{len(grid[row]) - 1 - column}'] = 1

        # left
        if int(grid[row][column]) > left:
            visible_trees[f'{row}:{column}'] = 1
            left = int(grid[row][column])

        # right
        if int(grid[row][len(grid[row]) - 1 - column]) > right:
            visible_trees[f'{row}:{len(grid[row]) - 1 - column}'] = 1
            right = int(grid[row][len(grid[row]) - 1 - column])

        # down
        if int(grid[row][column]) > down[column]:
            visible_trees[f'{row}:{column}'] = 1
            down[column] = int(grid[row][column])

        # up
        if int(grid[len(grid) - 1 - row][column]) > up[column]:
            visible_trees[f'{len(grid) - 1 - row}:{column}'] = 1
            up[column] = int(grid[len(grid) - 1 - row][column])

# print(sorted(visible_trees.keys()))
print(len(visible_trees))
