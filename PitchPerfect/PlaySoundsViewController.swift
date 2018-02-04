//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Dhairya Nishar on 11/8/17.
//  Copyright © 2017 Dhairya Nishar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton! 
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
            switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5) // Rates can be changed based on the preference
            case .fast:
                playSound(rate: 1.5) // Rates can be changed based on the preference
            case .chipmunk:
                playSound(pitch: 1000) // Rates can be changed based on the preference
            case .vader:
                playSound(pitch: -1000) // Rates can be changed based on the preference
            case .echo:
                playSound(echo: true) // Rates can be changed based on the preference
            case .reverb:
                playSound(reverb: true) // Rates can be changed based on the preference
            }
            
            configureUI(.playing)
    }
    // Stopping the pressed button
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Added the image view for all buttons 
        setupAudio()
        
        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    

}
