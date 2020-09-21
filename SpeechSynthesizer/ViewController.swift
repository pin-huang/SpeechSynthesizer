//  ViewController.swift
//  SpeechSynthesizer
//  Created by Pincheng Huang on 2020/9/18.

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var content = ["曾經有一段真摯的愛情擺在我的面前，我卻沒有珍惜，直到失去才後悔莫及，人世間最大的痛苦莫過於此。如果上天再給我一次機會的話，我一定會對那女孩說三個字：我愛你。如果非要在這段愛情前加個期限的話，我希望是一萬年。", "I have had my best love before, but I didn』t treasure her. When I lost her, I fell regretful. It is the most painful matter in this world. If God can give me another chance, I will say 3 words to her --- I love you. If you have to give a time limit to this love, I hope it is 10 thousand years."]
    
    var rate = Float()
    var volume = Float()
    var pitch = Float()
    var arrayNumber = Int(0)
    
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var rateLabel: UILabel!
        
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var volumeLabel: UILabel!
        
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var pitchLabel: UILabel!
    
    @IBOutlet weak var languageSelection: UISegmentedControl!
    
    @IBOutlet weak var speakButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    // 點空白處收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }
    
    // 輸入完return收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true
    }
    
    @IBAction func rateControl(_ sender: UISlider) {
        rate = sender.value
        rateLabel.text = String(format: "%.2f", rate)
        
    }
    
    
    
    @IBAction func volumeControl(_ sender: UISlider) {
        volume = sender.value
        volumeLabel.text = String(format: "%.2f", volume)
    }
    
    @IBAction func pitchControl(_ sender: UISlider) {
        pitch = sender.value
        pitchLabel.text = String(format: "%.2f", pitch)
    }
    
    
    @IBAction func speak(_ sender: UIButton) {
        
        var speechUtterance = AVSpeechUtterance(string: content[0])

        // 選擇語系 SegmentedControl
        if languageSelection.selectedSegmentIndex == 0 {
            speechUtterance = AVSpeechUtterance(string: content[0])
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            
        } else if languageSelection.selectedSegmentIndex == 1 {
            speechUtterance = AVSpeechUtterance(string: content[0])
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-HK")
            
        } else if languageSelection.selectedSegmentIndex == 2 {
            speechUtterance = AVSpeechUtterance(string: content[1])
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            
        }
        
        
        speechUtterance.pitchMultiplier = pitchSlider.value // 以 pitch slider 控制
        speechUtterance.rate = rateSlider.value
        speechUtterance.volume = volumeSlider.value // 以 volume slider 控制音量大小
        
        let synthesizer = AVSpeechSynthesizer()
                
        
        if synthesizer.isSpeaking == false, speakButton.titleLabel!.text == "Speak" {
            synthesizer.speak(speechUtterance)
            speakButton.setTitle("Pause", for: UIControl.State.normal)
            
        } else if synthesizer.isSpeaking == true, speakButton.titleLabel!.text == "Pause" {
                synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
                speakButton.setTitle("Speak again", for: UIControl.State.normal)
            
        } else if synthesizer.isPaused == true, speakButton.titleLabel!.text == "Speak again" {
            synthesizer.continueSpeaking()
            speakButton.setTitle("Pause", for: UIControl.State.normal)
        } else {
            
            speakButton.setTitle("Pause", for: UIControl.State.normal)
        }
        
        

    }
    
    
    @IBAction func randomSpeech(_ sender: UIButton) {
        
        pitchSlider.value = Float.random(in: 0.1...1.0)
        pitchLabel.text = String(format: "%.2f", pitchSlider.value)
        rateSlider.value = Float.random(in: 0.1...1.0)
        rateLabel.text = String(format: "%.2f", rateSlider.value)
        volumeSlider.value = Float.random(in: 0.5...1.0)
        volumeLabel.text = String(format: "%.2f", volumeSlider.value)
        
        
        let speechUtterance = AVSpeechUtterance(string: content[content.count - 2])
        
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        speechUtterance.pitchMultiplier = pitchSlider.value // 以 pitch slider 控制
        speechUtterance.rate = rateSlider.value
        speechUtterance.volume = volumeSlider.value // 以 volume slider 控制音量大小
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
        
    }
    

    
    

}

