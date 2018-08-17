//
//  WarcraftClassSpecialization.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/17/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import RealmSwift

class WarcraftClassSpecialization: Object
{
    @objc dynamic var id_spec: Int = 0
    @objc dynamic var spec_name: String = ""
    
    override static func primaryKey() -> String? {
        return "id_spec"
    }
}
