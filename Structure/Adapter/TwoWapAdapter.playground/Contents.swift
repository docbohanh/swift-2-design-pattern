//: Playground - noun: a place where people can play

import Foundation

protocol ShapeDrawer {
    func drawShape()
}

class DrawingApp {
    let drawer: ShapeDrawer
    var cornerRadius: Int = 0
    
    init(drawer: ShapeDrawer) {
        self.drawer = drawer
    }
    
    func makePicture() {
        drawer.drawShape()
    }
}

// Component library

protocol AppSettings {
    var sketchRoundedShapes: Bool { get }
}

class SketchComponent {
    private let settings: AppSettings
    
    init(settings: AppSettings) {
        self.settings = settings
    }
    
    func sketchShape() {
        if settings.sketchRoundedShapes {
            print("Sketch Circle")
        } else {
            print("Sketch Square")
        }
    }
}

// Adapter

class TwoWayApdater: ShapeDrawer, AppSettings {
    weak var app: DrawingApp?
    weak var component: SketchComponent?
    
    func drawShape() {
        component?.sketchShape()
    }
    
    var sketchRoundedShapes: Bool {
        return app?.cornerRadius > 0
    }
}

// Main

let adapter = TwoWayApdater()
let component = SketchComponent(settings: adapter)
let app = DrawingApp(drawer: adapter)

adapter.app = app
adapter.component = component

app.makePicture()