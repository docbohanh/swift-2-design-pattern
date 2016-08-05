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

class LedgerMemento: Memento {
    let data: NSData
    
    init(data: NSData) { self.data = data }
}

class Ledger: NSObject, Originator, NSCoding {
    private var entries = [Int : LedgerEntry]()
    private var nextId = 1
    var total: Float = 0
    
    override init() {
        // do nothing - required to allow instances to be created without a coder
    }
    
    required init(coder aDecoder: NSCoder) {
        self.total = aDecoder.decodeFloatForKey("total")
        self.nextId = aDecoder.decodeIntegerForKey("nextId")
        self.entries.removeAll(keepCapacity: true)
        if let entryArray = aDecoder.decodeDataObject() as AnyObject? as? [NSDictionary] {
            for entryDict in entryArray {
                let id = entryDict["id"] as! Int
                let counterParty = entryDict["counterParty"] as! String
                let amount = entryDict["amount"] as! Float
                self.entries[id] = LedgerEntry(id: id, counterParty: counterParty, amount: amount)
            }
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeFloat(total, forKey: "total")
        aCoder.encodeInteger(nextId, forKey: "nextId")
        var entriesArray = [NSMutableDictionary]()
        for entry in self.entries.values {
            let dict = NSMutableDictionary()
            dict["id"] = entry.id
            dict["counterParty"] = entry.counterParty
            dict["amount"] = entry.amount
            entriesArray.append(dict)
        }
        aCoder.encodeObject(entriesArray)
    }
    
    func createMemento() -> Memento {
        return LedgerMemento(data: NSKeyedArchiver.archivedDataWithRootObject(self))
    }
    
    // The initializer creates a new instance of the originator class from the memento rather than setting the state of an existing object.
    
    func applyMemento(memento: Memento) {
        if let lmemento = memento as? LedgerMemento {
            if let obj = NSKeyedUnarchiver.unarchiveObjectWithData(lmemento.data) as? Ledger {
                self.total = obj.total
                self.nextId = obj.nextId
                self.entries = obj.entries
            }
        }
    }
    
    func addEntry(counterParty: String, amount: Float) {
        let entry = LedgerEntry(id: nextId, counterParty: counterParty, amount: amount)
        nextId += 1
        entries[entry.id] = entry
        total += amount
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