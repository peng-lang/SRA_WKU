public protocol Real: Comparable {
    var denomiator: Int { get set }
    var numerator: Int { get set }
    init(numerator: Int, denomiator: Int)
    static prefix func - (rhs: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
}
extension Real {
    public static func reciprocal(_ real: Self) -> Self {
        let denomiator = real.denomiator
        let numerator = real.numerator
        
        return Self(numerator:  numerator > 0 ? denomiator : -denomiator,
                    denomiator: numerator > 0 ? numerator : -numerator)
    }
    public static func - (lhs: Self, rhs: Self) -> Self {
        lhs + (-rhs)
    }
    public static func / (lhs: Self, rhs: Self) -> Self {
        lhs * reciprocal(rhs)
    }
}
public struct Entry: Real {
        
    public var numerator: Int
    
    public var denomiator: Int
    
    public var value: Double {
        Double(numerator) / Double(denomiator)
    }
    
    public init(numerator: Int, denomiator: Int) {
        self.numerator = numerator
        self.denomiator = denomiator
    }
    public init(_ numerator: Int, _ denomiator: Int = 1) {
        self.numerator = numerator
        self.denomiator = denomiator
    }
    private static func simplify(_ real: Entry) -> Entry {
        var numerator = real.numerator > 0 ? real.numerator : -real.numerator
        var denomiator = real.denomiator
        while denomiator > 0 {
            (numerator, denomiator) = (denomiator, numerator % denomiator)
        }
        return Entry(real.numerator / numerator, real.denomiator / numerator)
    }
    public static func + (lhs: Entry, rhs: Entry) -> Entry {
        let newDenomiator = lhs.denomiator * rhs.denomiator
        let newNumerator = lhs.numerator * rhs.denomiator + rhs.numerator * lhs.denomiator
        
        let newReal = Entry(newNumerator, newDenomiator)
        return simplify(newReal)
    }
    public static prefix func - (rhs: Entry) -> Entry {
        let newEntry = Entry(rhs.numerator * -1, rhs.denomiator)
        return newEntry
    }
    public static func * (lhs: Entry, rhs: Entry) -> Entry {
        let newDenomiator = lhs.denomiator * rhs.denomiator
        let newNumerator = lhs.numerator * rhs.numerator
        
        let newReal = Entry(newNumerator, newDenomiator)
        
        return simplify(newReal)
    }
    public static func < (lhs: Entry, rhs: Entry) -> Bool {
        let left = lhs.numerator * rhs.denomiator
        let right = rhs.numerator * lhs.denomiator

        return left < right
    }
}
let x = Entry(2, 2) // 1
let y = Entry(-3, 2) // 1.5
print(x, y)
let z = x / y
print(z.value)

