//
//  Logger.swift
//  Singleton
//
//  Created by HungDo on 7/29/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// 1. Lazily
// 2. Thread-safe initialization
let globalLogger = Logger()

final class Logger {
    
    private var data = [String]()
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    
    private init() {}
    
    func log(msg: String) {
        dispatch_sync(arrayQ) {
            self.data.append(msg)
        }
    }
    
    func printLog() {
        for msg in data {
            print("Log: \(msg)")
        }
    }
    
}