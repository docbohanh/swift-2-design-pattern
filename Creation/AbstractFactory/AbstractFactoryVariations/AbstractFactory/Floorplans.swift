//
//  Floorplans.swift
//  AbstractFactory
//
//  Created by HungDo on 7/31/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Floorplan {
    var seats: Int { get }
    var enginePosition: EngineOption { get }
}

enum EngineOption: String {
    case FRONT = "Front"; case MID = "Mid"
}

class ShortFloorplan: Floorplan {
    var seats = 2
    var enginePosition = EngineOption.MID
}

class StandardFloorplan: Floorplan {
    var seats = 4
    var enginePosition = EngineOption.FRONT
}

class LongFloorplan: Floorplan {
    var seats = 8
    var enginePosition = EngineOption.FRONT
}