//
//  StockTotalFacade.swift
//  SportStore
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class StockTotalFacade {
    enum Currency {
        case USD; case GBP; case EUR
    }
    
    class func formatCurrencyAmount(amount: Double, currency: Currency) -> String? {
        var stfCurrency: StockTotalFactory.Currency
        switch currency {
        case .EUR:
            stfCurrency = StockTotalFactory.Currency.EUR
        case .GBP:
            stfCurrency = StockTotalFactory.Currency.GBP
        case .USD:
            stfCurrency = StockTotalFactory.Currency.USD
        }
        let factory = StockTotalFactory.getFactory(stfCurrency)
        if let totalAmount = factory.converter?.convertTotal(amount),
            let formattedValue = factory.formatter?.formatTotal(totalAmount) {
            return formattedValue
        }
        return nil
    }
}