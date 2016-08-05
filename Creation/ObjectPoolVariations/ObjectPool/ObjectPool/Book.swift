//
//  Book.swift
//  ObjectPool
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Book: PoolItem {
    let author: String
    let title: String
    let stockNumber: Int
    var reader: String? = nil
    var checkoutCount = 0
    
    init(author: String, title: String, stock: Int) {
        self.author = author
        self.title = title
        self.stockNumber = stock
    }
    
    var canReuse: Bool {
        let reuseable = checkoutCount < 5
        if !reuseable {
            print("Eject: Book#\(self.stockNumber)")
        }
        return reuseable
    }
}