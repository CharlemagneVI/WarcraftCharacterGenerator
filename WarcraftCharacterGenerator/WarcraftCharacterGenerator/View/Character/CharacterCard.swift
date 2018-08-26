//
//  CharacterCard.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/24/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit
import Spring

class CharacterCard: SpringView
{
    
    @IBOutlet var warcraftClassPortrait: UIImageView!
    @IBOutlet var warcraftCharacterPortrait: UIImageView!
    @IBOutlet var warcraftRaceLabel: UILabel!
    @IBOutlet var warcraftClassLabel: UILabel!
    
    
    public func populateCharacterCard(warcraftCharacter: WarcraftCharacter)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = 23.0
        
        if(warcraftCharacter.race.alt_race_img != nil)
        {
            let randomGen = Int.random(in: 1 ... 2)
            if(randomGen == 1)
            {
                warcraftCharacterPortrait.image = UIImage(named: warcraftCharacter.race.race_img)
            }
            else
            {
                warcraftCharacterPortrait.image = UIImage(named: warcraftCharacter.race.alt_race_img!)
            }
        }
        else
        {
            warcraftCharacterPortrait.image = UIImage(named: warcraftCharacter.race.race_img)
        }
        
        warcraftClassPortrait.image = UIImage(named: warcraftCharacter.warcraft_class.class_img)
        warcraftRaceLabel.text = warcraftCharacter.race.race_name
        warcraftClassLabel.text = warcraftCharacter.spec.spec_name + " " + warcraftCharacter.warcraft_class.class_name
    }
}
