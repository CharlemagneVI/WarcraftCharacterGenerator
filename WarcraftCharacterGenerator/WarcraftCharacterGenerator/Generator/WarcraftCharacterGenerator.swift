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
        var newestSchemaVersion: UInt64 = 29
        do
        {
            newestSchemaVersion = try schemaVersionAtURL(URL(string: Bundle.main.path(forResource: "wcg", ofType: "realm")!)!)
        }
        catch
        {
            print(error.localizedDescription)
        }
       
        self.config = Realm.Configuration(
            fileURL: URL(string: Bundle.main.path(forResource: "wcg", ofType: "realm")!), readOnly: false, schemaVersion: newestSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if(oldSchemaVersion < newestSchemaVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            }
        )
    }
    
    public func generateNewCharacter() -> WarcraftCharacter
    {
        let realm = try! Realm(configuration: config)
        
        //Generate a number for faction
        var randomGen = Int.random(in: 1 ... 2)
        let faction = realm.object(ofType: WarcraftFaction.self, forPrimaryKey: randomGen)
        
        //Generate a number for race
        randomGen = Int.random(in: 0 ... (faction?.faction_races.count)! - 1)
        let race = faction?.faction_races[randomGen]
        
        //Generate a random number for class
        randomGen = Int.random(in: 0 ... (race?.race_classes.count)! - 1)
        let warcraft_class = race?.race_classes[randomGen]
        
        //Generate a random number for spec
        randomGen = Int.random(in: 0 ... (warcraft_class?.class_specs.count)! - 1)
        let class_spec = warcraft_class?.class_specs[randomGen]
        
        //Store everything in character object
        let character = WarcraftCharacter(faction: (faction)!, race: (race)!, warcraft_class: (warcraft_class)!, spec: (class_spec)!)
        
        saveCharacterHistory(warcraftCharacter: character)
        return character
    }
    
    public func saveCharacterHistory(warcraftCharacter: WarcraftCharacter)
    {
        let realm = try! Realm(configuration: config)
        
        let history: GenerationHistory = GenerationHistory()
        
        if let retNext = realm.objects(GenerationHistory.self).sorted(byKeyPath: "id_history", ascending: false).first?.id_history
        {
            history.id_history = retNext + 1
        }
        else
        {
            history.id_history = 1
        }
        
        history.faction = warcraftCharacter.faction
        history.race = warcraftCharacter.race
        history.warcraft_class = warcraftCharacter.warcraft_class
        history.spec = warcraftCharacter.spec
        history.history_datetime = Date()
        
        try! realm.write
        {
             realm.add(history)
        }
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
