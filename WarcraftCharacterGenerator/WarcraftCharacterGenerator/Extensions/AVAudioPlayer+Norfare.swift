//
//  AVAudioPlayer.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/14/18.
//  Copyright © 2018 Norfare. All rights reserved.
//
import AVFoundation

class NorfareAudioPlayer
{
    var player: AVAudioPlayer?

    func playSound(soundName: String, soundExtension: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundExtension) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
