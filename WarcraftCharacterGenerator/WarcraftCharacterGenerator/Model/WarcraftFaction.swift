//
//  WarcraftFaction.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/17/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import RealmSwift

class WarcraftFaction: Object
{
    @objc dynamic var id_faction: Int = 0
    @objc dynamic var faction_name: String = ""
    let faction_races = List<WarcraftRace>()
    @objc dynamic var faction_img: String = ""
    @objc dynamic var chart_color: String = ""
    
    override static func primaryKey() -> String? {
        return "id_faction"
    }
}
