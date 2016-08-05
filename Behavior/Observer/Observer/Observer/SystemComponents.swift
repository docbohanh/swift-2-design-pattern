//
//  SystemComponents.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class ActivityLog: Observer {
    func notify(user: String, success: Bool) {
        print("Auth request for \(user). Success: \(success)")
    }
    
    func logActivity(activity: String) {
        print("Log: \(activity)")
    }
}

class FileCache: Observer {
    func notify(user: String, success: Bool) {
        if success {
            loadFiles(user)
        }
    }
    
    func loadFiles(user: String) {
        print("Load files for \(user)")
    }
}

class AttackMonitor: Observer {
    func notify(user: String, success: Bool) {
        monitorSuspiciousActivity = !success
    }
    
    var monitorSuspiciousActivity: Bool = false {
        didSet {
            print("Monitoring for attack: \(monitorSuspiciousActivity)")
        }
    }
}