//
//  Strategies.swift
//  Strategy
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Strategy {
    func execute(values: [Int]) -> Int
}

// The advantage of using closures is that a calling component can close on its own methods and properties to define more complex strategies.
// The drawback of closures is that they can be harder to read, and passing them around as objects requires clos attention to detail.

class ClosureStrategy: Strategy {
    private let closure: [Int] -> Int
    
    init(_ closure: [Int] -> Int) {
        self.closure = closure
    }
    
    func execute(values: [Int]) -> Int {
        return self.closure(values)
    }
}

class SumStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(0) { $0 + $1 }
    }
}

class MultiplyStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(1) { $0 * $1 }
    }
}