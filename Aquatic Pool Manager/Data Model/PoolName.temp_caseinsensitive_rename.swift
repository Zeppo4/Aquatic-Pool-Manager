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
    @objc dynamic var name: String = ""
    let poolData = List<Data>()
}
