//
//  main.swift
//  Memento
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let ledger = Ledger()

ledger.addEntry("Bob", amount: 100.43)
ledger.addEntry("Joe", amount: 200.20)

let memento = ledger.createMemento() as? LedgerMemento
let newMemento = LedgerMemento(json: memento?.jsonData)
ledger.applyMemento(newMemento)

ledger.printEntries()