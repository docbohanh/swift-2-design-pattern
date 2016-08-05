//
//  main.swift
//  KVO
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Subject: NSObject {
    dynamic var counter = 0
}

class Observer: NSObject {
    init(subject: Subject) {
        super.init()
        subject.addObserver(self, forKeyPath: "counter", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("Notification: \(keyPath!) = \(change![NSKeyValueChangeNewKey]!)")
    }
}

let subject = Subject()
let observer = Observer(subject: subject)
subject.counter += 1
subject.counter = 22