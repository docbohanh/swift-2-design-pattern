//
//  Suspension.swift
//  AbstractFactory
//
//  Created by HungDo on 7/31/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Suspension: class {
    var suspensionType: SuspensionOption { get }
    static func getInstance() -> Suspension
}

//enum SuspensionOption: String {
//    case STANDARD = "Standard"; case SPORTS = "Firm"; case SOFT = "Soft"
//}

class RoadSuspension: Suspension {
    var suspensionType = SuspensionOption.STANDARD
    
    private init() {}
    
    class func getInstance() -> Suspension {
        return RoadSuspension()
    }
}

class OffRoadSuspension: Suspension {
    var suspensionType = SuspensionOption.SOFT
    
    private init() {}
    
    class func getInstance() -> Suspension {
        return OffRoadSuspension()
    }
}

class RaceSuspension: NSObject, NSCopying, Suspension {
    var suspensionType = SuspensionOption.SPORTS
    
    private override init() {}
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return RaceSuspension()
    }
    
    private class var prototype: RaceSuspension {
        struct SingletonWrapper {
            static let singleton = RaceSuspension()
        }
        return SingletonWrapper.singleton
    }
    
    static func getInstance() -> Suspension {
        return prototype.copy() as! Suspension
    }
}