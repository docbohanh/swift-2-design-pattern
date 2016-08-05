//
//  Shapes.swift
//  Visitor
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Circle {
    let radius: Float
    
    init(radius: Float) {
        self.radius = radius
    }
}

class Square {
    let length: Float
    
    init(length: Float) {
        self.length = length
    }
}

class Rectangle {
    let xLen: Float
    let yLen: Float
    
    init(x: Float, y: Float) {
        self.xLen = x
        self.yLen = y
    }
}

class ShapeCollection {
    let shapes: [Any]
    
    init() {
        shapes = [Circle(radius: 2.5), Square(length: 4), Rectangle(x: 10, y: 2)]
    }
    
    func calculateAreas() -> Float {
        return shapes.reduce(0) {(total, shape) in
            if let circle = shape as? Circle {
                print("Found Circle")
                return total + (3.14 * powf(circle.radius, 2))
            } else if let square = shape as? Square {
                print("Found Square")
                return total + powf(square.length, 2)
            } else if let rect = shape as? Rectangle {
                print("Found Rectangle")
                return total + rect.xLen * rect.yLen
            } else {
                return total
            }
        }
    }
    
    func countEdges() -> Int {
        return shapes.reduce(0) { (total, shape) in
            if shape is Circle {
                print("Found Circle")
                return total + 1
            } else if shape is Square {
                print("Found Square")
                return total + 4
            } else if shape is Rectangle {
                print("Found Rectangle")
                return total + 4
            } else {
                return total
            }
        }
    }
}