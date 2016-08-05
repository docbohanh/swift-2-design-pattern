//
//  BookSeller.swift
//  ObjectPool
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class BookSeller {
    class func buyBook(author author: String, title: String, stockNumber: Int) -> Book {
        return Book(author: author, title: title, stock: stockNumber)
    }
}

class LibraryNetwork {
    class func borrowBook(author author: String, title: String, stockNumber: Int) -> Book {
        return Book(author: author, title: title, stock: stockNumber)
    }
    
    class func returnBook(book: Book) {
        
    }
}