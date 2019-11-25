func hanoi(_ num: Int, disks: [String]) {
	if num == 1 {
		print("\(disks[0]) => \(disks[2])")
	} else {
        hanoi(num-1, disks: [disks[0], disks[2], disks[1]])
        print("\(disks[0]) => \(disks[2])")
        hanoi(num-1, disks: [disks[1], disks[0], disks[2]])
	}
}
hanoi(3, disks: ["A", "B", "C"])
