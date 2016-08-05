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
    var jsonData: String?
    
    init(ledger: Ledger) {
        stringify(ledger)
    }
    
    init(json: String?) {
        self.jsonData = json
    }
    
    private func stringify(ledger: Ledger) {
        let dict = NSMutableDictionary()
        
        dict["total"] = ledger.total
        dict["nextId"] = ledger.nextId
        dict["entries"] = [LedgerEntry](ledger.entries.values)
        
        var entryArray = [NSDictionary]()
        for entry in ledger.entries.values {
            let entryDict = NSMutableDictionary()
            entryArray.append(entryDict)
            entryDict["id"] = entry.id
            entryDict["counterParty"] = entry.counterParty
            entryDict["amount"] = entry.amount
        }
        dict["entries"] = entryArray
        
        if let jsonData = try? NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted) {
            self.jsonData = String(data: jsonData, encoding: NSUTF8StringEncoding)
        }
    }
    
    func apply(ledger: Ledger) {
        if let data = jsonData?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            if let jsonDict = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String:AnyObject],
                let dict = jsonDict {
                ledger.total = dict["total"] as! Float
                ledger.nextId = dict["nextId"] as! Int
                
                ledger.entries.removeAll(keepCapacity: true)
                if let entryDicts = dict["entries"] as? [NSDictionary] {
                    for dict in entryDicts {
                        let id = dict["id"] as! Int
                        let countryParty = dict["counterParty"] as! String
                        let amount = dict["amount"] as! Float
                        ledger.entries[id] = LedgerEntry(id: id, counterParty: countryParty, amount: amount)
                    }
                }
            }
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
        return LedgerMemento(ledger: self)
    }
    
    func applyMemento(memento: Memento) {
        if let m = memento as? LedgerMemento {
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