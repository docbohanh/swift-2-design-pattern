//
//  main.swift
//  TemplateMethod
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let donorDb = DonorDatabase()

let galaInvitations = donorDb.generate(2)
for invite in galaInvitations {
    print(invite)
}

class NewDonors: DonorDatabase {
    override func filter(donors: [Donor]) -> [Donor] {
        return donors.filter { $0.lastDonation == 0 }
    }
    
    override func generate(donors: [Donor]) -> [String] {
        return donors.map { "Hi \($0.firstName)" }
    }
}

let newDonor = NewDonors()
for invite in newDonor.generate(Int.max) {
    print(invite)
}