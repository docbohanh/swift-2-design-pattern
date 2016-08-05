//
//  StockValueFactories.swift
//  SportStore
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class StockTotalFactory {
    
    enum Currency {
        case USD
        case GBP
        case EUR
    }
    
    private(set) var formatter: StockValueFormatter?
    private(set) var converter: StockValueConverter?
    
    class func getFactory(curr: Currency) -> StockTotalFactory {
        if curr == Currency.USD {
            return DollarStockValueFactory.sharedInstance
        } else if curr == Currency.GBP {
            return PoundStockValueFactory.sharedInstance
        } else {
            return EuroHandlerAdapter.sharedInstance
        }
    }
    
}

private class DollarStockValueFactory: StockTotalFactory {
    
    private override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }
    
    class var sharedInstance: StockTotalFactory {
        struct SingletonWrapper {
            static let singleton = DollarStockValueFactory()
        }
        return SingletonWrapper.singleton
    }
    
}

private class PoundStockValueFactory: StockTotalFactory {
    
    private override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }
    
    class var sharedInstance: StockTotalFactory {
        struct SingletonWrapper {
            static let singleton = PoundStockValueFactory()
        }
        return SingletonWrapper.singleton
    }
    
}

class EuroHandlerAdapter: StockTotalFactory, StockValueConverter, StockValueFormatter {
    private let handler: EuroHandler
    
    override init() {
        self.handler = EuroHandler()
        super.init()
        super.formatter = self
        super.converter = self
    }
    
    func formatTotal(total: Double) -> String {
        return handler.getDisplayString(total)
    }
    
    func convertTotal(total: Double) -> Double {
        return handler.getcurrentAmount(total)
    }
    
    class var sharedInstance: EuroHandlerAdapter {
        struct SingletonWrapper {
            static let singleton = EuroHandlerAdapter()
        }
        return SingletonWrapper.singleton
    }
}