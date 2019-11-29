//
//  list.swift
//  Matrix
//
//  Created by Wendell Wang on 2019/11/27.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

import Foundation

public struct List: Collection {
    public typealias Element = Entry
    public typealias Index = Int
    
    private var list: [Element]
    
    /// list with double type value
    public var unwrappedList: [Double] {
        var result: [Double] = []
        for i in list {
            result.append(i.value)
        }
        return result
    }
    
    /// formatted list string, which makes the print for easy to read and more  "beautiful"
    ///
    /// the return will look like below
    ///
    ///     [1.0, 1/6, 1.5, 1.2, 2/3]
    ///
    /// rather than (if uses unwrapped list to print the list)
    ///
    ///     [1.0, 0.3333333333333333, 1.5, 1.2, 0.6666666666666666]
    ///
    public var formattedList: String {
        var str = "["
        for i in list.indices where i < list.count - 1{
            str += list[i].fractionalStr + ","
        }
        if let last = list.last {
            str += "\(last.fractionalStr)]"
        } else {
            str = ""
        }
        return str
    }
    /// if some (at least one) elements are nonzero elements, return `true`, else `false`
    public var isNonZero: Bool {
        return !(findFirstNonzeroValue().entry == Entry(0))
    }
    
    /// initiliazed list by `[Element]`
    /// - Parameter list: array of `Element`
    public init(_ list: [Element]) {
        self.list = list
    }
    
    /// initiliazed list by `[Int]`
    /// - Parameter list: int array
    public init(_ list: [Int]) {
        self.list = []
        for i in list {
            self.list.append(Element(i))
        }
    }
    
    /// more array-like
    public subscript(position: Index) -> Element {
        get {
            self.list[position]
        }
        set(newElement) {
            self.list[position] = newElement
        }
    }
    
    public var startIndex: Index = 0
    public var endIndex: Index {
        list.count
    }
    
    public func index(after i: Index) -> Index { i+1 }
    
    /// The number of element in the list
    public var count: Int {
        self.list.count
    }
    
    /// is the matrix is empty return `true`,  else return `false`
    public var isEmpty: Bool {
        list == []
    }
    
    /// Adds new entry add the end of list
    /// - Parameter entry: The element to append to the list
    public mutating func append(_ entry: Element) {
        list.append(entry)
    }
    
    /// Adds new entry add the end of list
    /// - Parameter entry: The value to append to the list
    public mutating func append(_ integer: Int) {
        list.append(Entry(integer))
    }
    /// find the first nonzero entry in the list and returns a tuple contain the entry and its index
    public func findFirstNonzeroValue() -> (entry: Element, index: Index?) {
        var count = 0
        for i in self.list {
            count += 1
            if i != Element(0) {
                return (i, count - 1)
            }
        }
        return (Element(0), nil)
    }
}

/// some math functions here
extension List {
    
    /// Converts to the opposite list, which means all entry in the list mutiply by `Entry(-1)`
    ///
    /// The multiplication operator (`-`) calculates the opposite list,
    ///  for example:
    ///
    ///      -[ 1, 2, 3, 4, 5, 6]       // [-1,-2,-3,-4,-5,-6]
    ///      -[ 1,-2, 3,-4, 5, 6]       // [-1, 2,-3, 4,-5,-6]
    ///      -[ 0, 0, 0, 0, 0, 0]       // [ 0, 0, 0, 0, 0, 0]
    ///
    /// - Parameters:
    ///   - rhs: The  list to convert.
    public static prefix func - (rhs: List) -> List {
        var theList = rhs
        for i in theList.indices {
            theList[i] *= Element(-1)
        }
        return theList
    }
    
    /// Adds two lists and produces their sum.
    ///
    /// The addition operator (`+`) calculates the sum of its two
    /// lits. For example:
    ///
    ///     [2, 1] + [3, 1]      // [5, 1]
    ///     [0, 1] + [3, 1]      // [3, 1]
    ///     [2, 3] + [2, 3]      // [5, 5]
    ///     [3, 2] + [2, 1]      // [5, 3]
    ///
    /// These two lists should have the same count or lists can't be blank
    ///
    ///     [2, 1] + [2, 1, 0]   // Error
    ///     [2, 1] + []          // Error
    ///
    /// - Parameters:
    ///   - lhs: The first list to add.
    ///   - rhs: The second list to add.
    public static func + (lhs: List, rhs: List) -> List {
        assert(lhs.count == rhs.count, "The two list should have same numbers of elements.")
        assert(lhs.count != 0, "The list should contain some elements.")
        var newList: [Element] = []
        for i in lhs.indices {
            newList += [lhs[i] + rhs[i]]
        }
        return List(newList)
    }
    
    /// Adds two lists and produces their sum.
    ///
    /// The minus operator (`-`) calculates the sum of one list and the other list's
    /// opposite list. For example:
    ///
    ///     [2, 1] - [3, 1]      // [-1, 0]
    ///     [0, 1] - [3, 1]      // [-3, 0]
    ///     [2, 3] - [2, 3]      // [ 0, 0]
    ///     [3, 2] - [2, 1]      // [ 1, 1]
    ///
    /// These two lists should have the same count or lists can't be blank
    ///
    ///     [2, 1] - [2, 1, 0]   // Error
    ///     [2, 1] - []          // Error
    ///
    /// - Parameters:
    ///   - lhs: The first entry to subtract.
    ///   - rhs: The second entry to substact.
    public static func - (lhs: List, rhs: List) -> List {
        lhs + (-rhs)
    }
    
    /// Multiplies a list and an element and produces their product.
    ///
    /// The multiplication operator (`*`) calculates the product of its two
    /// arguments. For example:
    ///
    ///     [2, 1] * Entry(3, 1)      // [6, 3]
    ///     [0, 1] * Entry(3, 1)      // [0, 3]
    ///     [2, 3] * Entry(2, 3)      // [4/3, 2]
    ///     [3, 2] * Entry(2, 1)      // [6, 4]
    ///
    /// - Parameters:
    ///   - lhs: The list to multiply.
    ///   - rhs: The entry to multiply.
    public static func * (lhs: List, rhs: Element) -> List {
        assert(lhs.count != 0, "The list should contain some elements.")
        var newList: [Element] = []
        for i in lhs.indices {
            newList += [lhs[i] * rhs]
        }
        return List(newList)
    }
    
    /// Multiplies an element and a list  and produces their product.
    ///
    /// The multiplication operator (`*`) calculates the product of its two
    /// arguments. For example:
    ///
    ///     Entry(3, 1) * [2, 1]      // [6, 3]
    ///     Entry(3, 1) * [0, 1]      // [0, 3]
    ///     Entry(2, 3) * [2, 3]      // [4/3, 2]
    ///     Entry(2, 1) * [3, 2]      // [6, 4]
    ///
    /// - Parameters:
    ///   - lhs: The entry to multiply.
    ///   - rhs: The list to multiply.
    public static func * (lhs: Element, rhs: List) -> List {
        rhs * lhs
    }
}
