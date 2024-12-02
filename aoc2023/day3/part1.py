def add_dots(lines):
    # Add dots at the beginning and end of each line
    dotLineDot = ['.' + line.strip() + '.' for line in lines]

    # Calculate the length of the lines (assuming all lines have the same length)
    lineLength = len(lines[0])

    # Create a line full of dots
    dottedLine = '.' * (lineLength + 2)

    # Add the line full of dots at the beginning and end of the list
    dotLineDot.insert(0, dottedLine)
    dotLineDot.append(dottedLine)

    return dotLineDot

with open("data_in.txt") as data:
    lines = add_dots(data.readlines())
    total = 0

    for row, line in enumerate(lines):
        symbolFound = False
        number = ""
        for column, char in enumerate(line):
            if char in "1234567890":
                number += char
                if symbolFound: continue
                for step in [-1, 0, 1]:
                    if lines[row - 1][column + step] not in "1234567890.":
                        symbolFound = True
                        break
                    elif lines[row][column + step] not in "1234567890.":
                        symbolFound = True
                        break
                    elif lines[row + 1][column + step] not in "1234567890.":
                        symbolFound = True
                        break
            elif number != "" and char not in "1234567890":
                if symbolFound:
                    # print("found new number: " + number)
                    total += int(number)
                    number = ""
                    symbolFound = False
                else:
                    # print("skipping number: " + number)
                    number = ""

    print(total)


            


