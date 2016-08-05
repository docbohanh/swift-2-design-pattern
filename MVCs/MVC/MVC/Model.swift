//
//  Model.swift
//  MVC
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
}

class Person: Equatable, CustomStringConvertible {
    var name: String
    var city: String
    
    init(_ name: String, _ city: String) {
        self.name = name
        self.city = city
    }
    
    var description: String {
        return "Name: \(self.name), City: \(self.city)"
    }
}

// In a real project, you should use a mechanism like Grand Central Dispatch to implement concurrency protections in Repository.

protocol Repository {
    var People: [Person] { get }
    
    func addPerson(person: Person)
    func removePerson(name: String)
    func updatePerson(name: String, newCity: String)
}

class MemoryRepository: Repository {
    private var peopleArray: [Person]
    
    init() {
        peopleArray = [
            Person("Bob", "New York"),
            Person("Alice", "London"),
            Person("Joe", "Paris")
        ]
    }
    
    var People: [Person] {
        return self.peopleArray
    }
    
    func addPerson(person: Person) {
        self.peopleArray.append(person)
    }
    
    func removePerson(name: String) {
        let nameLower = name.lowercaseString
        self.peopleArray = peopleArray.filter { $0.name.lowercaseString != nameLower }
    }
    
    func updatePerson(name: String, newCity: String) {
        let nameLower = name.lowercaseString
        let test: Person -> Bool = { p in p.name.lowercaseString == nameLower }
        if let person = peopleArray.first(test) {
            person.city = newCity
        }
    }
}