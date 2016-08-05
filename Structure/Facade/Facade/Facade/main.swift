//
//  main.swift
//  Facade
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let facade = PirateFacade()

//if let prize = facade.getTreasure(TreasureTypes.SHIP) {
//    print("Prize \(prize) pieces of eight")
//}

if let prize = facade.getTreasure(TreasureTypes.SHIP) {
    facade.crew.performAction(PirateCrew.Actions.DIVE_FOR_JEWELS) { secondPrize in
        print("Prize \(prize + secondPrize) pieces of eight")
    }
}

NSFileHandle.fileHandleWithStandardInput().availableData