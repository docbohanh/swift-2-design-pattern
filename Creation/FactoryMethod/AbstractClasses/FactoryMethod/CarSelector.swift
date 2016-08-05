//
//  CarSelector.swift
//  FactoryMethod
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class CarSelector {
    class func selectCar(passengers: Int) -> String? {
        return RentalCar.createRentalCar(passengers)?.name
    }
}