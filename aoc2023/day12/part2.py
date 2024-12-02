import itertools
from itertools import groupby

def combinations(s, chars):
    for p in map(iter, itertools.product(chars, repeat=s.count('?'))):
        yield ''.join(c if c != '?' else next(p) for c in s)

with open("test.txt") as data:
    total_possible_combinations = 0
    test = ",".join(["##..#.??.#" for _ in range(5)])
    # print(test)
    for row in data.readlines():
        springs, original_record = row.strip().split()
        springs = springs * 5
        original_record = ",".join([original_record for _ in range(5)])
        original_record = [int(x) for x in original_record.split(',')]
        # print(f"{springs}: {original_record}")

        group_lengths = [[sum(1 for _ in group) for key, group in groupby(combination) if key == '#'] for combination in combinations(springs, '#.')]
        possible_group_lengths = [record for record in group_lengths if record == original_record]
        total_possible_combinations += len(possible_group_lengths)
    
    print(total_possible_combinations)