//
//  PriceCalculator.swift
//  FactoryMethod
//
//  Created by HungDo on 7/31/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class PriceCalculator {
    class func calculatePrice(passengers: Int, days: Int) -> Float? {
        let car = RentalCar.createRentalCar(passengers)
        return car == nil ? nil : car!.pricePerDay * Float(days)
    }
}