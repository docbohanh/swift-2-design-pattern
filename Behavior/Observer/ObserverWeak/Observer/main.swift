//
//  main.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let log = ActivityLog()
let cache = FileCache()
let monitor = AttackMonitor()

let authM = AuthenticationManager()
authM.addObservers(log, cache, monitor)

authM.authenticate("bob", pass: "secret")
print("-----")
authM.authenticate("joe", pass: "shhh")