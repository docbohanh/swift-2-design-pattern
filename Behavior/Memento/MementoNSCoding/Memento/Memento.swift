//
//  Memento.swift
//  Memento
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// 2 conditions
// - The caretaker should not be able to modify the state that the memento contains in any way.
// - The memento should always work, regardless of the current state of the originator.

// In practice, this mean an originator either contains a static snapshot of the state data
// or consists of a set of operations that reset the state and are then applied in sequence.

protocol Memento {
    
}

protocol Originator {
    func createMemento() -> Memento
    func applyMemento(memento: Memento)
}

