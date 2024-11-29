class Directory:
    def __init__(self, name, parent):
        self.name = name
        self.files = []
        self.size_sum = 0
        self.sub_directories = []
        self.parent = parent
        self.depth = parent.depth + 1 if parent is not None else 0

    def find_directory(self, name):
        for directory in self.sub_directories:
            if directory.name == name:
                return directory

    def __repr__(self):
        return self.name

    def __str__(self):
        return self.name


root = Directory('/', None)
current_directory = root
directories = [root]

lines = open('input.txt', 'r').readlines()

for line in lines:
    instruction = line.rstrip('\n').replace("$ ", '')
    if instruction.startswith('cd'):
        change_dir = instruction.replace("cd ", '')

        if change_dir == "..":
            current_directory = current_directory.parent
        elif change_dir == "/":
            current_directory = root
        else:
            child = current_directory.find_directory(change_dir)
            current_directory = child if child != None else current_directory

    elif instruction.startswith('dir'):
        dir_name = instruction.replace('dir ', '')
        new_dir = Directory(dir_name, current_directory)
        current_directory.sub_directories.append(new_dir)
        directories.append(new_dir)

    elif not instruction.startswith('ls'):
        file_size = int(instruction.split(' ')[0])
        current_directory.size_sum += file_size
        temp_directory = current_directory.parent
        while temp_directory is not None:
            temp_directory.size_sum += file_size
            temp_directory = temp_directory.parent
        current_directory.files.append(file_size)

TOTAL_SPACE = 70000000
UNUSED_SPACE = 30000000
MINIMUM_SPACE_TO_DELETE = UNUSED_SPACE - \
    (TOTAL_SPACE - directories[0].size_sum)

current_minimum = 1000000000
for directory in directories:
    if directory.size_sum < current_minimum and directory.size_sum >= MINIMUM_SPACE_TO_DELETE:
        current_minimum = directory.size_sum

print(MINIMUM_SPACE_TO_DELETE)
