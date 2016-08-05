//
//  Pool.swift
//  ObjectPool
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Pool<T: AnyObject> {
    private var data = [T]()
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    private let semaphore: dispatch_semaphore_t
    
    private let itemFactory: () -> T
    private let peakFactory: () -> T
    private let peakReaper: (T) -> Void
    
    private var createdCount: Int = 0
    private let normalCount: Int
    private let peakCount: Int
    private let returnCount: Int
    private let waitTime: Int
    
    init(itemCount: Int, peakCount: Int, returnCount: Int, waitTime: Int = 2, itemFactory: () -> T, peakFactory: () -> T, reaper: (T) -> Void) {
        self.normalCount = itemCount
        self.peakCount = peakCount
        self.waitTime = waitTime
        self.returnCount = returnCount
        self.itemFactory = itemFactory
        self.peakFactory = peakFactory
        self.peakReaper = reaper
        self.semaphore = dispatch_semaphore_create(itemCount)
    }
    
    func getFromPool(maxWaitSeconds: Int = -1) -> T? {
        var result: T?
        let expiryTime = dispatch_time(DISPATCH_TIME_NOW, Int64(waitTime) * Int64(NSEC_PER_SEC))
        
        if dispatch_semaphore_wait(semaphore, expiryTime) == 0 {
            dispatch_sync(arrayQ) {
                if self.data.count == 0 {
                    result = self.itemFactory()
                    self.createdCount += 1
                } else {
                    result = self.data.removeAtIndex(0)
                }
            }
        } else  {
            dispatch_sync(arrayQ) {
                result = self.peakFactory()
                self.createdCount += 1
            }
        }
        return result
    }
    
    func returnToPool(item: T) {
        dispatch_async(arrayQ) {
            if self.data.count > self.returnCount && self.createdCount > self.normalCount {
                self.peakReaper(item)
                self.createdCount -= 1
            } else {
                self.data.append(item)
                dispatch_semaphore_signal(self.semaphore)
            }
        }
    }
    
    func processPoolItems(callback: [T] -> Void) {
        dispatch_barrier_sync(arrayQ) { 
            callback(self.data)
        }
    }
}