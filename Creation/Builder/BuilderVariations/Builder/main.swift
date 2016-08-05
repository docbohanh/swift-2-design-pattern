//
//  main.swift
//  Builder
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// Step 1 - Ask for name
let name = "Joe"

// Step 2 - Select a Product
let builder = BurgerBuilder.getBuilder(Burgers.BIGBURGER)

// Step 3 - Customize burger?
builder.setMayo(false)
builder.setCooked(Burger.Cooked.WELLDONE)

let order = builder.buildObject(name)

order.printDescription()