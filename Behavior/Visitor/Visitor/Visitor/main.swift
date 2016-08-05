//
//  main.swift
//  Visitor
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let shapes = ShapeCollection()
let area = shapes.calculateAreas()
print("Area: \(area)")
print("------")
let edges = shapes.countEdges()
print("Edges: \(edges)")