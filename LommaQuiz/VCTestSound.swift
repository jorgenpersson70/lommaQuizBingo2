//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import AVFoundation
//import AudioToolbox
var audioPlayer = AVAudioPlayer() // declare globally

class VCTestSound: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getMeaningOfLife() -> Int? {
        42
    }
      
    @IBAction func startPlayer(_ sender: Any) {
            guard let sound = Bundle.main.path(forResource: "Pling-sound-effect", ofType: "mp3") else {
                print("Error getting the mp3 file from the main bundle.")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            } catch {
                print("Audio file error.")
            }
            audioPlayer.play()
        }
    
    @IBAction func stopPlayer(_ sender: Any) {
        audioPlayer.stop()
    }
    
}
