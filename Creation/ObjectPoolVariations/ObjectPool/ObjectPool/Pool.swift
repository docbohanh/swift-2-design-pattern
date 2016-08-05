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
    private var itemCount = 0
    private let maxItemCount: Int
    private let itemFactory: () -> T
    private var ejectedItems = 0
    private var poolExhausted = false
    
    init(maxItemCount: Int, factory: () -> T) {
        self.itemFactory = factory
        self.maxItemCount = maxItemCount
        semaphore = dispatch_semaphore_create(maxItemCount)
    }
    
    func getFromPool(maxWaitSeconds: Int = -1) -> T? {
        var result: T?
        
        
        // You can use the DISPATCH_TIME_NOW constant only as an argument to the dispatch_time function.
        // If you use it outside of the function, it returns a value of zero.
        let waitTime = maxWaitSeconds == -1 ? DISPATCH_TIME_FOREVER :
                    dispatch_time(DISPATCH_TIME_NOW, (Int64(maxWaitSeconds) * Int64(NSEC_PER_SEC)))
        
        if !poolExhausted {
            if dispatch_semaphore_wait(semaphore, waitTime) == 0 {
                if !poolExhausted {
                    dispatch_sync(arrayQ) {
                        if self.data.count == 0 && self.itemCount < self.maxItemCount {
                            result = self.itemFactory()
                            self.itemCount += 1
                        } else {
                            result = self.data.removeAtIndex(0)
                        }
                    }
                }
            }
        }
        return result
    }
    
    func returnToPool(item: T) {
        dispatch_async(arrayQ) { 
//            let pitem = item as AnyObject as? PoolItem
//            if pitem != nil && pitem!.canReuse {
//                self.data.append(item)
//                dispatch_semaphore_signal(self.semaphore)
//            }
            if let pitem = item as AnyObject as? PoolItem {
                if pitem.canReuse {
                    self.data.append(item)
                    dispatch_semaphore_signal(self.semaphore)
                } else {
                    self.ejectedItems += 1
                    if self.ejectedItems == self.maxItemCount {
                        self.poolExhausted = true
                        self.flushQueue()
                    }
                }
            } else {
                self.data.append(item)
            }
        }
    }
    
    private func flushQueue() {
        let dQueue = dispatch_queue_create("drainer", DISPATCH_QUEUE_CONCURRENT)
        var backlogCleared = false
        
        // GCD semaphores allow threads to pass in FIFO order, which means that this block won't be allowed
        // to pass the semophore until all of the waiting requests that arrived before the queue was exhausted
        // have also been allowed to pass.
        
        dispatch_async(dQueue) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            backlogCleared = true
        }
        
        dispatch_async(dQueue) {
            while !backlogCleared {
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