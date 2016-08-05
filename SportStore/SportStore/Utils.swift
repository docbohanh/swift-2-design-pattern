//
//  Utils.swift
//  SportStore
//
//  Created by HungDo on 7/28/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Utils {
    
    class func currencyStringFromNumber(number: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(number) ?? ""
    }
    
}

func dropFirst(text: String) -> String {
    return text.substringFromIndex(text.startIndex.successor())
}