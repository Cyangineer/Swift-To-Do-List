//
//  Item.swift
//  To-Do List
//
//  Created by Nigell Dennis on 3/16/20.
//  Copyright © 2020 Nigell Dennis. All rights reserved.
//

import RealmSwift

class Item: Object {
    @objc dynamic var note = ""
    @objc dynamic var checked = false
    @objc dynamic var createdAt = Date()
}
