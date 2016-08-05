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
    
    // The Swift compiler doesn't like dealing with closure signatures as the data type for array
    // but can placated with an alias
    typealias CommandClosure = Calculator -> Void
    private var history = [CommandClosure]()
    
    private var queue = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
//    private var performingUndo = false
    
    func add(amount: Int) {
        addMacro(Calculator.add, amount: amount)
        total += amount
    }
    
    func subtract(amount: Int) {
        addMacro(Calculator.subtract, amount: amount)
        total -= amount
    }
    
    func multiply(amount: Int) {
        addMacro(Calculator.multiply, amount: amount)
        total *= amount
    }
    
    func divide(amount: Int) {
        addMacro(Calculator.divide, amount: amount)
        total /= amount
    }
    
    // <object reference>.<instance method name>(<argument value>)
    // <class>.<instance method name>(<object reference>)(<argument value>)
    // "Currying" is the process of creating on function that fixes one or more arguments passed to another function.
    
    private func addMacro(method: Calculator -> Int -> Void, amount: Int) {
        dispatch_sync(self.queue) {
            self.history.append({ calc in method(calc)(amount) })
        }
    }
    
    func getMacroCommand() -> CommandClosure {
        var commands = [CommandClosure]()
        dispatch_sync(queue) {
            commands = self.history
        }
        
        return { calc in
            if commands.count > 0 {
                for index in 0 ..< commands.count {
                    commands[index](calc)
                }
            }
        }
    }
    
//    func undo() {
//        dispatch_sync(self.queue) {
//            if self.history.count > 0 {
//                self.performingUndo = true
//                self.history.removeLast().execute()
//                // self.history.removeLast()
//                self.performingUndo = false
//            }
//        }
//    }
    
//    func getHistorySnapshot() -> Command? {
//        var command: Command?
//        dispatch_sync(queue) {
//            command = CommandWrapper(commands: self.history.reverse())
//        }
//        return command
//    }
}