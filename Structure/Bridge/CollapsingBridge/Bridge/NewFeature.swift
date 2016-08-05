//
//  NewFeature.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class SatelliteChannel: Channel {
    override func sendMessage(msg: Message) {
        print("Satellite: \(msg.contentToSend)")
    }
}

class PriorityMessage: ClearMessage {
    override var contentToSend: String {
        return "Important: \(super.contentToSend)"
    }
}