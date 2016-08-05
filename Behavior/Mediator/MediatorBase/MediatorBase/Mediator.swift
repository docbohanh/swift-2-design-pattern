//
//  Mediator.swift
//  MediatorBase
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol Peer {
    var name: String { get }
    func otherPlaneDidChangePosition(position: Position) -> Bool
}

protocol Mediator {
    func registerPeer(peer: Peer)
    func unregisterPeer(peer: Peer)
    func changePosition(peer: Peer, pos: Position) -> Bool
}

class AirplaneMediator: Mediator {
    private var peers: [String:Peer]
    private let queue = dispatch_queue_create("dictQ", DISPATCH_QUEUE_CONCURRENT)
    
    init() {
        peers = [String:Peer]()
    }
    
    func registerPeer(peer: Peer) {
        dispatch_barrier_sync(self.queue) {
            self.peers[peer.name] = peer
        }
    }
    
    func unregisterPeer(peer: Peer) {
        dispatch_barrier_sync(self.queue) {
            let _ = self.peers.removeValueForKey(peer.name)
        }
    }
    
    func changePosition(peer: Peer, pos: Position) -> Bool {
        var result = false
        dispatch_sync(self.queue) {
            for storedPeer in self.peers.values {
                if peer.name != storedPeer.name && storedPeer.otherPlaneDidChangePosition(pos) {
                    result = true
                }
            }
        }
        return result
    }
}