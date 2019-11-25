import Foundation


/// An linked list.
class LinkedList<T> {
    var value: T
    var next: LinkedList?
    
    /// Creates a new node with initialized value which  connects to the next node
    /// - Parameters:
    ///   - value: The value to append to the list.
    ///   - next: The next node after this node
    init(_ value: T, _ next: LinkedList) {
        self.value = value
        self.next = next
    }
    /// Creates a new node with initialized value
    /// - Parameter value: The value to append to the list.
    init(_ value: T) {
        self.value = value
        self.next = nil
    }
    /// Accesses the element at the specified position.
    /// - Parameter index: The position of the element to access. index should be greater than or equal to startIndex and less than endIndex.
    subscript(index: Int) -> T {
        get {
            findNode(at: index).value
        }
        set(newValue) {
            let node = findNode(at: index)
            node.value = newValue
        }
    }
    /// The number of elements in the list.
    ///
    /// - Complexity: O(n).
    var count: Int {
        var p: LinkedList? = self
        var counter = 0
        while p != nil {
            p = p?.next
            counter += 1
        }
        return counter
    }
    /// The last element of the collection.
    ///
    ///     //first: 1 -> 2 -> 4 -> 8
    ///     print(first.last)
    ///     //Prints 8
    ///     //second: 1
    ///     print(second.last)
    ///     //Prints "1"
    ///
    /// - Complexity: O(n).
    var last: LinkedList {
        return findNode(at: count - 1)
    }
    /// find node at index like a normal array
    ///
    ///     first: 1 -> 2 -> 4 -> 8
    ///     first.findNode(at: 3)
    ///     //Returns 4
    ///     first: 1 -> 2 -> 4 -> 8
    ///     first.findNode(at: 5)
    ///     //Prints "Error: Out Range"
    ///     //Returns 4
    ///
    /// - Parameter index: index of the node
    ///
    /// - Complexity: O(n).
    private func findNode(at index: Int) -> LinkedList {
        var p = self
        for _ in 0..<index {
            if let node = p.next {
                p = node
            } else {
                print("Error: Out Range")
                break;
            }
        }
        return p
    }
}
extension LinkedList {
    /// description about current node
    private var description: String {
        "LinkedList: \(value), \(next == nil ? "doesn't " : "")have next node."
    }
    
    /// print information about current node
    ///
    ///     var first = LinkedList(0)
    ///     first.printNode()
    ///     //Prints "LinkedList: 0, doesn't have next node."
    ///     var second = LinkedList(1)
    ///     first.next = second
    ///     first.printNode()
    ///     //Prints "LinkedList: 0, has next node."
    ///
    /// - Complexity: O(1) on average.
    func printNode() {
        print(description)
    }
    /// print all nodes current node
    ///
    /// - Complexity: O(n) on average.
    func printList() {
        var list: LinkedList? = self
        var index = 0
        while list != nil {
            print("\(index): \(list!.value)")
            index += 1
            list = list?.next
        }
        print("----------------")
    }
}
extension LinkedList {
    /// Adds a new node at the end of the array.
    ///
    /// Use this method to append a single element to the end of a mutable array.
    ///
    ///     var first = LinkedList(0)
    ///     first.append(LinkedList(1))
    ///     first.append(LinkedList(2))
    ///     first.printList()
    ///     // Prints "0: 0\n1: 1\n2: 2\n"
    ///
    /// - Parameter newNode: The node to append to the list.
    ///
    /// - Complexity: O(n) on average.
    func append(_ newNode: LinkedList) {
        var pointer: LinkedList? = self
        while true {
            if let node = pointer?.next {
                pointer = node
            } else { break }
        }
        pointer?.next = newNode
    }
    /// Adds a new node at the end of the array.
    ///
    /// Use this method to append a single element to the end of a mutable array.
    ///
    ///     var first = LinkedList(0)
    ///     first.append(1)
    ///     first.append(2)
    ///     first.printList()
    ///     // Prints "0: 0\n1: 1\n2: 2\n"
    ///
    /// - Parameter value: The value to append to the list.
    ///
    /// - Complexity: O(n) on average.
    func append(_ value: T) {
        self.append(LinkedList(value))
    }
}

var first = LinkedList(1)
var second = LinkedList(2)
first.next = second
second.append(LinkedList(3))
second.append(4)

first.printList()
first[2] = 10
first.last.printNode()
first.printNode()
