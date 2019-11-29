//
//  Matrix.swift
//  Matrix
//
//  Created by Wendell Wang on 2019/11/26.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//
import Foundation

/// Usage matrix type to "calculate" matrix
///
///     var a = Matrix([
///         [ 1,1,1,3],
///         [ 0,1,1,2],
///         [ 0,0,1,1]
///     ])
///     print(a.formattedMatrix)
///     // prints below
///     // [1.0, 1.0, 1.0, 3.0]
///     // [0.0, 1.0, 1.0, 2.0]
///     // [0.0, 0.0, 1.0, 1.0]
///     // convert to upper triangle matrix
///     a.convert2UTMatrix()
///     print(a.formattedMatrix)
///     // prints below, the origonal matrix is UT matrix
///     // [1.0, 1.0, 1.0, 3.0]
///     // [0.0, 1.0, 1.0, 2.0]
///     // [0.0, 0.0, 1.0, 1.0]
///     // convert reduced row echelon form
///     a.convert2ReducedForm()
///     print(a.formattedMatrix)
///     // prints below
///     // [1.0, 0.0, 0.0, 1.0]
///     // [0.0, 1.0, 0.0, 1.0]
///     // [0.0, 0.0, 1.0, 1.0]
///
/// Usage matrix type to "calculate" matrix
///
public struct Matrix {
    
    // make it more readable(maybe)
    public typealias Row = List
    public typealias Index = Int
    
    /// raw data with the custom data type
    private var matrix: [Row]
    
    /// convert the raw data to double type
    ///
    ///     print(matrix.matrixValues)
    ///     // prints like below
    ///     // [1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0]]
    ///
    public var unwrappedMatrix: [[Double]] {
        var result: [[Double]] = []
        for i in matrix {
            result.append(i.unwrappedList)
        }
        return result
    }
    
    /// formatted matrix string to make it easy to see
    ///
    /// this variable is not recommended for you, try `formattedMatrixStr`
    ///
    ///     print(matrix.formattedMatrix)
    ///     // prints like below
    ///     // [1.0, 0.0, 0.0, 1.0]
    ///     // [0.0, 1.0, 0.0, 1.0]
    ///     // [0.0, 0.0, 1.0, 1.0]
    ///
    public var unwrappedMatrixStr: String {
        var result = ""
        for row in unwrappedMatrix {
            result += "\(row)\n"
        }
        return result
    }
    
    /// formatted matrix string to make it easy to see
    ///
    ///     print(matrix.formattedMatrix)
    ///     // prints like below
    ///     // [1.0, 0.0, 0.0, 1.0]
    ///     // [0.0, 1.0, 0.0, 1.0]
    ///     // [0.0, 0.0, 1.0, 1.0]
    ///
    /// this variable can make the console more beautiful
    /// for float number, this `formattedMatrixStr` will return like below
    ///
    ///     [ 1.0,-1.5, 3.0, 2.5]
    ///     [ 0.0, 0.0, 1.0, 1/3]
    ///     [ 0.0, 0.0, 0.0, 3.0]
    ///     [ 0.0, 0.0, 0.0, 0.0]
    ///     [ 0.0, 0.0, 0.0, 0.0]
    ///
    /// rather than (uses `upwrappedMatrixStr`)
    ///
    ///     [1.0, -1.5, 3.0, 1.0, 2.5]
    ///     [0.0, 0.0, 1.0, -0.3333333333333333, 0.3333333333333333]
    ///     [0.0, 0.0, 0.0, 1.0, 3.0]
    ///     [0.0, 0.0, 0.0, 0.0, 0.0]
    ///     [0.0, 0.0, 0.0, 0.0, 0.0]
    ///
    public var formattedMatrixStr: String {
        var result = ""
        for row in matrix {
            result += "\(row.formattedList)\n"
        }
        return result
    }
    
    /// initialize the matrix by List array
    /// - Parameter matrix: List array to initialize a matrix
    public init(_ matrix: [Row]) {
        self.matrix = matrix
    }
    
    /// initialize the matrix by two-dimension array, maybe more convenience
    /// - Parameter matrix: two-dimension array to initialize a matrix
    public init(_ matrix: [[Int]]) {
        self.matrix = []
        for i in matrix {
            self.matrix.append(Row(i))
        }
    }
    
    /// return the number of rows of the matrix
    public var rows: Int {
        self.matrix.count
    }
    
    /// return the number of columns of the matrix
    /// and also, it can be consider as the max lengh of a row, if these rows are different
    public var cols: Int {
        var count = 0
        for i in matrix {
            count = i.count > count ? i.count : count
        }
        return count
    }
    
    /// do something like an array
    public subscript(position: Index) -> Row {
        get {
            self.matrix[position]
        }
        set(newRow) {
            self.matrix[position] = newRow
        }
    }
    
    /// if the rows of the matrix are not equal to each other,  make all of the rows have the same length as the longest row,
    /// by appending zero entry for the rows
    public mutating func forceEqualedRows() {
        let maxLength = self.cols
        // if the rows are not equal to the max length of the rows,
        // force all of rows to the max length by appending zero entry
        for i in self.matrix.indices {
            for j in self.matrix[i].indices where j > maxLength {
                self.matrix[i].append(0)
            }
        }
    }
    
    /// swap two rows of the matrix
    /// - Parameters:
    ///   - x: the first index of the row
    ///   - y: the second index of the row(should be different than x)
    public mutating func swapAt(_ x: Index, _ y: Index) {
        (matrix[x], matrix[y]) = (matrix[y], matrix[x])
    }
    
    /// Adds new rpw add the end of matrix
    /// - Parameter row: The row to append to the matrix
    public mutating func append(_ row: Row) {
        matrix.append(row)
    }
    
    /// Adds new rpw add the end of matrix
    /// - Parameter list: The int array to append to the matrix
    public mutating func append(_ list: [Int]) {
        matrix.append(Row(list))
    }
}

/// this extension contains the main methods of calculate a matrix
extension Matrix {
    
    /// Make the pivot entry to 1, by deviding each item with the pivot entry
    ///
    /// for example, with this method:
    ///
    ///     [3,1,2,0]  -> [1,1/3,2/3,0]
    ///     //[3,1,2,0] will become [1,1/3,2/3,0]
    ///
    /// - Parameter i: index of the row in the matrix
    public mutating func simplifyRow( _ i: Index) {
        // indicate the first nonzero entry
        var firstNonzeroNum = Entry(0)
        // find the first nonzero entry
        for item in self.matrix[i] {
            if item != Entry(0) {
                firstNonzeroNum = item
                break
            }
        }
        // Make the pivot entry to 1, by deviding each item with the pivot entry
        for index in self.matrix[i].indices {
            self.matrix[i][index] /= firstNonzeroNum
        }
    }
    
    /// convert the matrix to unpper triangle matrix
    /// - Parameter ifForceCal: if true, then force to make all of the rows have the same length as the longest row,
    /// by appending zero entry for the rows
    public mutating func convert2UTMatrix(ifForceCal: Bool = true) {
        if ifForceCal {
            // then force to make all of the rows have the same length as the longest row,
            // by appending zero entry for thne rows
            forceEqualedRows()
        }
        // Converts to UT matrix
        // the "start" variable is to indicate the pivot entry of a row
        var start = 0
        for i in matrix.indices where i < cols {
            var hasFound = false
            // Put the main row to the i-th row
            for j in start..<matrix.count {
                if matrix[j][i] != Entry(0) {
                    swapAt(start, j)
                    hasFound = true
                    break
                }
            }
            // if not find the nonzero entry, go to the next loop
            // it exits, for example, the matrix: [[1, 0, 1], [0, 0, 1]]
            // the second row is blank(all entries are 0 entry)
            if !hasFound {
                continue
            }
            // Then reduce the start-th row(make the first nonzero entry to one)
            simplifyRow(start)
            
            // for the rows below i-th row, cancels the i-th entry
            for j in start+1..<matrix.count {
                if matrix[j][i] == Entry(0) {
                    continue
                }
                matrix[j] = matrix[i] * matrix[j][i] * Entry(-1) + matrix[j]
            }
            start += 1
        }
        // and the matrix had also been arranged
    }
    
    /// convert the matrix to reduced row echelon form matrix by Gaussian Elimination
    /// - Parameter ifForceCel: if true, then force to make all of the rows have the same length as the longest row,
    /// by appending zero entry for the rows
    public mutating func convert2ReducedForm(ifForceCel: Bool = true) {
        convert2UTMatrix(ifForceCal: ifForceCel)
        // To cal reduced form, we should start from the bottom(nonzero row)
        // Find last non-zero row
        var index = -1
        for row in (0...matrix.count-1).reversed() {
            if matrix[row].isNonZero {
                index = row
                break
            }
        }
        // if index == 0, which means the matrix only have one non-zero row, or
        // the matrix is fulll of zero row
        if index <= 0 { return }
        // Make sure each column only has one nonzero value(except the last col)
        while index > 0 {
            // We have checked if the row is nonzero before, the i must have value
            let i = matrix[index].findFirstNonzeroValue().index
            if i == nil {
                index -= 1
                continue
            }
            // add multiple of the row to another row
            // using Gaussian Elimination
            for j in 0..<index {
                matrix[j] = matrix[index] * matrix[j][i!] * Entry(-1) + matrix[j]
            }
            index -= 1
        }
    }
}
