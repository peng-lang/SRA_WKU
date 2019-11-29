//
//  GeneralFunctions.swift
//  Matrix
//
//  Created by Wendell Wang on 2019/11/29.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

import Foundation

func welcomeInfo() {
    print(
        """
    🥰 Welcome to Program Matrix, Created by Wendell

    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Enter your command below (if you want any help, please enter help):
    """
    )
}
func endInfo() {
    print(
    """
    Program Matrix had ended successfully
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    """
    )
}

func help(_ input: inout String) {
    print("""

    💕User Guide:
    ————————————————————————————————————————————————————
    Command         Action
    ————————————————————————————————————————————————————
    q             -- quit the program

    w             -- start writing-matrix mode
    nw            -- enter next matrix
    sw            -- stop writing-matrix mode

    c             -- calculate the last matrix
                        (to Reduced Row Echolon Form)
    ac            -- calculate all matrices
                        (to Reduced Row Echolon Form)
    cUT           -- convert the last matrix to UT form
                        (UT: Upper Triangle)
    acUT          -- convert all to UT form

    p             -- print last matrix
    ap            -- print all matrices you've entered

    help          -- show user guide
    shelp         -- exit user guide
    —————————————————————————————————————————————————————
    """
    )
    while input != "shelp" {
        print("⚠️ If you want to exit, please enter shelp ")
        input = readLine()!
    }
    print("🥳 Exited user guide")
}
