//
//  WarcraftRace.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/16/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import RealmSwift

class WarcraftRace: Object
{
    @objc dynamic var id_race: Int = 0
    @objc dynamic var race_name: String = ""
    let race_classes = List<WarcraftClass>()
    
    override static func primaryKey() -> String? {
        return "id_race"
    }
}
