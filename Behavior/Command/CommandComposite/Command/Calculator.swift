//
//  Calculator.swift
//  Command
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Calculator {
    private(set) var total = 0
    private var history = [Command]()
    private var queue = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    private var performingUndo = false
    
    func add(amount: Int) {
        addUndoCommand(Calculator.subtract, amount: amount)
        total += amount
    }
    
    func subtract(amount: Int) {
        addUndoCommand(Calculator.add, amount: amount)
        total -= amount
    }
    
    func multiply(amount: Int) {
        addUndoCommand(Calculator.divide, amount: amount)
        total *= amount
    }
    
    func divide(amount: Int) {
        addUndoCommand(Calculator.multiply, amount: amount)
        total /= amount
    }
    
    // <object reference>.<instance method name>(<argument value>)
    // <class>.<instance method name>(<object reference>)(<argument value>)
    // "Currying" is the process of creating on function that fixes one or more arguments passed to another function.
    
    private func addUndoCommand(method: Calculator -> Int -> Void, amount: Int) {
        if !performingUndo {
            dispatch_sync(self.queue) {
                self.history.append(GenericCommand<Calculator>.createCommand(self, instructions: { calc in method(calc)(amount) }))
            }
        }
    }
    
    func undo() {
        dispatch_sync(self.queue) {
            if self.history.count > 0 {
                self.performingUndo = true
                self.history.removeLast().execute()
                // self.history.removeLast()
                self.performingUndo = false
            }
        }
    }
    
    func getHistorySnapshot() -> Command? {
        var command: Command?
        dispatch_sync(queue) {
            command = CommandWrapper(commands: self.history.reverse())
        }
        return command
    }
}