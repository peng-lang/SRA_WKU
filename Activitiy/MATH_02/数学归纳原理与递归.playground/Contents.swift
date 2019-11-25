import Foundation

func factorial(_ integer: Int) -> Int {
    if integer == 0 {
        return 1
    } else {
        return integer * factorial(integer-1)
    }
}
print(factorial(1))
print(factorial(2))
print(factorial(3))
print(factorial(4))
print(factorial(5))

func minTimesOfHanoi(_ num: Int) -> Int{
    var times = 0
    
    if num == 1 {
        times = 1
    } else {
        times = 2 * minTimesOfHanoi(num-1) + 1
    }
    return times
}
//
//print(minTimesOfHanoi(3))
//
//func hanoi(_ num: Int, disks: [String]) {
//    if num == 1 {
//        print("\(disks[0]) => \(disks[2])")
//    } else if num == 2 {
//        print("\(disks[0]) => \(disks[1])")
//        print("\(disks[0]) => \(disks[2])")
//        print("\(disks[1]) => \(disks[2])")
//    } else {
//        //回想我们在证明时，做了什么？
//        //我们先是把前n-1个圆盘移到了中间的位置
//        hanoi(num-1, disks: [disks[0], disks[2], disks[1]])
//        //然后再把剩下的那个最大的圆盘放到了目标位置
//        print("\(disks[0]) => \(disks[2])")
//        //最后我们又把n-1个被移到中间位置的圆盘，移动到目标位置
//        hanoi(num-1, disks: [disks[1], disks[0], disks[2]])
//    }
//}
//hanoi(4, disks: ["A", "B", "C"])

// 上面的代码还可以怎么去优化？
// 提示：注意我们else里面的代码跟else if里面的代码有什么相似的地方吗




func hanoi(_ num: Int, disks: [String]) {
    if num == 1 {
        print("\(disks[0]) => \(disks[2])")
    } else {
        //回想我们在证明时，做了什么？
        //我们先是把前n-1个圆盘移到了中间的位置
        hanoi(num-1, disks: [disks[0], disks[2], disks[1]])
        //然后再把剩下的那个最大的圆盘放到了目标位置
        print("\(disks[0]) => \(disks[2])")
        //最后我们又把n-1个被移到中间位置的圆盘，移动到目标位置
        hanoi(num-1, disks: [disks[1], disks[0], disks[2]])
    }
}
//hanoi(3, disks: ["A", "B", "C"])


// 另外一个递归的例子
// Fibonacci序列的i定义是： Fi(0) = 0, Fi(1) = 1, Fi(x-1) + Fi(x-2) = Fi(x)
// 写一个函数可以获取任意Fi(x)
// 写一个函数，可以获取任意长度的Fibonacci序列
func FiNum(_ x: Int) -> Int {
    if x == 0 {
        return 0
    } else if x == 1 {
        return 1
    } else {
        return FiNum(x - 1) + FiNum(x - 2)
    }
}
func FiNums(_ length: Int) -> [Int] {
    var nums: [Int] = []

    for i in 0...length {
        nums.append(FiNum(i))
    }

    return nums
}
FiNums(12)

func FiNums_advanced(_ length: Int) -> [Int] {
    guard length >= 2 else { return Array<Int>(0...length) }
    
    var nums: [Int] = [0, 1]
    
    for i in 2...length {
        nums += [nums[i-1] + nums[i-2]]
    }
    
    return nums
}
print(FiNums_advanced(9))
// 递归有时候也会出问题，比如同样是计算长度为12的Fibonacci序列，前面的方法计算了1205次，而第二个方法只需要11次
// 在数量级比较小的时候，算法之间的差距没有那么明显，但是一旦数量级变大，不同的算法之间带来的差距会很可观

/// Return time your function costed for special value; Your function should have only one parameter
/// - Parameter value: the value you want to test for your function
/// - Parameter yourFunction: the function you want to test
func testInterval<T, K>(for value: K, _ yourFunction: (K) -> T) -> TimeInterval {
    let date1:NSDate = NSDate()
    yourFunction(value)
    let date2:NSDate = NSDate()
    let interval:TimeInterval = date2.timeIntervalSince(date1 as Date) * 1000.0
    return interval
}

//testInterval(for: 20, FiNum(_:))
testInterval(for: 20, FiNums(_:))
testInterval(for: 20, FiNums_advanced(_:))


// this sequence should be sorted
func search<T: Comparable>(sequence: [T], number: T, lower: Int, upper: Int) -> Int {
    if upper == lower {
        assert(sequence[lower] == number)
        return lower
    } else {
        let middle = Int((lower + upper) / 2)
        if sequence[middle] >= number {
            return search(sequence: sequence, number: number, lower: lower, upper: middle)
        } else {
            return search(sequence: sequence, number: number, lower: middle+1, upper: upper)
        }
        
    }
}
var array: [Int] = []
for i in 0...10 {
    array.append(i)
}
print(array)
search(sequence: array, number: 7, lower: 0, upper: array.count)
