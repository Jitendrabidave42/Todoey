//
//  Category.swift
//  Todoey
//
//  Created by Mac on 16/08/18.
//  Copyright © 2018 ArnAmy. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
