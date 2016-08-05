//
//  EventBridge.swift
//  SportStore
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class EventBridge {
    private let outputCallback: (String, Int) -> Void
    
    init(callback: (String, Int) -> Void) {
        self.outputCallback = callback
    }
    
    var inputCallback: Product -> Void {
        return { p in self.outputCallback(p.name, p.stockLevel) }
    }
}