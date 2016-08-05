//
//  Options.swift
//  Decorator
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class BasePurchaseDecorator: Purchase {
    private let wrappedPurchase: Purchase
    
    init(purchase: Purchase) {
        wrappedPurchase = purchase
        super.init(product: purchase.description, price: purchase.totalPrice)
    }
}

class PurchaseWithGiftWrap: BasePurchaseDecorator {
    override var description: String { return "\(super.description) + giftwrap" }
    override var totalPrice: Float { return super.totalPrice + 2 }
}

class PurchaseWithRibbon: BasePurchaseDecorator {
    override var description: String { return "\(super.description) + ribbon" }
    override var totalPrice: Float { return super.totalPrice + 1 }
}

class PurchaseWithDelivery: BasePurchaseDecorator {
    override var description: String { return "\(super.description) + delivery" }
    override var totalPrice: Float { return super.totalPrice + 5 }
}

// Consolidated Decorators

class GiftOptionDecorator: Purchase {
    private let wrapperedPurchase: Purchase
    private let options: [OPTION]
    
    enum OPTION {
        case GIFTWRAP
        case RIBBON
        case DELIVERY
    }
    
    init(purchase: Purchase, options: OPTION...) {
        self.wrapperedPurchase = purchase
        self.options = options
        super.init(product: purchase.description, price: purchase.totalPrice)
    }
    
    override var description: String {
        var result = wrapperedPurchase.description
        for option in options {
            switch option {
            case .GIFTWRAP:
                result = "\(result) + giftwrap"
            case .RIBBON:
                result = "\(result) + ribbon"
            case .DELIVERY:
                result = "\(result) + delivery"
            }
        }
        return result
    }
    
    override var totalPrice: Float {
        var result = wrapperedPurchase.totalPrice
        for option in options {
            switch option {
            case .GIFTWRAP:
                result += 2
            case .RIBBON:
                result += 1
            case .DELIVERY:
                result += 5
            }
        }
        return result
    }
}