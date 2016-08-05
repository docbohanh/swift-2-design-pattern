//
//  main.swift
//  ReferenceCounting
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let queue = dispatch_queue_create("requestQ", DISPATCH_QUEUE_CONCURRENT)

for count in 0 ..< 3 {
    let connection = NetworkConnectionFactory.createNetworkConnection()
    
    dispatch_async(queue) {
        connection.connect()
        connection.sendCommand("Command: \(count)")
        connection.disconnect()
    }
}

NSFileHandle.fileHandleWithStandardInput().availableData