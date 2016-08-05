//
//  Bridge.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class CommunicatorBridge: ClearMessageChannel, SecureMessageChannel, PriorityMessageChannel {
    private var channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
    
    func send(message: String) {
        let msg = ClearMessage(message: message)
        sendMessage(msg)
    }
    
    func sendEncryptedMessage(encryptedText: String) {
        let msg = EncryptedMessage(message: encryptedText)
        sendMessage(msg)
    }
    
    func sendPriority(message: String) {
        sendMessage(PriorityMessage(message: message))
    }
    
    private func sendMessage(msg: Message) {
        msg.prepareMessage()
        channel.sendMessage(msg)
    }
}