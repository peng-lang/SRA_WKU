//
//  Entry.c
//  Matrix
//
//  Created by Wendell Wang on 2019/11/28.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//
/**
 The "document" below directly copied from the Swift version, so do not use like examples,
    the introduction is correct, but the example may have some problem, if you are not good at C,
    do not try to use like examples
 */

#include "CReal.h"

ElementType gcd(ElementType a, ElementType b) {
    ElementType x = a, y = b;
    while (y > 0) {
        ElementType r = x % y;
        x = y;
        y = r;
    }
    return x;
}

void cr_cvalue(CReal *x) {
    x -> value = (double) x -> numerator / x -> denomiator;
}

/// simplify the entry, by Euliean Algorith
///
///     Entry(4, 2) -> Entry(2, 1)
///     Entry(1, 1) -> Entry(1, 1)
///     Entry(-2, -2) -> Entry(1, 1)
///
/// - Parameter x: entry to simplify
void cr_simplify(CReal *x) {
    int isNegative = (x -> numerator * x -> denomiator) < 0;
    
    ElementType numerator = abs(x -> numerator);
    ElementType denomiator = abs(x -> denomiator);
    
    numerator = gcd(numerator, denomiator);
    
    x -> numerator = abs(x -> numerator) / numerator * (isNegative ? -1 : 1);
    x -> denomiator = abs(x -> denomiator) / numerator;
}



/**
 Exposed functions below:
 */


/// The string of fractional number of the entry
///
///     Entry(1,1)   -> 1.0
///     Entry(3,2)   -> 1.5
///     Entry(1,5)   -> 0.2
///     Entry(1,10)  -> 0.1
///     Entry(3,5)   -> 3/5
///
/// print fractionalStr
void cr_printFV(CReal x) {
    ElementType denomiator= x.denomiator;
    ElementType numerator = x.numerator;
    
    switch (denomiator) {
        case  1: printf("%.1f", x.value); break;
        case  2: printf("%.1f", x.value); break;
        case  5: printf("%.1f", x.value); break;
        case 10: printf("%.1f", x.value); break;
        default:
            printf("%d/%d", numerator, denomiator);
            break;
    }
}

/// initilaize entry, more convenient
/// - Parameters:
///   - numerator: numerator of entry
///   - denomiator: denomiator of the entry
CReal cr_init(ElementType numerator, ElementType denomiator) {
    int isNegaive = numerator * denomiator < 0;
    CReal real;
    real.numerator = isNegaive ? -abs(numerator) : abs(numerator);
    real.denomiator = abs(denomiator);
    cr_cvalue(&real);
    cr_simplify(&real);
    return real;
}

CReal cr_abs(CReal x) {
    return cr_init(abs(x.numerator), x.denomiator);
}

CReal cr_opposite(CReal x) {
    return cr_init(-x.numerator, x.denomiator);
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
///   - y: The  entry to convert.
CReal cr_negative(CReal x) {
    return cr_init(-abs(x.numerator), x.denomiator);
}

CReal cr_reciprocal(CReal x) {
    ElementType denomiator = x.denomiator;
    ElementType numerator = x.numerator;

    if (numerator == 0) {
        printf("\n"\
               "**************************************************\n"\
               "* UNDEFINED: 0 doesn't have a reciprocal number. *\n"\
               "**************************************************\n"\
               "\n");
        exit(EXIT_FAILURE);
    }
    
    // Notice denomiator is always non-negative
    return cr_init(numerator > 0 ? denomiator : -denomiator,
                   abs(numerator));
}


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
///   - x: The first entry to add.
///   - y: The second entry to add.
CReal cr_plus(CReal x, CReal y) {
    ElementType newDenomiator = x.denomiator * y.denomiator;
    ElementType newNumerator = x.numerator * y.denomiator + y.numerator * x.denomiator;
    
    return cr_init(newNumerator, newDenomiator);
}

CReal cr_minus(CReal x, CReal y) {
    return cr_plus(x, cr_negative(y));
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
///   - x: The first entry to multiply.
///   - rhs: The second entry to multiply.
CReal cr_multiply(CReal x, CReal y) {
    ElementType newDenomiator = x.denomiator * y.denomiator;
    ElementType newNumerator = x.numerator * y.numerator;
    
    return cr_init(newNumerator, newDenomiator);
}

CReal cr_divide(CReal x, CReal y) {
    return cr_multiply(x, cr_reciprocal(y));
}
