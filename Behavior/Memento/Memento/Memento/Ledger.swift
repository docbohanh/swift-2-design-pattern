//
//  Ledger.swift
//  Memento
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class LedgerEntry {
    let id: Int
    let counterParty: String
    let amount: Float
    
    init(id: Int, counterParty: String, amount: Float) {
        self.id = id
        self.counterParty = counterParty
        self.amount = amount
    }
}

class LedgerMemnto: Memento {
    private let entries: [LedgerEntry]
    private let total: Float
    private let nextId: Int
    
    init(ledger: Ledger) {
        self.entries = [LedgerEntry](ledger.entries.values)
        self.total = ledger.total
        self.nextId = ledger.nextId
    }
    
    func apply(ledger: Ledger) {
        ledger.total = self.total
        ledger.nextId = self.nextId
        ledger.entries.removeAll(keepCapacity: true)
        for entry in self.entries {
            ledger.entries[entry.id] = entry
        }
    }
}

class Ledger: Originator {
    private var entries = [Int : LedgerEntry]()
    private var nextId = 1
    var total: Float = 0
    
    func addEntry(counterParty: String, amount: Float) {
        let entry = LedgerEntry(id: nextId, counterParty: counterParty, amount: amount)
        nextId += 1
        entries[entry.id] = entry
        total += amount
    }
    
    func createMemento() -> Memento {
        return LedgerMemnto(ledger: self)
    }
    
    func applyMemento(memento: Memento) {
        if let m = memento as? LedgerMemnto {
            m.apply(self)
        }
    }
    
    func printEntries() {
        for id in entries.keys.sort(<) {
            if let entry = entries[id] {
                print("#\(id): \(entry.counterParty) $\(entry.amount)")
            }
        }
        print("Total: $\(total)")
        print("----")
    }
}