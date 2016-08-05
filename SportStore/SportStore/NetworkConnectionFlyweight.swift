//
//  NetworkConnectionFlyweight.swift
//  SportStore
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol NetConnFlyweight {
    func getStockLevel(name: String) -> Int?
}

class NetConnFlyweightFactory {
    class func createFlyweight() -> NetConnFlyweight {
        return NetConnFlyweightImpl(data: stockData)
    }
    
    private class var stockData: [String:Int] {
        struct SingletonWrapper {
            static let singleton = ["Kayak": 10, "Lifejacket": 14, "Soccer Ball": 32, "Corner Flags": 1,
                    "Stadium": 4, "Thinking Cap": 8, "Unsteady Chair": 3, "Human Chess Board": 2, "Bling-Bling King": 4]
        }
        return SingletonWrapper.singleton
    }
}

class NetConnFlyweightImpl: NetConnFlyweight {
    private let extrinsicData: [String:Int]
    
    private init(data: [String:Int]) {
        self.extrinsicData = data
    }
    
    func getStockLevel(name: String) -> Int? {
        return extrinsicData[name]
    }
}