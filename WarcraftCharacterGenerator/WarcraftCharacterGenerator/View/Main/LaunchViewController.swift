//
//  ViewController.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/13/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit
import Spring

class LaunchViewController: UIViewController
{
    @IBOutlet weak var wcgLogo: SpringImageView!
    @IBOutlet weak var wcgLogoText: SpringImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        wcgLogo.animation = "zoomOut"
        wcgLogoText.animation = "fadeOut"
        
        wcgLogo.scaleX = 3.6
        wcgLogo.scaleY = 3.6
        wcgLogo.duration = 1.0
        wcgLogo.repeatCount = 0
        
        wcgLogoText.duration = 1.0
        wcgLogoText.repeatCount = 0
        
        wcgLogo.animate()
        wcgLogoText.animate()
        
        let generatorViewController = self.storyboard?.instantiateViewController(withIdentifier: "GeneratorViewController")
        self.present(generatorViewController!, animated: false, completion: nil)
    }
    
    //Override the status bar to white.
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
}

