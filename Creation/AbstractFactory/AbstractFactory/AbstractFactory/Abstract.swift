//
//  Abstract.swift
//  AbstractFactory
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class CarFactory {
    func createFloorplan() -> Floorplan {
        fatalError("Not implemented")
    }
    
    func createSuspension() -> Suspension {
        fatalError("Not implemented")
    }
    
    func createDrivetrain() -> Drivetrain {
        fatalError("Not implemented")
    }
    
    final class func getFactory(car: Cars) -> CarFactory? {
        var factory: CarFactory?
        switch car {
        case .COMPACT:
            factory = CompactCarFactory()
        case .SPORTS:
            factory = SportsCarFactory()
        case .SUV:
            factory = SUVCarFactory()
        }
        return factory
    }
}