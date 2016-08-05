//
//  Transmitters.swift
//  ChainOfResp
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Transmitter {
    var nextLink: Transmitter?
    
    required init() {}
    
    func sendMessage(message: Message, handled: Bool = false) -> Bool {
        if nextLink != nil {
            return nextLink!.sendMessage(message, handled: handled)
        } else if !handled {
            print("End of chain reached. Message not send")
        }
        return handled
    }
    
    class func createChain(localOnly: Bool) -> Transmitter? {
//        let transmitterClasses: [Transmitter.Type] = [
//            PriorityTransmitter.self,
//            LocalTransmitter.self,
//            RemoteTransmitter.self
//        ]

        let transmitterClasses: [Transmitter.Type] = localOnly ? [PriorityTransmitter.self, LocalTransmitter.self] :
                                    [PriorityTransmitter.self, LocalTransmitter.self, RemoteTransmitter.self]
        
        var link: Transmitter?
        
        for tClass in transmitterClasses.reverse() {
            let existingLink = link
            link = tClass.init()
            link?.nextLink = existingLink
        }
        
        return link
    }
    
    private class func matchEmailSuffix(message: Message) -> Bool {
        if let index = message.from.characters.indexOf("@") {
            return message.to.hasSuffix(message.from[index ..< message.from.endIndex])
        }
        return false
    }
}

class LocalTransmitter: Transmitter {
    override func sendMessage(message: Message, handled: Bool) -> Bool {
        var handled = handled
        if !handled && Transmitter.matchEmailSuffix(message) {
            print("Message to \(message.to) sent locally")
            handled = true
        }
        return super.sendMessage(message, handled: handled)
    }
}

class RemoteTransmitter: Transmitter {
    override func sendMessage(message: Message, handled: Bool) -> Bool {
        var handled = handled
        if !handled && !Transmitter.matchEmailSuffix(message) {
            print("Message to \(message.to) sent remotely")
            handled = true
        }
        return super.sendMessage(message, handled: handled)
    }
}

class PriorityTransmitter: Transmitter {
    var totalMessages = 0
    var handledMessages = 0
    
    override func sendMessage(message: Message, handled: Bool) -> Bool {
        var handled = handled
        totalMessages += 1
        if !handled && message.subject.hasPrefix("Priority") {
            handledMessages += 1
            print("Message to \(message.to) send as priority")
            print("Stats: Handled \(handledMessages) of \(totalMessages)")
            handled = true
        }
        return super.sendMessage(message, handled: handled)
    }
}