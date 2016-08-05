//
//  main.swift
//  Visitor
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let shapes = ShapeCollection()
let areaVisitor = AreaVisitor()
shapes.accept(areaVisitor)
print("Area: \(areaVisitor.totalArea)")
print("------")
let edgeVisitor = EdgesVisitor()
shapes.accept(edgeVisitor)
print("Edges: \(edgeVisitor.totalEdges)")