//
//  WarcraftCharacterGenerator.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/16/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import RealmSwift

class WarcraftCharacterGenerator
{
    var config: Realm.Configuration
    
    init()
    {
        self.config = Realm.Configuration(
            fileURL: Bundle.main.url(forResource: "wcg", withExtension: "realm"),
            readOnly: true)
        
        do
        {
            self.config.schemaVersion = try schemaVersionAtURL(Bundle.main.url(forResource: "wcg", withExtension: "realm")!)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    public func generateNewCharacter() -> WarcraftCharacter
    {
        let realm = try! Realm(configuration: config)
        
        //Generate a number for faction
        var randomGen = Int.random(in: 1 ... 2)
        let faction = realm.object(ofType: WarcraftFaction.self, forPrimaryKey: randomGen)
        
        //Generate a number for race
        randomGen = Int.random(in: 0 ... (faction?.faction_race.count)! - 1)
        let race = faction?.faction_race[randomGen]
        
        //Generate a random number for class
        randomGen = Int.random(in: 0 ... (race?.race_classes.count)! - 1)
        let warcraft_class = race?.race_classes[randomGen]
        
        //Generate a random number for spec
        randomGen = Int.random(in: 0 ... (warcraft_class?.class_specs.count)! - 1)
        let class_spec = warcraft_class?.class_specs[randomGen]
        
        //Store everything in character object
        let character = WarcraftCharacter(faction: (faction)!, race: (race)!, warcraft_class: (warcraft_class)!, spec: (class_spec)!)
        
        return character
    }
    
    public func saveCharacterHistory()
    {
        let realm = try! Realm(configuration: config)
        
    }
    
    public func getRealmInfo()
    {
        let realm = try! Realm(configuration: config)
        
        let results = realm.objects(WarcraftFaction.self)
        
        print(results)
    }
    
    public func renameField()
    {
        let realm = try! Realm(configuration: config)
        
        print(realm.schema.description)
        
        print(realm.schema.objectSchema.count)
    }
}
