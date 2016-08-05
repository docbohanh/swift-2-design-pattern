//
//  main.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

var comms = Communicator(channel: Channel.Channels.Satellite)

comms.sendCleartextMessage("Hello!")
comms.sendSecureMessage("This is a secret")
comms.sendPriorityMessasge("This is important")