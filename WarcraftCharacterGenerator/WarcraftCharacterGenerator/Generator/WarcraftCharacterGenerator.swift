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
    
    public func generateNewCharacter()
    {
        let realm = try! Realm(configuration: config)
        
        let factionInt = Int.random(in: 1 ... 2)
        
        let faction = realm.object(ofType: WarcraftRace.self, forPrimaryKey: factionInt)
        
        print(faction)
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
