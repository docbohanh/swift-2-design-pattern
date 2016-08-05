//
//  Euro.swift
//  SportStore
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class EuroHandler {
    func getDisplayString(amount: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(amount)
        return "€\(dropFirst(formatted))"
        
    }
    
    func getcurrentAmount(amount: Double) -> Double {
        return 0.76164 * amount
    }
}