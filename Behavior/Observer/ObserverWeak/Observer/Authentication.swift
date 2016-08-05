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
        var nType = NotificationTypes.AUTH_FAIL
        if user == "bob" && pass == "secret" {
            nType = .AUTH_SUCCESS
            print("User \(user) is authenticated")
        } else {
            print("Failed authentication attempt")
        }
        sendNotification(Notification(type: nType, data: user))
        return nType == .AUTH_SUCCESS
    }
}