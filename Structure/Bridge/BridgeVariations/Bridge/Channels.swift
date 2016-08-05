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

class Channel {
    enum Channels {
        case Landline
        case Wireless
        case Satellite
    }
    
    class func getChannel(channelType: Channels) -> Channel {
        switch channelType {
        case .Landline:
            return LandlineChannel()
        case .Wireless:
            return WireLessChannel()
        case .Satellite:
            return SatelliteChannel()
        }
    }
    
    func sendMessage(msg: Message) {
        fatalError("Not implement")
    }
}

class LandlineChannel: Channel {
    override func sendMessage(msg: Message) {
        print("Landline: \(msg.contentToSend)")
    }
}

class WireLessChannel: Channel {
    override func sendMessage(msg: Message) {
        print("Wireless: \(msg.contentToSend)")
    }
}