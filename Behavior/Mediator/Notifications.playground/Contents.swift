//: Playground - noun: a place where people can play

import UIKit

let notifier = NSNotificationCenter.defaultCenter()

class NotificationPeer {
    let name: String
    
    init(name: String) {
        self.name = name
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receiveMessage(_:)), name: "message", object: nil)
    }
    
    func sendMessage(message: String) {
        NSNotificationCenter.defaultCenter().postNotificationName("message", object: message)
    }
    
    @objc func receiveMessage(notification: NSNotification) {
        print("Peer \(name) received message: \(notification.object)")
    }
}

arc4random_uniform(123)

let p1 = NotificationPeer(name: "peer1")
let p2 = NotificationPeer(name: "peer2")
let p3 = NotificationPeer(name: "peer3")
let p4 = NotificationPeer(name: "peer4")

p3.sendMessage("Hello!")