//
//  SystemComponents.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class ActivityLog: Observer {
    func notify(notification: Notification) {
        print("Auth request for \(notification.type.rawValue). Success: \(notification.data!)")
    }
    
    func logActivity(activity: String) {
        print("Log: \(activity)")
    }
}

class FileCache: Observer {
    func notify(notification: Notification) {
        if let authNotification = notification as? AuthenticationNotification {
            if let username = authNotification.userName where authNotification.requestSuccessed {
                self.loadFiles(username)
            }
        }
    }
        
    func loadFiles(user: String) {
        print("Load files for \(user)")
    }
}

class AttackMonitor: Observer {
    func notify(notification: Notification) {
        monitorSuspiciousActivity = notification.type == .AUTH_FAIL
    }
    
    var monitorSuspiciousActivity: Bool = false {
        didSet {
            print("Monitoring for attack: \(monitorSuspiciousActivity)")
        }
    }
}