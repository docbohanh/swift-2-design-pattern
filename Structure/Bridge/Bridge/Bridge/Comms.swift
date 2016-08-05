//
//  Comms.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol ClearMessageChannel {
    func send(message: String)
}

protocol SecureMessageChannel {
    func sendEncryptedMessage(encryptedText: String)
}

protocol PriorityMessageChannel {
    func sendPriority(message: String)
}

class Communicator {
    private let clearChannel: ClearMessageChannel
    private let secureChannel: SecureMessageChannel
    private let priorityChannel: PriorityMessageChannel
    
    init(clearChannel: ClearMessageChannel, secureChannel: SecureMessageChannel, priorityChannel: PriorityMessageChannel) {
        self.clearChannel = clearChannel
        self.secureChannel = secureChannel
        self.priorityChannel = priorityChannel
    }
    
    func sendCleartextMessage(message: String) {
        self.clearChannel.send(message)
    }
    
    func sendSecureMessage(message: String) {
        self.secureChannel.sendEncryptedMessage(message)
    }
    
    func sendPriorityMessasge(message: String) {
        self.priorityChannel.sendPriority(message)
    }
}