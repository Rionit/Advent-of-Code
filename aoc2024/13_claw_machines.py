import numpy as np
from scipy.optimize import linprog

def parse_input(file_path):
    machines = []
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    current_machine = {}
    for line in lines:
        line = line.strip()
        if line.startswith("Button A:"):
            x, y = map(lambda s: int(s.split('+')[1]), line.replace("Button A:", "").strip().split(", "))
            current_machine['A'] = (x, y)
        elif line.startswith("Button B:"):
            x, y = map(lambda s: int(s.split('+')[1]), line.replace("Button B:", "").strip().split(", "))
            current_machine['B'] = (x, y)
        elif line.startswith("Prize:"):
            x, y = map(lambda s: int(s.split('=')[1]), line.replace("Prize:", "").strip().split(", "))
            current_machine['Prize'] = (x, y)
            machines.append(current_machine)
            current_machine = {}
    return machines

def solve_machines(machines, part):
    total_tokens = 0
    results = []
    for machine in machines:
        x_A, y_A = machine['A']
        x_B, y_B = machine['B']
        prize_x, prize_y = machine['Prize']
        
        # Minimize 3a + b
        c = [3, 1]
        
        A = [
            [x_A, x_B],
            [y_A, y_B] 
        ]
        
        if part == 1:
            b = [prize_x, prize_y]  
            res = linprog(c, A_eq=A, b_eq=b, bounds=(0, None), method='highs', integrality=[1,1])
            if res.success and res.x[0] <= 100 and res.x[1] <= 100:
                tokens = 3 * res.x[0] + res.x[1]
                total_tokens += tokens
        else:  # part == 2
            b = [prize_x + 10000000000000, prize_y + 10000000000000] 
            
            total_tokens += numpy_solve(A, b)
            # WHY IS THIS NOT WORKING?
            # res = linprog(c, A_eq=A, b_eq=b, bounds=(0, None), method='highs', integrality=[1,1])
            # if res.success:
            #     res.x[0] = round(res.x[0])
            #     res.x[1] = round(res.x[1])
            #     if not np.any(A@res.x - b):
            #         tokens = 3 * res.x[0] + res.x[1]
            #         total_tokens += tokens
        
    return total_tokens

def numpy_solve(A, b):
    try:
        x = np.linalg.solve(A, b)
        x[0] = round(x[0])
        x[1] = round(x[1])
        if not np.any(A@x - b):
            return int(3 * x[0] + x[1])
        else:
            return 0  
    except np.linalg.LinAlgError:
        return 0

path = 'data/13_1'
machines = parse_input(path)
print(f"{path}-1: {int(solve_machines(machines, 1))}")
print(f"{path}-2: {int(solve_machines(machines, 2))}")

