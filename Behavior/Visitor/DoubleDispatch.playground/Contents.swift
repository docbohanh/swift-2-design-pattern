//: Playground - noun: a place where people can play

import Foundation

protocol MyProtocol {
    func dispatch(handler: Handler)
}

class FirstClass: MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(self)
    }
}

class SecondClass: MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(self)
    }
}

class Handler {
    func handle(arg: MyProtocol) {
        print("Protocol")
    }
    
    func handle(arg: FirstClass) {
        print("First Class")
    }
    
    func handle(arg: SecondClass) {
        print("Second Class")
    }
}

let objects: [MyProtocol] = [FirstClass(), SecondClass()]
let handler = Handler()

for object in objects {
    handler.handle(object)
}

print("-----")

for object in objects {
    object.dispatch(handler)
}