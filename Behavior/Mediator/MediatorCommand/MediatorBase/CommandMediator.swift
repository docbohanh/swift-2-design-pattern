//
//  CommandMediator.swift
//  MediatorBase
//
//  Created by HungDo on 8/3/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

// Make assumption about the type of the peers which the command will be executed.
// Since any peer can send a command, this means that all peers have to be derived from the same base class
// and you cannot use the CommandMediator class to mediate between objects of differing types.

protocol CommandPeer {
    var name: String { get }
}

class Command {
    let function: CommandPeer -> Any
    
    init(function: CommandPeer -> Any) {
        self.function = function
    }
    
    func execute(peer: CommandPeer) -> Any {
        return function(peer)
    }
}

class CommandMediator {
    private var peers = [String:CommandPeer]()
    
    func registerPeer(peer: CommandPeer) {
        peers[peer.name] = peer
    }
    
    func unregisterPeer(peer: CommandPeer) {
        peers.removeValueForKey(peer.name)
    }
    
    func dispatchCommand(caller: CommandPeer, command: Command) -> [Any] {
        var results = [Any]()
        for peer in peers.values where peer.name != caller.name {
            results.append(command.execute(peer))
        }
        return results
    }
}