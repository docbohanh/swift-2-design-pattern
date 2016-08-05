//
//  main.swift
//  FactoryMethod
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let passengers = [1, 3, 5]

for p in passengers {
    print("\(p) passengers: \(CarSelector.selectCar(p)!)")
}