//
//  main.swift
//  Proxy
//
//  Created by HungDo on 8/2/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// Problems:
// - Remote Object
// - Expensive Operation
//   Caching, lazy loading, flyweight pattern
// - Restricted Access

let url = "http://www.apress.com"
let headers = ["Content-Length", "Content-Encoding"]

//let proxy = HttpHeaderRequestProxy()
//
//for header in headers {
//    if let val = proxy.getHeader(url, header: header) {
//        print("\(header): \(val)")
//    }
//}

// In a real project, should provide a factory method to hide the details of the proxy class.

let proxy = AccessControlProxy(url: url)

for header in headers {
    proxy.getHeader(header) { (header, val) in
        if let val = val {
            print("\(header): \(val)")
        }
    }
}

UserAuthentication.sharedInstance.authenticate("bob", pass: "secret")
proxy.execute()

NSFileHandle.fileHandleWithStandardInput().availableData