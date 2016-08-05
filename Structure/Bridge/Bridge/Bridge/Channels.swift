//
//  Channels.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

//class SecureLandline: SecureMessageChannel {
//    func sendEncryptedMessage(message: String) {
//        print("Secure Landline: \(message)")
//    }
//}
//
//class SecureWireless: SecureMessageChannel {
//    func sendEncryptedMessage(message: String) {
//        print("Secure Wireless: \(message)")
//    }
//}

protocol Channel {
    func sendMessage(msg: Message)
}

class LandlineChannel: Channel {
    func sendMessage(msg: Message) {
        print("Landline: \(msg.contentToSend)")
    }
}

class WireLessChannel: Channel {
    func sendMessage(msg: Message) {
        print("Wireless: \(msg.contentToSend)")
    }
}