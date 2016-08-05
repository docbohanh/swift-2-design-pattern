//
//  Purchase.swift
//  Decorator
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Purchase: CustomStringConvertible {
    private let product: String
    private let price: Float
    
    init(product: String, price: Float) {
        self.product = product
        self.price = price
    }
    
    var description: String {
        return product
    }
    
    var totalPrice: Float {
        return price
    }
}