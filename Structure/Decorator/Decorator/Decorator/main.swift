//
//  main.swift
//  Decorator
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let account = CustomerAccount(name: "Joe")

account.addPurchase(Purchase(product: "Red Hat", price: 10))
account.addPurchase(Purchase(product: "Scarf", price: 20))

account.addPurchase(
    EndOfLineDecorator(purchase:
        BlackFridayDecorator(purchase:
            GiftOptionDecorator(
                purchase: Purchase(product: "Sunglasses", price: 25),
                options: .GIFTWRAP, .DELIVERY
            )
        )
    )
)

account.addPurchase(
    EndOfLineDecorator(purchase:
        PurchaseWithGiftWrap(purchase:
            PurchaseWithDelivery(purchase:
                BlackFridayDecorator(purchase:
                    Purchase(product: "Sunglasses", price: 25)
                )
            )
        )
    )
)

account.addPurchase(
    EndOfLineDecorator(purchase:
        BlackFridayDecorator(purchase:
            PurchaseWithDelivery(purchase:
                PurchaseWithGiftWrap(purchase:
                    Purchase(product: "Sunglasses", price: 25)
                )
            )
        )
    )
)

account.printAccount()

for p in account.purchases {
    if let d = p as? DiscountDecorator {
        print("\(p) has \(d.countDiscounts()) discounts")
    } else {
        print("\(p) has no discounts")
    }
}