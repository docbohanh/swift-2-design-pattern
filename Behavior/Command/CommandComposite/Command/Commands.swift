//
//  Commands.swift
//  Command
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Command {
    func execute()
}

class CommandWrapper: Command {
    private let commands: [Command]
    
    init(commands: [Command]) {
        self.commands = commands
    }
    
    func execute() {
        for command in commands {
            command.execute()
        }
    }
}

class GenericCommand<T>: Command {
    private var receiver: T
    private var instructions: T -> Void
    
    init(receiver: T, instructions: T -> Void) {
        self.receiver = receiver
        self.instructions = instructions
    }
    
    func execute() {
        instructions(receiver)
    }
    
    class func createCommand(receiver: T, instructions: T -> Void) -> Command {
        return GenericCommand(receiver: receiver, instructions: instructions)
    }
}