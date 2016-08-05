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

print("Total: \(calc.total)")

for _ in 0 ..< 3 {
    calc.undo()
    print("Undo called. Total: \(calc.total)")
}