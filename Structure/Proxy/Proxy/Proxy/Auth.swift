//
//  Auth.swift
//  Proxy
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class UserAuthentication {
    var user: String?
    var authenticated: Bool = false
    
    private init() {}
    
    func authenticate(user: String, pass: String) {
        if pass == "secret" {
            self.user = user
            self.authenticated = true
        } else {
            self.user = nil
            self.authenticated = false
        }
    }
    
    class var sharedInstance: UserAuthentication {
        struct SingletonWrapper {
            static let singleton = UserAuthentication()
        }
        return SingletonWrapper.singleton
    }
}