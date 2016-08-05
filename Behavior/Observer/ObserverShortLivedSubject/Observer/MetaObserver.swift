//
//  MetaObserver.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol MetaObserver: Observer {
    func notifySubjectCreated(subject: Subject)
    func notifySubjectDestroyed(subject: Subject)
}

// Mediator object

class MetaSubject: SubjectBase, MetaObserver {
    func notifySubjectCreated(subject: Subject) {
        sendNotification(Notification(type: .SUBJECT_CREATED, data: subject))
    }
    
    func notifySubjectDestroyed(subject: Subject) {
        sendNotification(Notification(type: .SUBJECT_DESTROYED, data: subject))
    }
    
    class var sharedInstance: MetaSubject {
        struct SingletonWrapper {
            static let singleton = MetaSubject()
        }
        return SingletonWrapper.singleton
    }
    
    func notify(notification: Notification) {
    }
}

class ShortLivedSubject: SubjectBase {
    override init() {
        super.init()
        MetaSubject.sharedInstance.notifySubjectCreated(self)
    }
    
    deinit {
        MetaSubject.sharedInstance.notifySubjectDestroyed(self)
    }
}