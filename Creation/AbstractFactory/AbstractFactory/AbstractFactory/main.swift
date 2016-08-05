//
//  main.swift
//  AbstractFactory
//
//  Created by HungDo on 7/31/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let factory = CarFactory.getFactory(Cars.SPORTS)

if let factory = factory {
    let car = Car(
        carType: .SPORTS,
        floor: factory.createFloorplan(),
        suspension: factory.createSuspension(),
        drive: factory.createDrivetrain()
    )
    
    car.printDetails()
}