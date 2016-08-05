//
//  Sequence.swift
//  Strategy
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// Modifying or subclassing to add features runs counter to the open/closed design principle,
// which states that classes should be open to being extended and should be closed to being modified,
// or, put another way, that is preferable to be able to add to the functionality provided by a class
// without needing to modify it or to create a new subclass.

// Doing it can trigger requirements for extensive unit, system, and intergration testing
// before a change can be deployed into a production system.

//enum ALGORITHM {
//    case ADD; case MULTIPLY;
//}

final class Sequence {
    private var numbers: [Int]
    
    init(_ numbers: Int...) {
        self.numbers = numbers
    }
    
    func addNumber(value: Int) {
        self.numbers.append(value)
    }
    
    func compute(strategy: Strategy) -> Int {
        return strategy.execute(self.numbers)
    }
    
//    func compute(algorithm: ALGORITHM) -> Int {
//        switch algorithm {
//        case .ADD:
//            return numbers.reduce(0) { $0 + $1 }
//        case .MULTIPLY:
//            return numbers.reduce(1) { $0 * $1 }
//        }
//    }
}