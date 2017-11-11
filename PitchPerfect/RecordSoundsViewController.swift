//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Dhairya Nishar on 10/24/17.
//  Copyright © 2017 Dhairya Nishar. All rights reserved.
//

import UIKit
import AVFoundation
 
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    func configureUI(recording: Bool){
        // Set label
        recordingLabel.text = recording ? "Recording in progress" : "Tap to Record"
        
        // Set buttons
        recordButton.isEnabled = !recording
        stopRecordingButton.isEnabled = recording
    }
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet var recordingLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    // MARK: View Did Load function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    // MARK: View Will Apprear Function
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: Record Audio Function
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        
        configureUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    // MARK: Stop Recording Action
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(recording: true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    // MARK: Audio Finished Recording Function
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Recording was not successful")
        }
    }
    
    // MARK: Prepare Function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

