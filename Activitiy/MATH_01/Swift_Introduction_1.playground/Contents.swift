import Cocoa

///# Hello World
print("Hello World!")
print(123456)
print(3.1415)
print([0,1,2])
print(true)

///# Constant and Variable
print("Hello, World!", 123456, 3.1415)
let integer = 123456, PI = 3.1415
print("Hello, World!", integer, PI)
//integer = 0

//var interger = 123456
//integer = 0

let myStudentID = 1234567
print("My Student ID is \(myStudentID)")

///# Type Casting
var variable: Int = 10
variable = Int(PI)

///# Operations
print(!true)
print(!false)
print(true||false)
print(true&&false)

print(1 == 2)

///# If-Statement
var a = 1, b = 2

if a == b {
    print("a = b")
} else if a > b{
    print("a > b")
} else {
    print("a < b")
}

var c = 3
// a == b && a != c is boolean expression
//
// if boolean-expression {
//     Statements
// } else if boolean-expression {
//     Statements
// } else {
//     Statements
// }
//
if a == b && a != c {
    print("a: \(a), b: \(b), c: \(c)")
} else {
    print(false)
}

///# Array and For-loop
var emptyIntArray_1 = [Int]()
//var emptyIntArray_2 = Array<Int>()

var integers = [1, 2, 3]

for index in integers.indices {
    print(index)
}

integers.append(4)
integers.remove(at: 0)
integers.insert(1, at: 0)

integers += [5,6,7]

for index in integers.indices {
    integers[index] = integers[index] * integers[index]
}

print(integers)

///## for loop with condtional statement
// print all odd numbers in the range
for num in 1...10 where num % 2 == 0 {
    print(num)
}

///# While-loop
//while boolean-statement {
//    Statememt
//}

var x = 1
while x > 0 {
    print(x)
    x -= 1
}

///# function

//func square(integer: Int) -> Int{
//    return integer * integer
//}
//square(integer: 2)
func square(_ integer: Int) -> Int {
    return integer * integer
}
let four = square(2)

///# Check if s1 has substring s2
extension String {
    func String2Array() -> [Character] {
        var output: [Character] = []
        for char in self {
            output += [char]
        }
        return output
    }
}
func checkIfSubstring(_ s1: String, hasSubstring s2: String) -> Bool{
    let s1 = s1.String2Array(), s2 = s2.String2Array()
    var isSubstring = true
    if s1.isEmpty && !s2.isEmpty { isSubstring = false
    } else {
        var startIndex = 0, h = 0
        for i in s1.indices where i < s1.count - s2.count + 1 && !s2.isEmpty {
            if s1[i] == s2[0] {
                startIndex = i; h = i
                for j in s2.indices where h < startIndex + s2.count && h < s1.count {
                    if s1[h] != s2[j] {
                        isSubstring = false
                        break
                    }
                    if h == startIndex + s2.count - 1 && s1[h] == s2[j] {
                        isSubstring = true
                        h = s1.count
                        break
                    }
                    h += 1
                }
            }
            guard h != s1.count else { break }
        }
    }
    return isSubstring
}
func checkIfEqual(_ x: Bool, _ y: Bool) {
    print(x == y ? "Pass test" : "Fail")
}
func testCases() {
    checkIfEqual(checkIfSubstring("ABCD", hasSubstring: "A"), true)
    checkIfEqual(checkIfSubstring("ABCD", hasSubstring: "AB"), true)
    checkIfEqual(checkIfSubstring("ABCD", hasSubstring: "AC"), false)
    checkIfEqual(checkIfSubstring("ABCD", hasSubstring: "ABCD"), true)
    checkIfEqual(checkIfSubstring("AABC", hasSubstring: "AA"), true)
    checkIfEqual(checkIfSubstring("AABC", hasSubstring: "AB"), true)
    checkIfEqual(checkIfSubstring("AABC", hasSubstring: "ABA"), false)
    checkIfEqual(checkIfSubstring("AABCAC", hasSubstring: "AB"), true)
    checkIfEqual(checkIfSubstring("AABCAC", hasSubstring: "AC"), true)
    checkIfEqual(checkIfSubstring("AABCACA", hasSubstring: "AD"), false)
    checkIfEqual(checkIfSubstring("AABCACA", hasSubstring: "CB"), false)
    checkIfEqual(checkIfSubstring("AABCACA", hasSubstring: "CA"), true)
    checkIfEqual(checkIfSubstring("AABCACA", hasSubstring: "ACA"), true)
    checkIfEqual(checkIfSubstring("AABBCCDDE", hasSubstring: "E"), true)
    checkIfEqual(checkIfSubstring("AABBCCDDE", hasSubstring: ""), true)
    checkIfEqual(checkIfSubstring("", hasSubstring: "ABC"), false)
    checkIfEqual(checkIfSubstring("", hasSubstring: ""), true)
}
testCases()
