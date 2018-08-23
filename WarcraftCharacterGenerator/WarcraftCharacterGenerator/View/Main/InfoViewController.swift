//
//  InfoViewController.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/22/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController
{
    @IBOutlet weak var btnCloseInfo: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //Override the status bar to white.
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func CloseInfo(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
}
