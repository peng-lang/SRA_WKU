//
//  functions.swift
//  Matrix
//
//  Created by Wendell Wang on 2019/11/26.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

import Foundation

/// swift version
func inputMatrix(_ input: inout String, _ matrices: inout [Matrix]) {
    print("Enter your matrix below (enter \"sw\" to stop): ")
    var data: [[Int]] = []
    var input = readLine()!
    while input != "sw" {
        if input == "nw" {
            matrices.append(Matrix(data))
            data = []
            print("Enter Next Matrix: ")
            input = readLine()!
        }
        data.append(input.split(separator: " ").map{(Int(String($0)) ?? 0)})
        if input == "t" {
            data = []
            print("The last matrix has been removed.")
        }
        input = readLine()!
    }
    print("Stop Writing Matrices.")
    matrices.append(Matrix(data))
}

/// c version
func inputMatrix(_ input: inout String, _ matrices: inout [CMatrix]) {
    print("Enter your matrix below (enter \"sw\" to stop): ")
    print("When you finish the matrix, please enter enter twice")
    var data: CMatrix = getInput()
    var input = readLine()!
    while input != "sw" {
        if input == "nw" {
            matrices.append(data)
            data = getInput()
            print("Enter Next Matrix: ")
            input = readLine()!
        }
        if input == "t" {
            data = getInput()
            print("The last matrix has been removed.")
        }
        input = readLine()!
    }
    print("Stop Writing Matrices.")
    matrices.append(data)
}
/// swift version Matrix struct
func calMatrix(_ matrices: [Matrix], _ index: Int? = nil,
               _ calAll: Bool = false, _ toUTForm: Bool = false) {
    if matrices.isEmpty {
        print(
        """
        Can't find any matrix...
        please check your matrices by entering command ap
        """
        )
        return
    }
    if index == nil {
        for i in 0..<matrices.count {
            var matrix = matrices[matrices.count - i - 1]
            toUTForm ? matrix.convert2UTMatrix(): matrix.convert2ReducedForm()
            print(matrix.formattedMatrixStr)
            if !calAll { break }
        }
    } else {
        var matrix = matrices[index!]
        matrix.convert2ReducedForm()
        print(matrix.formattedMatrixStr)
    }
    print("\nPrinted")
}
/// c version Matrix struct
func calMatrix(_ matrices: [CMatrix], _ index: Int? = nil,
               _ calAll: Bool = false, _ toUTForm: Bool = false) {
    if matrices.isEmpty {
        print(
        """
        Can't find any matrix...
        please check your matrices by entering command ap
        """
        )
        return
    }
    if index == nil {
        for i in 0..<matrices.count {
            let matrix = matrices[matrices.count - i - 1]
            toUTForm ? m_conert2UTMatrix(1, matrix): m_convert2ReducedForm(1, matrix)
            m_printFormattedMatrix(matrix)
            if !calAll { break }
        }
    } else {
        let matrix = matrices[index!]
        m_convert2ReducedForm(1, matrix)
        m_printFormattedMatrix(matrix)
    }
    print("\nPrinted")

}

/// swift version
func printMatrix(_ matrices: [Matrix], _ IfPrintAll: Bool = false) {
    if IfPrintAll {
        print("Print all matrices you've entered:")
        for matrix in matrices {
            print(matrix.formattedMatrixStr)
        }
    } else {
        print("Print the last matrix:")
        if let rMatrix = matrices.last {
            print(rMatrix.formattedMatrixStr)
        }
    }
}

/// c version
func printMatrix(_ matrices: [CMatrix], _ IfPrintAll: Bool = false) {
    if IfPrintAll {
        print("Print all matrices you've entered:")
        for matrix in matrices {
            m_printFormattedMatrix(matrix)
        }
    } else {
        print("Print the last matrix:")
        if let rMatrix = matrices.last {
            m_printFormattedMatrix(rMatrix)
        }
    }
}
