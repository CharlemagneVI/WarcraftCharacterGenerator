//
//  CharacterCard.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/23/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit
import Spring

class CharacterCard: UIView
{
    let nibName: String = "CharacterCard"
    var contentView: UIView?
    
    @IBOutlet weak var characterPortrait: UIImageView!
    @IBOutlet weak var classPortrait: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var raceLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = self.loadViewFromNib() else { return }
        view.frame = self.bounds
        view.clipsToBounds = true
        view.layer.cornerRadius = 23.0
        self.addSubview(view)
        contentView = view
        contentView?.isUserInteractionEnabled = true
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.isUserInteractionEnabled = true
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    public func populateCharacterCard(character: WarcraftCharacter)
    {
        characterPortrait.image = UIImage(named: character.race.race_img)
        classPortrait.image = UIImage(named: character.warcraft_class.class_img)
        raceLabel.text = character.race.race_name
        classLabel.text = character.spec.spec_name + " " + character.warcraft_class.class_name
    }
}
