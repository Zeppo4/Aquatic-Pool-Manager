//
//  poolName.swift
//  Aquatic Pool Manager
//
//  Created by Mac User on 3/1/18.
//  Copyright © 2018 Zeppo. All rights reserved.
//

import Foundation
import RealmSwift

class PoolName: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var width: Double = 0.0
    @objc dynamic var length: Double = 0.0
    @objc dynamic var depth1: Double = 0.0
    @objc dynamic var depth2: Double = 0.0
    @objc dynamic var volume: Double = 0.0
    
}
