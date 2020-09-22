//  ViewController.swift
//  SpeechSynthesizer
//  Created by Pincheng Huang on 2020/9/18.

import UIKit
import AVFoundation


class ViewController: UIViewController {

    let synthesizer = AVSpeechSynthesizer() // 寫在這裡，成為 controller 的 property ，後續才可以搭配 if... else... 判斷式做 播放 - 暫停 - 再播放
    
    var content = ["曾經有一段真摯的愛情擺在我的面前，我卻沒有珍惜，直到失去才後悔莫及，人世間最大的痛苦莫過於此。如果上天再給我一次機會的話，我一定會對那女孩說三個字：我愛你。如果非要在這段愛情前加個期限的話，我希望是一萬年。", "曾經有一段真摯的愛情擺在我的面前，我卻沒有珍惜，直到失去才後悔莫及，人世間最大的痛苦莫過於此。如果上天再給我一次機會的話，我一定會對那女孩說三個字：我愛你。如果非要在這段愛情前加個期限的話，我希望是一萬年。", "I have had my best love before, but I didn』t treasure her. When I lost her, I fell regretful. It is the most painful matter in this world. If God can give me another chance, I will say 3 words to her --- I love you. If you have to give a time limit to this love, I hope it is 10 thousand years."]
        
    var languageChoice = ["zh-TW", "zh-HK", "en-GB"]
    var number = Int()
    var rate = Float()
    var volume = Float()
    var pitch = Float()
    
    
    
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var rateLabel: UILabel!
        
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var volumeLabel: UILabel!
        
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var pitchLabel: UILabel!
    
    @IBOutlet weak var languageSelection: UISegmentedControl!
    
    @IBOutlet weak var speakButton: UIButton!
    
    @IBOutlet weak var loveMessage: UITextField! // 讓使用者自行輸入字串
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if languageSelection.selectedSegmentIndex == 0 {
            number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言 (國語)
            loveMessage.text = content[number] // 匯入 變數 content 的內容到 loveMessage.text (元件 UI Text Field)
            
            } else if languageSelection.selectedSegmentIndex == 1 {
                number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言 (粵語)
                loveMessage.text = content[number] // 匯入 變數 content 的內容到 loveMessage.text (元件 UI Text Field)
                                
            } else if languageSelection.selectedSegmentIndex == 2 {
                number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言 (英語)
                loveMessage.text = content[number] // 匯入 變數 content 的內容到 loveMessage.text (元件 UI Text Field)

            } else if loveMessage.text == String() {
                number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言
                loveMessage.text = loveMessage.text
                
            }
    }

    // 點空白處收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }

    
    @IBAction func rateControl(_ sender: UISlider) {
        rate = sender.value
        rateLabel.text = String(format: "%.1f", rate)
    }
    
    
    @IBAction func volumeControl(_ sender: UISlider) {
        volume = sender.value
        volumeLabel.text = String(format: "%.1f", volume)
    }
    
    @IBAction func pitchControl(_ sender: UISlider) {
        pitch = sender.value
        pitchLabel.text = String(format: "%.1f", pitch)
    }
    
    func play () {
        let speechUtterance = AVSpeechUtterance(string: loveMessage.text!)
        if languageSelection.selectedSegmentIndex == 0 {
            number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言 (國語)
            loveMessage.text = content[number] // 匯入 變數 content 的內容到 loveMessage.text (元件 UI Text Field)
            
            } else if languageSelection.selectedSegmentIndex == 1 {
                number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言 (粵語)
                loveMessage.text = content[number] // 匯入 變數 content 的內容到 loveMessage.text (元件 UI Text Field)
                                
            } else if languageSelection.selectedSegmentIndex == 2 {
                number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言 (英語)
                loveMessage.text = content[number] // 匯入 變數 content 的內容到 loveMessage.text (元件 UI Text Field)

            } else if loveMessage.text == String() {
                number = languageSelection.selectedSegmentIndex // 選取 languageChoice 相對應的發聲語言
                loveMessage.text = loveMessage.text
                
            }
        
        speechUtterance.voice = AVSpeechSynthesisVoice(language: languageChoice[number])
        speechUtterance.pitchMultiplier = pitchSlider.value // 以 pitch slider 控制音調高低
        speechUtterance.rate = rateSlider.value // 以 rate slider 控制語速快慢
        speechUtterance.volume = volumeSlider.value // 以 volume slider 控制音量大小
        
        
        // 讓 元件 UI Button (Speak) 可以按第一下時播放，第二下時暫停，第三下時再播放
        if synthesizer.isSpeaking == false, speakButton.titleLabel!.text == "Speak" {
            synthesizer.speak(speechUtterance)
            speakButton.setTitle("Pause", for: UIControl.State.normal)
                
            
        } else if synthesizer.isSpeaking == true, speakButton.titleLabel!.text == "Pause" {
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            speakButton.setTitle("Speak again", for: UIControl.State.normal)
            
        } else if synthesizer.isPaused == true, speakButton.titleLabel!.text == "Speak again" {
            synthesizer.continueSpeaking()
            speakButton.setTitle("Pause", for: UIControl.State.normal)
            
        } else if synthesizer.isSpeaking == false, speakButton.titleLabel!.text == "Pause" {
            speakButton.setTitle("Speak", for: UIControl.State.normal)
            
        }
        
    }
    
  
    @IBAction func speak(_ sender: UIButton) {
        play()
    }
    
    
    @IBAction func randomSpeech(_ sender: UIButton) {
        
        number = Int.random(in: 0...2)
        loveMessage.text = content[number]
        
        pitchSlider.value = Float.random(in: 0.1...1.0)
        pitchLabel.text = String(format: "%.1f", pitchSlider.value)
        rateSlider.value = Float.random(in: 0.1...1.0)
        rateLabel.text = String(format: "%.1f", rateSlider.value)
        volumeSlider.value = Float.random(in: 0.5...1.0)
        volumeLabel.text = String(format: "%.1f", volumeSlider.value)
                
        play()
        
    }
    
}

