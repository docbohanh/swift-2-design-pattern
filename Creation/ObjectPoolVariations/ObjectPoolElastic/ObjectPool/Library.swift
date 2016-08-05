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
            peakCount: stockLevel * 2,
            returnCount: stockLevel / 2,
            itemFactory: {
                stockId += 1
                return BookSeller.buyBook(author: "Dickens, Charles", title: "Hard Times", stockNumber: stockId - 1)
            },
            peakFactory: {
                stockId += 1
                return LibraryNetwork.borrowBook(author: "Dickens, Charles", title: "Hard Times", stockNumber: stockId - 1)
            },
            reaper: LibraryNetwork.returnBook
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