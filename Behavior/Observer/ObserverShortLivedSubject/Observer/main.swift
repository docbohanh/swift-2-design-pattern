//
//  main.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let monitor = AttackMonitor()
MetaSubject.sharedInstance.addObservers(monitor)

let log = ActivityLog()
let cache = FileCache()

let authM = AuthenticationManager()
authM.addObservers(cache, monitor)

authM.authenticate("bob", pass: "secret")
print("-----")
authM.authenticate("joe", pass: "shhh")