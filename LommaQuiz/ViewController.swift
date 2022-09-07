//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase
import FirebaseStorage
import AVFoundation
import AVKit
import AVFAudio
import Lottie

import ImageIO
import MobileCoreServices

var chosenWalkGlobal = 0

class ViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate{
    @IBOutlet weak var startWalkButtonText: UILabel!
    @IBOutlet weak var choseWalkButton: UIButton!
    @IBOutlet weak var adminLoginText: UIButton!
    @IBOutlet weak var createBingoButton: UIButton!
    @IBOutlet weak var myAnimation: AnimationView!

    var chosenWalk = 1
    var fruits = [String]()
    var fruit2 = ""
    var Question = true
    let storage = Storage.storage()
    var player:AVPlayer!
    var showBingoButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenWalkGlobal = chosenWalk
        
 
 //       let storage = Storage.storage()
 //       let storageRef = storage.reference()
 
   //     let frontpic = storageRef.child("lomma_front.png")
        
 /*       let frontpic = storageRef.child("eye.png")
        frontpic.getData(maxSize: 2 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {

            let image = UIImage(data: data!)
          }
        }*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showBingoButton = VCLogin().isBingoCreateLoggedIn()
        if (showBingoButton){
            createBingoButton.isHidden = false
        }else{
            createBingoButton.isHidden = true
        }
    }
    
    
    
    /*@IBAction func buttonpress(_ sender: Any) {
        checkImage()
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        // if they have logged in for bingo and it is connected to a special walk, then make the choice disappear
        if ((loggedInToWalkSombodysSpecial) || (questUserBingo != "")){
            choseWalkButton.isEnabled = false
            choseWalkButton.alpha = 0
            startWalkButtonText.text = "STARTA RUNDA"
        }
        else
        {
            choseWalkButton.isEnabled = true
            choseWalkButton.alpha = 1
            
            switch chosenWalkGlobal {
            case 2:
                startWalkButtonText.text = "STARTA RUNDA 2"
            case 3:
                startWalkButtonText.text = "STARTA RUNDA 3"
            case 4:
                startWalkButtonText.text = "STARTA RUNDA 4"
            case 5:
                startWalkButtonText.text = "STARTA RUNDA 5"
            default:
                startWalkButtonText.text = "STARTA RUNDA 1"
            }
            
            if (ownWalk2 != ""){
                startWalkButtonText.text = "STARTA RUNDA"
            }
            
            if (takeAwayButtonToChooseRunda){
                choseWalkButton.isEnabled = false
                choseWalkButton.alpha = 0
                startWalkButtonText.text = "STARTA RUNDA"
            }
        }
 /*       heart1.contentMode = .scaleAspectFit
        heart1.loopMode = .loop
        heart1.play()
        heart2.contentMode = .scaleAspectFit
        heart2.loopMode = .loop
        heart2.play()*/
                
       
        myAnimation.contentMode = .scaleAspectFit
        myAnimation.loopMode = .loop
        myAnimation.play()
        
 /*
        let customAnimationView = AnimationView(name: "79727-man-walking")
        
        customAnimationView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        //Do your configurations
        customAnimationView.loopMode = .loop
        customAnimationView.backgroundBehavior = .pauseAndRestore

        customAnimationView.play()

        //Initilise a bar button with this custom Lottie view and use it
        let yourBarButton = UIBarButtonItem(customView: customAnimationView)
        navigationItem.setLeftBarButton(yourBarButton, animated: true)
        
        let customAnimationView2 = AnimationView(name: "48522-girl-walking-with-bag")
        customAnimationView2.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        //Do your configurations
        customAnimationView2.loopMode = .loop
        customAnimationView2.backgroundBehavior = .pauseAndRestore

        customAnimationView2.play()

        //Initilise a bar button with this custom Lottie view and use it
        let yourBarButton2 = UIBarButtonItem(customView: customAnimationView2)
        navigationItem.setRightBarButton(yourBarButton2, animated: true)*/
        
    }
    
   
    @IBAction func adminLogin(_ sender: Any) {
        
    }
    
    
    @IBAction func testbrnclick(_ sender: Any) {
   //    let dest = segue.destination as! VCChoseKm
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
    @IBAction func StartWalk(_ sender: Any) {
     //   loggedInToWalkSombodysSpecial
        // because if they have not made a choice, then coords are not loaded
        if (chosenWalkGlobal == 1)
        {
            VCGPSMap().GetCoords(WalkNumberIn: String(chosenWalkGlobal))
        }
        
        // vet inte om vi skall gå via VCChoseKm
        if (BingoName != ""){
            performSegue(withIdentifier: "WalkNumber", sender: "12")
        }else{
            performSegue(withIdentifier: "WalkNumber", sender: "12")
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "WalkNumber"){
            let dest = segue.destination as! VCChoseKm
            dest.walkNumber = String(chosenWalkGlobal)
            
   //         let dest = segue.destination as! VCShowImageNew
        }
        
        if (segue.identifier == "showImage"){
            let dest = segue.destination as! VCShowImageNew
  //          dest.walkNumber = String(chosenWalk)
        }
        
        
        
    }
    
    @IBAction func introSpeach(_ sender: Any) {
        introTalk()
    }
    
    func introTalk() {
   
        let videoRef = storage.reference().child("introtal.mp3")

        videoRef.getData(maxSize: 10 * 1024 * 1024) { data, error in

          if let error = error {

            print("ERROR: \(error)")
            print("Did not find video!")

          } else {

            let tmpFileURL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent("introtal").appendingPathExtension("mp3")
            do{
                try data!.write(to: tmpFileURL, options: [.atomic])
            }catch{
                print("error with video!")
            }
              
            self.player = AVPlayer(url: tmpFileURL)

            let controller = AVPlayerLayer(player: self.player)
            controller.player = self.player
            self.player!.isMuted = false

            do {
               try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            self.player!.play()

            controller.videoGravity = AVLayerVideoGravity.resizeAspectFill
     
              NotificationCenter.default.addObserver(forName: .AVPlayerItemPlaybackStalled, object: self.player?.currentItem, queue: .main) { _ in
                self.player!.seek(to: CMTime.zero)
                self.player!.play()
            }
          }
        }
    }
    
}









    
    
    
    
    

