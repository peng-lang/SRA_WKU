//
//  entry.swift
//  Matrix
//
//  Created by Wendell Wang on 2019/11/27.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

import Foundation

public protocol Real: Comparable {
    var denomiator: Int { get set }
    var numerator: Int { get set }
    init(numerator: Int, denomiator: Int)
    static prefix func - (rhs: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
}
extension Real {
    private var rZero: Self { Self(numerator: 0, denomiator: 1) }
    private var rOne : Self { Self(numerator: 1, denomiator: 1) }
    
    public static func reciprocal(_ real: Self) -> Self {
        let denomiator = real.denomiator
        let numerator = real.numerator
        
        guard numerator != 0 else {
            print(
                """

                **************************************************
                * UNDEFINED: 0 doesn't have a reciprocal number. *
                **************************************************

                """
            )
            return real
        }
        
        // Notice denomiator is always non-negative
        return Self(numerator:  numerator > 0 ? denomiator : -denomiator,
                    denomiator: abs(numerator))
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        lhs + (-rhs)
    }
    public static func / (lhs: Self, rhs: Self) -> Self {
        lhs * reciprocal(rhs)
    }
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
    public static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
    private func pow(_ number: Self, _ times: Int) -> Self {
        if times <  0 { return pow(.reciprocal(number), -times)}
        if times == 0 { return rOne   }
        if times == 1 { return number }
        return pow(number * number, times / 2) * (times % 2 == 0 ? rOne : number)
    }
    public func pow(_ times: Int) -> Self {
        self.pow(self, times)
    }
}
/// A more accurate data type for storing data
public struct Entry {
    
    public var numerator: Int
    
    // denomiator can't be zero
    public var denomiator: Int

    /// the float value of entry
    ///
    ///     Entry( 1,1)  ->  1.0
    ///     Entry( 2,3)  ->  0.6666666...
    ///     Entry(-2,3)  -> -0.6666666...
    ///
    public var value: Double {
        Double(numerator) / Double(denomiator)
    }
    
    /// The string of fractional number of the entry
    ///
    ///     Entry(1,1)   -> 1.0
    ///     Entry(3,2)   -> 1.5
    ///     Entry(1,5)   -> 0.2
    ///     Entry(1,10)  -> 0.1
    ///     Entry(3,5)   -> 3/5
    ///
    public var fractionalStr: String {
        var str = ""
        if denomiator == 1 {
            str = "\(numerator)"
        }
        switch denomiator {
            case 1,2,5,10:
                str = "\(value)"
            default:
                str = "\(numerator)/\(denomiator)"
        }
        if numerator >= 0 {
            str = " " + str
        }
        return str
    }
    
    /// initilaize entry
    /// - Parameters:
    ///   - numerator: numerator of entry
    ///   - denomiator: denomiator of the entry
    public init(numerator: Int, denomiator: Int) {
        self.numerator = numerator
        self.denomiator = denomiator
    }
    
    /// initilaize entry, more convenient
    /// - Parameters:
    ///   - numerator: numerator of entry
    ///   - denomiator: denomiator of the entry
    public init(_ numerator: Int, _ denomiator: Int = 1) {
        self.numerator = numerator
        self.denomiator = denomiator
    }
    
    /// simplify the entry, by Euliean Algorith
    ///
    ///     Entry(4, 2) -> Entry(2, 1)
    ///     Entry(1, 1) -> Entry(1, 1)
    ///     Entry(-2, -2) -> Entry(1, 1)
    ///
    /// - Parameter real: entry to simplify
    private static func simplify(_ real: Entry) -> Entry {
        let isNegative = real.numerator * real.denomiator < 0
        // make sure numeratir and denomiator are both positive (or zero)
//        var numerator = real.numerator > 0 ? real.numerator : -real.numerator
//        var denomiator = real.denomiator > 0 ? real.denomiator : -real.denomiator
        var numerator = abs(real.numerator)
        var denomiator = abs(real.denomiator)
        while denomiator > 0 {
            (numerator, denomiator) = (denomiator, numerator % denomiator)
        }
        return Entry(abs(real.numerator) / numerator * (isNegative ? -1 : 1),
                     abs(real.denomiator) / numerator)
    }
}

/// some math function here, inherited from `Real` protocol
extension Entry: Real {
    
    /// Adds two entry and produces their sum.
    ///
    /// The addition operator (`+`) calculates the sum of its two
    /// arguments. For example:
    ///
    ///     Entry(2, 1) + Entry(3, 1)      // Entry(5,1)
    ///     Entry(0, 1) + Entry(3, 1)      // Entry(3,1)
    ///     Entry(2, 3) + Entry(2, 3)      // Entry(4,3)
    ///     Entry(3, 2) + Entry(2, 1)      // Entry(7,2)
    ///
    /// You cannot use `+` with arguments of different types. To add values
    /// of different types, convert one of the values to the other value's type.
    ///
    ///     let x: Entry = Entry(8)
    ///     let y: Int = 100
    ///     x + Entry(y)              // Entry(108,1)
    ///     Int(x.value) * y          // 108.0
    ///
    /// - Parameters:
    ///   - lhs: The first entry to add.
    ///   - rhs: The second entry to add.
    public static func + (lhs: Entry, rhs: Entry) -> Entry {
        let newDenomiator = lhs.denomiator * rhs.denomiator
        let newNumerator = lhs.numerator * rhs.denomiator + rhs.numerator * lhs.denomiator
        
        let newReal = Entry(newNumerator, newDenomiator)
        return simplify(newReal)
    }
    
    /// Converts to the opposite number of the `Entry`
    ///
    /// The multiplication operator (`-`) calculates the opposite number of the `Entry`,
    ///  for example:
    ///
    ///      -Entry(2, 1)       // Entry(-6,1)
    ///      -Entry(0, 1)       // Entry(-0,1)
    ///      -Entry(2, 3)       // Entry(-2,9)
    ///      -Entry(3, 2)       // Entry(-3,1)
    ///
    /// - Parameters:
    ///   - rhs: The  entry to convert.
    public static prefix func - (rhs: Entry) -> Entry {
        let newEntry = Entry(-rhs.numerator, rhs.denomiator)
        return newEntry
    }
    
    /// Multiplies two entry and produces their product.
    ///
    /// The multiplication operator (`*`) calculates the product of its two
    /// arguments. For example:
    ///
    ///     Entry(2, 1) * Entry(3, 1)      // Entry(6,1)
    ///     Entry(0, 1) * Entry(3, 1)      // Entry(0,1)
    ///     Entry(2, 3) * Entry(2, 3)      // Entry(2,9)
    ///     Entry(3, 2) * Entry(2, 1)      // Entry(3,1)
    ///
    /// You cannot use `*` with arguments of different types. To multiply values
    /// of different types, convert one of the values to the other value's type.
    ///
    ///     let x: Entry = Entry(8)
    ///     let y: Int = 100
    ///     x * Entry(y)              // Entry(800,1)
    ///     Int(x.value) * y          // 800.0
    ///
    /// - Parameters:
    ///   - lhs: The first entry to multiply.
    ///   - rhs: The second entry to multiply.
    public static func * (lhs: Entry, rhs: Entry) -> Entry {
        let newDenomiator = lhs.denomiator * rhs.denomiator
        let newNumerator = lhs.numerator * rhs.numerator
        
        let newReal = Entry(newNumerator, newDenomiator)
        
        return simplify(newReal)
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. In fact,
    /// the `Real` protocl had inheited from the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func < (lhs: Entry, rhs: Entry) -> Bool {
        let left = lhs.numerator * rhs.denomiator
        let right = rhs.numerator * lhs.denomiator
        
        return left < right
    }
}
