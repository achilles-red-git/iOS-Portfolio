//
//  XylophoneViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 10/29/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import UIKit
import AVFoundation

class XylophoneViewController: UIViewController, AVAudioPlayerDelegate {
    
    //MARK: - Variable Declaration
    var audioPlayer : AVAudioPlayer!
    let soundArray = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]
    var selectedSoundFileName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Note pressed, all noets are connected here through outlets and tags , hence the single block of code
    @IBAction func notePressed(_ sender: UIButton) {
        //identify which note was pressed
        
        selectedSoundFileName = soundArray[sender.tag - 1]
        print(selectedSoundFileName)
        
        //play note
        
        playSound()
        
    }
    
    func playSound() {
        //AV audioplayer functions to play sounds
        let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            
            audioPlayer.play()
        }
        catch {
            
        }
    }
    
    
    
}


