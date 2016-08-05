//
//  Orders.swift
//  Composite
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class CustomerOrder {
    let customer: String
    let parts: [CarPart]
    
    init(customer: String, parts: [CarPart]) {
        self.customer = customer
        self.parts = parts
    }
    
    var totalPrice: Float {
        return parts.reduce(0) { $0 + $1.price }
    }
    
    func printDetails() {
        print("Order for \(customer): Cost: \(formatCurrencyString(totalPrice))")
    }
    
    func formatCurrencyString(number: Float) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(number) ?? ""
    }
}