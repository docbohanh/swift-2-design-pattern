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
    private let itemAllocator: [T] -> Int
    private let maxItemCount: Int
    private var createdCount = 0
    
    init(itemCount: Int, itemFactory: () -> T, itemAllocator: [T] -> Int) {
        self.maxItemCount = itemCount
        self.itemFactory = itemFactory
        self.itemAllocator = itemAllocator
        self.semaphore = dispatch_semaphore_create(itemCount)
    }
    
    func getFromPool(maxWaitSeconds: Int = -1) -> T? {
        var result: T?
        
        if dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) == 0 {
            dispatch_sync(arrayQ) {
                if self.data.count == 0 {
                    result = self.itemFactory()
                    self.createdCount += 1
                } else {
                    result = self.data.removeAtIndex(self.itemAllocator(self.data))
                }
            }
        }
        return result
    }
    
    func returnToPool(item: T) {
        dispatch_async(arrayQ) { 
            self.data.append(item)
            dispatch_semaphore_signal(self.semaphore)
        }
    }
    
    func processPoolItems(callback: [T] -> Void) {
        dispatch_barrier_sync(arrayQ) { 
            callback(self.data)
        }
    }
}