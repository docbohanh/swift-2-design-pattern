//
//  Donors.swift
//  TemplateMethod
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// In other languages, the template pattern is implemented by defining a class that requires subclasses
// to complete the algorithm and provide the missing steps. Swift doesn't support abstract classes,
// but it does allow functions to be treated as objects, which allows an implementation of the pattern
// to be created anyway.

struct Donor {
    let title: String
    let firstName: String
    let familyName: String
    let lastDonation: Float
    
    init(_ title: String, _ first: String, _ family: String, _ last: Float) {
        self.title = title
        self.firstName = first
        self.familyName = family
        self.lastDonation = last
    }
}

class DonorDatabase {
    private var donors: [Donor]
    var filter: ([Donor] -> [Donor])?
    var generate: ([Donor] -> [String])?
    
    init() {
        donors = [
            Donor("Ms", "Anne", "Jones", 0),
            Donor("Mr", "Bob", "Smith", 100),
            Donor("Dr", "Alice", "Doe", 200),
            Donor("Prof", "Joe", "Davis", 320)
        ]
    }
    
    func generate(maxNumber: Int) -> [String] {
        // step 1 - filter out non-donors
        var targetDonors: [Donor] = filter?(donors) ?? donors.filter { $0.lastDonation > 0 }
        
        // step 2 - order donors by last dontation
        targetDonors.sortInPlace { $0.lastDonation > $1.lastDonation }
        
        // step 3 - limit the number of invitees
        if targetDonors.count > maxNumber {
            targetDonors = [Donor](targetDonors[0 ..< maxNumber])
        }
        
        // step 4 - generate the invitations
        return generate?(targetDonors) ?? targetDonors.map { donor in
            return "Dear \(donor.title). \(donor.familyName)"
        }
    }
}