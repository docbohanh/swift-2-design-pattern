//
//  main.swift
//  Command
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let calc = Calculator()
calc.add(10)
calc.multiply(4)
calc.subtract(2)

//let snapshot = calc.getHistorySnapshot()
//print("Pre-Snapshot Total: \(calc.total)")
//snapshot?.execute()
//print("Post-Snaphost Total: \(calc.total)")

print("Calc 1 Total: \(calc.total)")

let macro = calc.getMacroCommand()

let calc2 = Calculator()
macro(calc2)
print("Calc 2 Total: \(calc2.total)")