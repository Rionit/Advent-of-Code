with open('data/9_1') as f:
    pos = 0
    files, free = {}, {}
    
    for i, blocks in enumerate([int(c) for c in f.read().strip()]):
        if (i & 1) == 0:
            files[pos] = (blocks, i // 2)
        else:
            free[pos] = blocks
        pos += blocks

    for file_pos, (file_blocks, fid) in list(reversed(files.items())):
        for hole_pos in sorted(free):
            if hole_pos + file_blocks > file_pos:
                break
            hole_size = free[hole_pos]
            if hole_size >= file_blocks:
                files[hole_pos] = (file_blocks, fid)
                
                new_free_len = hole_size - file_blocks
                if new_free_len > 0:
                    free[hole_pos + file_blocks] = new_free_len

                files.pop(file_pos)
                free.pop(hole_pos)
                break

    total = sum(fid * sum(range(file_pos, file_pos + file_blocks)) for file_pos, (file_blocks, fid) in files.items())
    print(total)
