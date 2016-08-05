//
//  PirateCrew.swift
//  Facade
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class PirateCrew {
    let workQueue = dispatch_queue_create("crewWorkQ", DISPATCH_QUEUE_SERIAL)
    
    enum Actions {
        case ATTACK_SHIP; case DIG_FOR_GOLD; case DIVE_FOR_JEWELS
    }
    
    func performAction(action: Actions, callback: Int -> Void) {
        dispatch_async(workQueue) {
            var prizeValue = 0
            switch action {
            case .ATTACK_SHIP:
                prizeValue = 10000
            case .DIG_FOR_GOLD:
                prizeValue = 5000
            case .DIVE_FOR_JEWELS:
                prizeValue = 1000
            }
            callback(prizeValue)
        }
    }
}