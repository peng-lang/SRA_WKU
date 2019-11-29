//
//  main.swift
//  Matrix
//
//  Created by Wendell Wang on 2019/11/26.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

import Foundation

var matrices: [Matrix] = []

welcomeInfo()
var input = readLine()!
while input != "q" {
    switch input {
        case "w":
            inputMatrix(&input, &matrices)

        case "c":
            calMatrix(matrices, nil)
        case "ac":
            calMatrix(matrices, nil, true, false)
        case "cUT":
            calMatrix(matrices, nil, false, true)
        case "acUT":
            calMatrix(matrices, nil, true, true)

        case "p":
            printMatrix(matrices)
        case "ap":
            printMatrix(matrices, true)

        case "help":
            help(&input)
        default:
            break
    }
    input = readLine()!
}
endInfo()
