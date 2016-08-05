//
//  Observer.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Observer: class {
    func notify(user: String, success: Bool)
}

protocol Subject {
    func addObservers(observers: Observer...)
    func removeObserver(observer: Observer)
}

class SubjectBase: Subject {
    private var observers = [Observer]()
    private var collectionQueue = dispatch_queue_create("colQ", DISPATCH_QUEUE_CONCURRENT)
    
    func addObservers(observers: Observer...) {
        dispatch_barrier_sync(self.collectionQueue) { 
            for newOb in observers {
                self.observers.append(newOb)
            }
        }
    }
    
    func removeObserver(observer: Observer) {
        dispatch_barrier_sync(self.collectionQueue) { 
            self.observers = self.observers.filter { $0 !== observer }
        }
    }
    
    func sendNotification(user: String, success: Bool) {
        dispatch_sync(self.collectionQueue) {
            for ob in self.observers {
                ob.notify(user, success: success)
            }
        }
    }
}