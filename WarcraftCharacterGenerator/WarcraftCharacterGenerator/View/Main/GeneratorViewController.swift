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
    @IBOutlet weak var imgWcgLogo: SpringImageView!
    @IBOutlet weak var imgWcgLogoText: SpringImageView!
    @IBOutlet weak var btnGenerateSmall: SpringButton!
    
    let audioPlayer: NorfareAudioPlayer = NorfareAudioPlayer()
    let generator: WarcraftCharacterGenerator = WarcraftCharacterGenerator()
    
    var firstOpen: Bool = false
    
    var currentCharacterCard: CharacterCard?
    
    //Define the scroll directions for the background image.
    enum BackgroundScrollDirection
    {
        case left
        case right
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //generator.getRealmInfo()
        //generator.renameField()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if(!firstOpen)
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
            firstOpen = true
        }
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
    
    private func pauseBackground(layer: CALayer)
    {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    private func resumeBackground(layer: CALayer)
    {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    @IBAction func btnGenerateTouch(_ sender: SpringButton)
    {
        btnGenerate.animation = "fadeOut"
        btnGenerate.curve = "easeIn"
        btnGenerate.duration = 1.0
        btnGenerate.autohide = true
        
        imgWcgLogo.animation = "fadeOut"
        imgWcgLogo.curve = "easeIn"
        imgWcgLogo.duration = 1.0
        imgWcgLogo.autohide = true
        
        imgWcgLogoText.animation = "fadeOut"
        imgWcgLogoText.curve = "easeIn"
        imgWcgLogoText.duration = 1.0
        imgWcgLogoText.autohide = true
        
        btnGenerate.animate()
        imgWcgLogo.animate()
        imgWcgLogoText.animate()
        
        let warcraftCharacter = generator.generateNewCharacter()
        
        let characterCardView = UIView.fromNib(name: "CharacterCard") as! CharacterCard
        characterCardView.populateCharacterCard(warcraftCharacter: warcraftCharacter)
        characterCardView.center = view.convert(view.center, from: view.superview)
        
        //characterCardView.populateCharacterCard(warcraftCharacter: warcraftCharacter)
        view.addSubview(characterCardView)
        currentCharacterCard = characterCardView
        characterCardView.animation = "slideLeft"
        characterCardView.curve = "easeIn"
        characterCardView.duration = 1.0
        characterCardView.animate()
        
        btnGenerateSmall.isHidden = false
        btnGenerateSmall.animation = "fadeIn"
        btnGenerateSmall.curve = "easeIn"
        btnGenerateSmall.duration = 2.5
        btnGenerateSmall.animate()
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
        
        btnGenerate.animation = "fadeIn"
        btnGenerate.duration = 0.6
        
        imgWcgLogo.animation = "fadeIn"
        imgWcgLogo.duration = 0.6
        
        imgWcgLogoText.animation = "fadeIn"
        imgWcgLogoText.duration = 0.6
        
        btnGenerate.isHidden = false
        btnGenerate.animate()
        
        imgWcgLogo.isHidden = false
        imgWcgLogo.animate()
        
        imgWcgLogoText.isHidden = false
        imgWcgLogoText.animate()
    }
    
    @IBAction func btnGenerateSmallTouch(_ sender: Any)
    {
        let warcraftCharacter = generator.generateNewCharacter()
        
        currentCharacterCard?.animation = "slideLeft"
        currentCharacterCard?.curve = "easeIn"
        currentCharacterCard?.duration = 1.0
        currentCharacterCard?.autohide = true
        currentCharacterCard?.center.x = view.superview!.frame.width - ((currentCharacterCard?.frame.width)! * 2)
        currentCharacterCard?.animate()
        
        let characterCardView = UIView.fromNib(name: "CharacterCard") as! CharacterCard
        characterCardView.populateCharacterCard(warcraftCharacter: warcraftCharacter)
        characterCardView.center = view.convert(view.center, from: view.superview)
        
        //characterCardView.populateCharacterCard(warcraftCharacter: warcraftCharacter)
        view.addSubview(characterCardView)
        characterCardView.animation = "slideLeft"
        characterCardView.curve = "easeIn"
        characterCardView.duration = 1.0
        characterCardView.animate()
        currentCharacterCard = characterCardView
    }
    
    @IBAction func infoTouchOpen(_ sender: Any)
    {
        pauseBackground(layer: imgBackground.layer)
    }
}
