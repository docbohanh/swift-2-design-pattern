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

// The way that a memento works in entirely down to the implementation,
// and it need not contain the data values that an object contained.
// It can also be a trigger for some other kind of action,
// including discarding any changes made by the user and reloading the original data.

protocol Memento {
    
}

protocol Originator {
    func createMemento() -> Memento
    func applyMemento(memento: Memento)
}

