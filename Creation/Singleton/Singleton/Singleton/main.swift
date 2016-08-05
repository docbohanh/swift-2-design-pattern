//
//  main.swift
//  Singleton
//
//  Created by HungDo on 7/29/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

//import Foundation
//
//var server = BackupServer.server
//
//server.backup(DataItem(type: DataItem.ItemType.Email, data: "joe@example.com"))
//server.backup(DataItem(type: DataItem.ItemType.Phone, data: "555-123-1133"))
//
//globalLogger.log("Backed up 2 items to \(server.name)")
//
//var otherServer = BackupServer.server
//
//otherServer.backup(DataItem(type: DataItem.ItemType.Email, data: "bob@example.com"))
//
//globalLogger.log("Backed up 1 item to \(otherServer.name)")
//
//globalLogger.printLog()

import Foundation

var server = BackupServer.server

let queue = dispatch_queue_create("workQueue", DISPATCH_QUEUE_CONCURRENT)
let group = dispatch_group_create()

for count in 0  ..< 100 {
    dispatch_group_async(group, queue, { 
        server.backup(DataItem(type: DataItem.ItemType.Email, data: "bob@example.com"))
    })
}

dispatch_group_wait(group, DISPATCH_TIME_FOREVER)

print("\(server.getData().count) items were backed up")