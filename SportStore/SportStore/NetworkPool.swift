//
//  NetworkPool.swift
//  SportStore
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore: dispatch_semaphore_t
    private var queue: dispatch_queue_t
    private var itemsCreated = 0
    
    private init() {
        semaphore = dispatch_semaphore_create(connectionCount)
        queue = dispatch_queue_create("networkpoolQ", DISPATCH_QUEUE_SERIAL)
    }
    
    private func doGetConnection() -> NetworkConnection {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        var result: NetworkConnection?
        dispatch_sync(queue) {
            if self.connections.count > 0 {
                result = self.connections.removeAtIndex(0)
            } else if self.itemsCreated < self.connectionCount {
                result = NetworkConnection()
                self.itemsCreated += 1
            }
        }
        return result!
    }
    
    private func doReturnConnection(conn: NetworkConnection) {
        dispatch_async(queue) { 
            self.connections.append(conn)
            dispatch_semaphore_signal(self.semaphore)
        }
    }
    
    class func getConnection() -> NetworkConnection {
        return sharedInstance.doGetConnection()
    }
    
    class func returnConnection(conn: NetworkConnection) {
        sharedInstance.doReturnConnection(conn)
    }
    
    private class var sharedInstance: NetworkPool {
        struct SingletonWrapper {
            static let singleton = NetworkPool()
        }
        return SingletonWrapper.singleton
    }
}