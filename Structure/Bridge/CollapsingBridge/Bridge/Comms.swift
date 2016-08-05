//
//  Comms.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Communicator {
    private let channel: Channel
    
    init(channel: Channel.Channels) {
        self.channel = Channel.getChannel(channel)
    }
    
    private func sendMessage(msg: Message) {
        msg.prepareMessage()
        channel.sendMessage(msg)
    }
    
    func sendCleartextMessage(message: String) {
        self.sendMessage(ClearMessage(message: message))
    }
    
    func sendSecureMessage(message: String) {
        self.sendMessage(EncryptedMessage(message: message))
    }
    
    func sendPriorityMessasge(message: String) {
        self.sendMessage(PriorityMessage(message: message))
    }
}