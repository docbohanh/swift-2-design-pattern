//
//  Product-decrecated.swift
//  SportStore
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

/* ------- The Previous Product class - decrecated -------

class Product: NSObject, NSCopying {
    
    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    private var stockLevelBackingValue: Int = 0
    private var priceBackingValue: Double = 0
    private var salesTaxRate: Double = 2.2
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        
        super.init()
        
        self.price = price
        self.stockLevel = stockLevel
    }
    
    class func createProduct(name: String, description: String, category: String, price: Double, stockLevel: Int) -> Product {
        var productType: Product.Type
        
        switch category {
        case "Watersports":
            productType = WatersportsProduct.self
        case "Soccer":
            productType = SoccerProduct.self
        default:
            productType = Product.self
        }
        
        return productType.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
    }
    
    var stockLevel: Int {
        get { return stockLevelBackingValue }
        set { stockLevelBackingValue = max(0, newValue) }
    }
    
    private(set) var price: Double {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue) }
    }
    
    var stockValue: Double {
        get {
            return (price * (1 + salesTaxRate)) * Double(stockLevel)
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Product(name: self.name, description: self.productDescription, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
    var upsells: [UpsellOpportunities] {
        return []
    }
    
}

enum UpsellOpportunities {
    case SwimmingLessons
    case MapOfLakes
    case SoccerVideos
}

class WatersportsProduct: Product {
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.10
    }
    
    override var upsells: [UpsellOpportunities] {
        return [.SwimmingLessons, .MapOfLakes]
    }
    
}

class SoccerProduct: Product {
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.25
    }
    
    override var upsells: [UpsellOpportunities] {
        return [.SoccerVideos]
    }
    
}
 
 ---------------------------*/