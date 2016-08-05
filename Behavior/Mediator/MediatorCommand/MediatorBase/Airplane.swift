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

class Airplane: CommandPeer {
    var name: String
    var currentPosition: Position
    var mediator: CommandMediator
    let queue = dispatch_queue_create("posQ", DISPATCH_QUEUE_CONCURRENT)
    
    init(name: String, initalPos: Position, mediator: CommandMediator) {
        self.name = name
        self.currentPosition = initalPos
        self.mediator = mediator
        mediator.registerPeer(self)
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
            
            let c = Command(function: { peer in
                if let plane = peer as? Airplane {
                    return plane.otherPlaneDidChangePosition(self.currentPosition)
                } else {
                    fatalError("Type mismatch")
                }
            })
            
            let allResults = self.mediator.dispatchCommand(self, command: c)
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