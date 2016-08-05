//
//  Proxy.swift
//  SportStore
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol StockServer {
    func getStockLevel(product: String, callback: (String, Int) -> Void)
    func setStockLevel(product: String, stockLevel: Int)
}

class StockServerFactory {
    class func getStockServer() -> StockServer {
        return server
    }
    
    private class var server: StockServer {
        struct SingletonWrapper {
            static let singleton = StockServerProxy()
        }
        return SingletonWrapper.singleton
    }
}

class StockServerProxy: StockServer {
    func getStockLevel(product: String, callback: (String, Int) -> Void) {
        let stockConn = NetworkPool.getConnection()
        if let level = stockConn.getStockLevel(product) {
            callback(product, level)
        }
        NetworkPool.returnConnection(stockConn)
    }
    
    func setStockLevel(product: String, stockLevel: Int) {
        let stockConn = NetworkPool.getConnection()
        stockConn.setStockLevel(product, level: stockLevel)
        NetworkPool.returnConnection(stockConn)
    }
}