//
//  Extensions.swift
//  MVC
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

extension String {
    func split() -> [String] {
        return self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter { $0 != "" }
    }
}

extension Array {
    func unique<T: Equatable>() -> [T] {
        var uniqueValues = [T]()
        for value in self {
            if let value = value as? T {
                if !uniqueValues.contains(value) {
                    uniqueValues.append(value)
                }
            }
        }
        return uniqueValues
    }
    
    func first<T>(test: T -> Bool) -> T? {
        for value in self {
            if let value  = value as? T where test(value) {
                return value
            }
        }
        return nil
    }
}