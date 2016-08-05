//
//  main.swift
//  MediatorBase
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let mediator = MessageMediator()

// initial setup
let british = Airplane(name: "BA706", initalPos: Position(distanceFromRunway: 11, height: 21000), mediator: mediator)

// new plane arrives
let american = Airplane(name: "AA101", initalPos: Position(distanceFromRunway: 12, height: 22000), mediator: mediator)

// plane approaches airport
british.changePosition(Position(distanceFromRunway: 8, height: 10000))
british.changePosition(Position(distanceFromRunway: 2, height: 5000))
british.changePosition(Position(distanceFromRunway: 1, height: 1000))

// new plane arrives
let cathay = Airplane(name: "CX200", initalPos: Position(distanceFromRunway: 13, height: 22000), mediator: mediator)

// plane lands
british.land()

// plane moves too close
cathay.changePosition(Position(distanceFromRunway: 12, height: 22000))