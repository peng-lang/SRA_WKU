def hanoi(num, disks):
    if num == 1:
        print("{} => {}".format(disks[0], disks[2]))
    else:
        hanoi(num-1, [disks[0], disks[2], disks[1]])
        print("{} => {}".format(disks[0], disks[2]))
        hanoi(num-1, [disks[1], disks[0], disks[2]])

hanoi(3, ['A', 'B', 'C'])
