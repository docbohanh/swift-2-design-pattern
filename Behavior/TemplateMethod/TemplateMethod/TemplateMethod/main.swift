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

donorDb.filter = { $0.filter { $0.lastDonation == 0 } }
donorDb.generate = { $0.map { "Hi \($0.firstName)" } }

let newDonors = donorDb.generate(Int.max)
for invite in newDonors {
    print(invite)
}