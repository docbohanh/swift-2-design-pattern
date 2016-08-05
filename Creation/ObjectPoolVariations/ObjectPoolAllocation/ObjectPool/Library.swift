//
//  Library.swift
//  ObjectPool
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

final class Library {
    private let pool: Pool<Book>
    
    private init(stockLevel: Int) {
        var stockId = 1
        pool = Pool<Book>(
            itemCount: stockLevel,
            itemFactory: {
                stockId += 1
                return BookSeller.buyBook(author: "Dickens, Charles", title: "Hard Times", stockNumber: stockId - 1)
            },
            
            // This strategy selectes the least-used available object.
            // Taking into account all of the objects is called a "perfect allocation strategy", but it is rarely useful
            // because it means you BLOCK a request until the absolute least-used object becomes availables,
            // which may not happend for some time.
            
            itemAllocator: { books in
                var selected = 0
                for index in 1 ..< books.count {
                    if books[index].checkoutCount < books[selected].checkoutCount {
                        selected = index
                    }
                }
                return selected
            }
        )
    }
    
    private class var singleton: Library {
        struct SingletonWrapper {
            static let singleton = Library(stockLevel: 5)
        }
        return SingletonWrapper.singleton
    }
    
    class func checkoutBook(reader: String) -> Book? {
        let book = singleton.pool.getFromPool()
        book?.reader = reader
        book?.checkoutCount += 1
        return book
    }
    
    class func returnBook(book: Book) {
        book.reader = nil
        singleton.pool.returnToPool(book)
    }
    
    class func printReport() {
        singleton.pool.processPoolItems { books in
            for book in books {
                print("...Book#\(book.stockNumber)...")
                print("Checked out \(book.checkoutCount) times")
                if book.reader != nil {
                    print("Checked out to \(book.reader!)")
                } else {
                    print("In stock")
                }
            }
            print("There are \(books.count) books in the pool")
        }
    }
}