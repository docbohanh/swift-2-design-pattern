//: Playground - noun: a place where people can play

import Foundation

class LogItem {
    
    var from: String?
    @NSCopying var data: NSArray?
    
}

var dataArray = NSMutableArray(array: [1, 2, 3, 4])

var logItem = LogItem()
logItem.from = "Alice"
logItem.data = dataArray

dataArray[1] = 10
print("Value: \(logItem.data![1])")