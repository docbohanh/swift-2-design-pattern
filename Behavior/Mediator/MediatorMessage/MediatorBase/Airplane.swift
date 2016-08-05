//
//  Airplane.swift
//  MediatorBase
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

struct Position {
    var distanceFromRunway: Int
    var height: Int
}

class Airplane: MessagePeer {
    var name: String
    var currentPosition: Position
    var mediator: MessageMediator
    let queue = dispatch_queue_create("posQ", DISPATCH_QUEUE_CONCURRENT)
    
    init(name: String, initalPos: Position, mediator: MessageMediator) {
        self.name = name
        self.currentPosition = initalPos
        self.mediator = mediator
        mediator.registerPeer(self)
    }
    
    func handleMessage(messageType: String, data: Any?) -> Any? {
        var result: Any?
        switch messageType {
        case "changePos":
            if let pos = data as? Position {
                result = otherPlaneDidChangePosition(pos)
            }
        default:
            fatalError("Unknown message type")
        }
        return result
    }
    
    func otherPlaneDidChangePosition(position: Position) -> Bool {
        var result = false
        dispatch_sync(self.queue) {
            result = position.distanceFromRunway == self.currentPosition.distanceFromRunway
                && abs(position.height - self.currentPosition.height) < 1000
        }
        return result
    }
    
    func changePosition(newPosition: Position) {
        dispatch_barrier_sync(self.queue) {
            self.currentPosition = newPosition
            let allResults = self.mediator.sendMessage(self, messageType: "changePos", data: newPosition)
            
            for result in allResults {
                if result as? Bool == true {
                    print("\(self.name): Too close! Abort!")
                    return
                }
            }
            
            print("\(self.name): Position changed")
        }
    }
    
    func land() {
        dispatch_barrier_sync(self.queue) { 
            self.currentPosition = Position(distanceFromRunway: 0, height: 0)
            self.mediator.unregisterPeer(self)
            print("\(self.name): Landed")
        }
    }
}