//
//  NetworkConnection.swift
//  SportStore
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class NetworkConnection {
    private let flyweight: NetConnFlyweight
    
    init() {
        self.flyweight = NetConnFlyweightFactory.createFlyweight()
    }
    
    func getStockLevel(name: String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2))
        return self.flyweight.getStockLevel(name)
    }
    
    func setStockLevel(name: String, level: Int) {
        print("Stock update: \(name) = \(level)")
    }
}