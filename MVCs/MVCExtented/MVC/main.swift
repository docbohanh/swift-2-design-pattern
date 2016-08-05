//
//  main.swift
//  MVC
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let repository = MemoryRepository()
let controllerChain = PersonController(repo: repository, nextController: CityController(repo: repository, nextController: nil))

var stdIn = NSFileHandle.fileHandleWithStandardInput()
var command = Command.LIST_PEOPLE
var data = [String]()

while true {
    if let view = controllerChain.handleCommand(command, data: data) {
        view.execute()
        
        print("--Commands--")
        for command in Command.ALL {
            print(command.rawValue)
        }
    } else {
        fatalError("No view")
    }
    
    let input: String = String(data: stdIn.availableData, encoding: NSUTF8StringEncoding) ?? ""
    let inputArray: [String] = input.split()
    
    if inputArray.count > 0 {
        command = Command.getFromInput(inputArray.first!) ?? .LIST_PEOPLE
        if inputArray.count > 1 {
            data = [String](inputArray[1 ... inputArray.count - 1])
        } else  {
            data = []
        }
        print("Command \(command.rawValue) Data \(data)")
    }
}