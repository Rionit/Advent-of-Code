numbers = {
    "zero": "0",
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9"
}

def checkIfNumberOrWord(char, linePosition):

    if char in "123456789":
        return True, char

    for number in numbers:
        if number.startswith(char):
            isWord = True
            for letterPosition, letter in enumerate(number):
                if linePosition + letterPosition >= len(line) or letter != line[linePosition + letterPosition]:
                    isWord = False
                    break
            if isWord:
                return isWord, numbers[number]
        
    return False, None
        

with open("data_in.txt") as data:

    codeSum = 0

    for line in data.readlines():
        
        firstDigit = ""
        lastDigit = ""
        
        for linePosition, char in enumerate(line):
            isNumberOrWord, number = checkIfNumberOrWord(char, linePosition)
            if isNumberOrWord:
                if firstDigit == "": firstDigit = number
                lastDigit = number

        codeSum += int(firstDigit + lastDigit)
        
    print(codeSum)
