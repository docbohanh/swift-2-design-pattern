//
//  Suspension.swift
//  AbstractFactory
//
//  Created by HungDo on 7/31/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Suspension {
    var suspensionType: SuspensionOption { get }
}

enum SuspensionOption: String {
    case STANDARD = "Standard"; case SPORTS = "Firm"; case SOFT = "Soft"
}

class RoadSuspension: Suspension {
    var suspensionType = SuspensionOption.STANDARD
}

class OffRoadSuspension: Suspension {
    var suspensionType = SuspensionOption.SOFT
}

class RaceSuspension: Suspension {
    var suspensionType = SuspensionOption.SPORTS
}