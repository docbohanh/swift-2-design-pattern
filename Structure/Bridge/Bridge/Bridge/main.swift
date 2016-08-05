//
//  main.swift
//  Bridge
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

var bridge = CommunicatorBridge(channel: SatelliteChannel())
var comms = Communicator(clearChannel: bridge, secureChannel: bridge, priorityChannel: bridge)

comms.sendCleartextMessage("Hello!")
comms.sendSecureMessage("This is a secret")
comms.sendPriorityMessasge("This is important")