//
//  WarcraftClass.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/16/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import RealmSwift

class WarcraftClass: Object
{
    @objc dynamic var id_class: Int = 0
    @objc dynamic var class_name: String = ""
    
    override static func primaryKey() -> String? {
        return "id_class"
    }
}
