//
//  main.swift
//  Builder
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

var builder = BurgerBuilder()

// Step 1 - Ask for name
let name = "Joe"

// Step 2 - Is veggie meal requried? - Can ommit
builder.setVeggie(false)

// Step 3 - Customize burger?
builder.setMayo(false)
builder.setCooked(Burger.Cooked.WELLDONE)

// Step 4 - Buy additional patty?
builder.addParty(false)

let order = builder.buildObject(name)

order.printDescription()