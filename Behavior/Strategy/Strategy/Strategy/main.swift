//
//  main.swift
//  Strategy
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let sequence = Sequence(1, 2, 3, 4)
sequence.addNumber(10)
sequence.addNumber(20)

//let sum = sequence.compute(ALGORITHM.ADD)
//print("Sum: \(sum)")
//let multiply = sequence.compute(ALGORITHM.MULTIPLY)
//print("Multiply: \(multiply)")

let sumStrategy = SumStrategy()
let multiplyStrategy = MultiplyStrategy()

let sum = sequence.compute(sumStrategy)
print("Sum: \(sum)")

let multiply = sequence.compute(multiplyStrategy)
print("Multiply: \(multiply)")

let filterThreshold = 10
let csstrategy = ClosureStrategy({ values in
    return values.filter({ $0 < filterThreshold }).reduce(0) { $0 + $1 }
})
let filteredSum = sequence.compute(csstrategy)
print("Filtered Sum: \(filteredSum)")