//
//  Category.swift
//  Todoey
//
//  Created by Isabel Porcuna on 4/1/19.
//  Copyright © 2019 Isabel Porcuna. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
    
    
}
