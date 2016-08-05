//
//  Observer.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

enum NotificationTypes: String {
    case AUTH_SUCCESS = "AUTH_SUCCESS"
    case AUTH_FAIL = "AUTH_FAIL"
}

// struct Notification {
class Notification {
    let type: NotificationTypes
    let data: Any?
    
    init(type: NotificationTypes, data: Any?) {
        self.type = type
        self.data = data
    }
}

// The observers have to know what data type to expect to be associated with a notification, and the subject have to honor that expectation.

class AuthenticationNotification: Notification {
    init(user: String, success: Bool) {
        super.init(type: success ? NotificationTypes.AUTH_SUCCESS : NotificationTypes.AUTH_FAIL, data: user)
    }
    
    var userName: String? {
        return self.data as? String
    }
    
    var requestSuccessed: Bool {
        return self.type == NotificationTypes.AUTH_SUCCESS
    }
}

protocol Observer: class {
    func notify(notification: Notification)
}

protocol Subject {
    func addObservers(observers: Observer...)
    func removeObserver(observer: Observer)
}

private class WeakObserverReference {
    weak var observer: Observer?
    
    init(observer: Observer) {
        self.observer = observer
    }
}

class SubjectBase: Subject {
    private var observers = [WeakObserverReference]()
    private var collectionQueue = dispatch_queue_create("colQ", DISPATCH_QUEUE_CONCURRENT)
    
    func addObservers(observers: Observer...) {
        dispatch_barrier_sync(self.collectionQueue) { 
            for newOb in observers {
                self.observers.append(WeakObserverReference(observer: newOb))
            }
        }
    }
    
    func removeObserver(observer: Observer) {
        dispatch_barrier_sync(self.collectionQueue) { 
            self.observers = self.observers.filter { $0.observer !== observer }
        }
    }
    
    func sendNotification(notification: Notification) {
        dispatch_sync(self.collectionQueue) {
            for ob in self.observers {
                ob.observer?.notify(notification)
            }
        }
    }
}