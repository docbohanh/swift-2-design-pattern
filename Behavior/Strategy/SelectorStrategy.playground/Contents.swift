//: Playground - noun: a place where people can play

import Foundation

@objc class City: NSObject {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func compareTo(other: City) -> NSComparisonResult {
        if self.name == other.name {
            return .OrderedSame
        } else if self.name < other.name {
            return .OrderedDescending
        } else {
            return .OrderedAscending
        }
    }
}

let nsArray = NSArray(array: [City("London"), City("New York"), City("Paris"), City("Rome")])
let sorted = nsArray.sortedArrayUsingSelector(#selector(City.compareTo(_:)))

for city in sorted {
    if let city = city as? City {
        print(city.name)
    }
}