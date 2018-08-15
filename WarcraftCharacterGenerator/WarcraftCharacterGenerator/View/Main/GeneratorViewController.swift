//
//  GeneratorViewController.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/13/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit
import Spring

class GeneratorViewController: UIViewController
{
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgIntro: SpringImageView!
    @IBOutlet weak var btnGenerate: SpringButton!
    @IBOutlet weak var btnIntro: SpringButton!
    
    let audioPlayer: NorfareAudioPlayer = NorfareAudioPlayer()
    
    //Define the scroll directions for the background image.
    enum BackgroundScrollDirection
    {
        case left
        case right
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        btnGenerate.isHidden = true
        

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //Start the parallax scroll of our background image
        scrollBackground(direction: .right, image: imgBackground)
        
        imgIntro.animation = "slideDown"
        imgIntro.curve = "easeIn"
        imgIntro.duration = 1.0
        
        btnIntro.animation = "slideDown"
        btnIntro.curve = "easeIn"
        btnIntro.duration = 1.0
        
        imgIntro.animate()
        btnIntro.animate()
    }
    
    //Override the status bar to white.
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
 
    //Scroll the background asynchronously throughout the running of the app.
    private func scrollBackground(direction: BackgroundScrollDirection, image: UIImageView)
    {
        if(direction == .left)
        {
            UIImageView.animateKeyframes(withDuration: 80,
                                         delay: 0,
                                         options: [],
                                         animations: {
                                            UIImageView.addKeyframe(withRelativeStartTime: 0,       relativeDuration: 1,
                                                animations:{
                                                    image.center.x = 0
                                            })
            },
                                         completion: {finished in
                                            self.scrollBackground(direction: .right, image: image)
            })
        }
        else if(direction == .right)
        {
            UIImageView.animateKeyframes(withDuration: 80,
                                         delay: 0,
                                         options: [],
                                         animations: {
                                            UIImageView.addKeyframe(withRelativeStartTime: 0,       relativeDuration: 1,
                                                animations:{
                                                    image.center.x = -132
                                            })
            },
                                         completion: {finished in
                                            self.scrollBackground(direction: .left, image: image)
            })
        }
    }
    
    @IBAction func btnGenerateTouch(_ sender: SpringButton)
    {
        
        print("test")
    }
    
    @IBAction func btnIntroConfirmTouch(_ sender: Any)
    {
        imgIntro.animation = "zoomOut"
        imgIntro.curve = "easeIn"
        imgIntro.duration = 0.5
        imgIntro.autohide = true
        
        btnIntro.animation = "zoomOut"
        btnIntro.curve = "easeIn"
        btnIntro.duration = 0.5
        btnIntro.autohide = true
        
        imgIntro.animate()
        btnIntro.animate()
        
        btnGenerate.isHidden = false
    }
}
