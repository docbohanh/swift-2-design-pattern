//
//  PoolItem.swift
//  ObjectPool
//
//  Created by HungDo on 7/30/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

protocol PoolItem: class {
    var canReuse: Bool { get }
}