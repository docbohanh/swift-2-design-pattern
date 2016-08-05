//
//  Authentication.swift
//  Observer
//
//  Created by HungDo on 8/4/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class AuthenticationManager: SubjectBase {
    func authenticate(user: String, pass: String) -> Bool {
        var result = false
        if user == "bob" && pass == "secret" {
            result = true
            print("User \(user) is authenticated")
        } else {
            print("Failed authentication attempt")
        }
        sendNotification(user, success: result)
        return result
    }
}