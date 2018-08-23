//
//  WarcraftCharacter.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/20/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import Foundation

class WarcraftCharacter
{
    var faction: WarcraftFaction
    
    var race: WarcraftRace
    
    var warcraft_class: WarcraftClass
    
    var spec: WarcraftClassSpecialization
    
    init(faction: WarcraftFaction, race: WarcraftRace, warcraft_class: WarcraftClass, spec: WarcraftClassSpecialization)
    {
        self.faction = faction
        self.race = race
        self.warcraft_class = warcraft_class
        self.spec = spec
    }
}
