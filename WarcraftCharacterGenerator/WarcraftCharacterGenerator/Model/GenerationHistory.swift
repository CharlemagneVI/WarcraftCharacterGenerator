//
//  GenerationHistory.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/17/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import RealmSwift

class GenerationHistory: Object
{
    @objc dynamic var id_history: Int = 0
    @objc dynamic var faction: WarcraftFaction?
    @objc dynamic var race: WarcraftRace?
    @objc dynamic var spec: WarcraftClassSpecialization?
    @objc dynamic var warcraft_class: WarcraftClass?
    @objc dynamic var history_datetime: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id_history"
    }
}
