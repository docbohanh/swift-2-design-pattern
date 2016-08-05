//: Playground - noun: a place where people can play

import Foundation

class Owner: NSObject, NSCopying {
    var name: String
    var city: String
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        print("Copy")
        return Owner(name: self.name, city: self.city)
    }
}

class FlyweightFactory {
    class func createFlyweight() -> Flyweight {
        return Flyweight(owner: ownerSingleton)
    }
    
    private class var ownerSingleton: Owner {
        struct SingletonWrapper {
            static let singleton = Owner(name: "Anonymous", city: "Anywhere")
        }
        return SingletonWrapper.singleton
    }
}

class Flyweight {
    private let extrinsicOwner: Owner
    private var intrinsicOwner: Owner?
    
    init(owner: Owner) {
        self.extrinsicOwner = owner
    }
    
    var name: String {
        get {
            return intrinsicOwner?.name ?? extrinsicOwner.name
        }
        set (value) {
            decoupleFromExtrinsic()
            intrinsicOwner?.name = value
        }
    }
    
    var city: String {
        get {
            return intrinsicOwner?.city ?? extrinsicOwner.city
        }
        set (value) {
            decoupleFromExtrinsic()
            intrinsicOwner?.city = value
        }
    }
    
    private func decoupleFromExtrinsic() {
        if intrinsicOwner == nil {
            intrinsicOwner = extrinsicOwner.copyWithZone(nil) as? Owner
        }
    }
}