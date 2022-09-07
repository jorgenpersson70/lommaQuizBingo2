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

var YourAnswer = Array(repeating: 0, count: 12)

class VCWalkKm: UIViewController {
    @IBOutlet weak var Answer1TextView: UITextView!
    @IBOutlet weak var Answer2TextView: UITextView!
    @IBOutlet weak var Answer3TextView: UITextView!
    @IBOutlet weak var MyTextView: UITextView!
    @IBOutlet weak var LabelQuestNbr: UILabel!
    @IBOutlet weak var ButtonAnswer1: UIButton!
    @IBOutlet weak var ButtonAnswer2: UIButton!
    @IBOutlet weak var ButtonAnswer3: UIButton!
    @IBOutlet weak var ButtonListen: UIButton!
    
    @IBOutlet weak var myImage: UIImageView!
    
 //   var urlStringFrom = ""
    
    
    
    var quizname : String = ""
    var finiched = false
    var questionnumberInt : Int = 0
    var ref: DatabaseReference!
    var questions = [String]()
    var answers1 = [String]()
    var answers2 = [String]()
    var answers3 = [String]()
    var correctanswers = [String]()
    var URLs = [String]()
    var FoundQuestions = 0
    let storage = Storage.storage()
    var player:AVPlayer!
    var urlStringFrom2 = ""
    var urlStringFrom = ""
    
    let urlstring = "https://www.dropbox.com/preview/Beep%20Ping.mp3?context=browse&role=personal"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
/*        var urlStringFrom = "https://firebasestorage.googleapis.com/v0/b/fire1-95766.appspot.com/o/alnarp%2Fal.jpg?alt=media&token=879a09d3-8f3c-4e12-b7d6-6df8eb9a8727"
        
  */
        if VCLogin().isBingoUserLoggedIn(){
            performSegue(withIdentifier: "backToStart", sender: 1)
        }else{
            // Otherwise it will show for a short time
            ButtonListen.isEnabled = false
            ButtonListen.alpha = 0
            
            ref = Database.database().reference()
                    
            ref.child("QuizWalks").child("QuizNames").child(quizname).getData(completion:{error, snapshot in
                    guard error == nil else
                    {
                        print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                        return;
                    }
                     print(snapshot)
                if (snapshot != nil)
                    {
                        for quizNameChild in snapshot.children
                        {
                            let quizNameChildSnap = quizNameChild as! DataSnapshot
                            let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                              
                            self.questions.append(quizNameChildInfo["Fråga"]!)
                            self.answers1.append(quizNameChildInfo["Answer 1"]!)
                            self.answers2.append(quizNameChildInfo["Answer 2"]!)
                            self.answers3.append(quizNameChildInfo["Answer 3"]!)
                            self.correctanswers.append(quizNameChildInfo["Correct Answer"]!)
                            self.URLs.append(quizNameChildInfo["URLString"]!)
                            self.FoundQuestions = 1
                        }
                        
                    }
                    else
                    {
                        print("snapshot == nil")
                    }
                    DispatchQueue.main.async
                    {
                        if (self.FoundQuestions == 1){
                            if (self.questionnumberInt != 99){
                                self.loadQuestionAndAnswers()
                            }
                        }
                        else{
     
                        }
                    }
                })
            
            if (questionnumberInt == 99){
                performSegue(withIdentifier: "ToResult", sender: 1)
            }
            
            
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    func loadQuestionAndAnswers() {
        
        var song = false
        LabelQuestNbr.text = "Fråga " + String(questionnumberInt)
        
        MyTextView.text = questions[questionnumberInt-1]
    
        Answer1TextView.text = answers1[questionnumberInt-1]
        Answer2TextView.text = answers2[questionnumberInt-1]
        Answer3TextView.text = answers3[questionnumberInt-1]
        if (YourAnswer[questionnumberInt-1] == 1){
            ButtonAnswer1.backgroundColor = .systemGray2
            ButtonAnswer2.backgroundColor = .white
            ButtonAnswer3.backgroundColor = .white
        }
        if (YourAnswer[questionnumberInt-1] == 2){
            ButtonAnswer2.backgroundColor = .systemGray2
            ButtonAnswer1.backgroundColor = .white
            ButtonAnswer3.backgroundColor = .white
        }
        if (YourAnswer[questionnumberInt-1] == 3){
            ButtonAnswer3.backgroundColor = .systemGray2
            ButtonAnswer2.backgroundColor = .white
            ButtonAnswer1.backgroundColor = .white
        }
        
       // let string = "hello Swift"
       // if string.contains("Swift") {
            
        if (URLs[questionnumberInt-1].contains(".mp3")){
            song = true
        }
        
        if ((URLs[questionnumberInt-1] != "") && song){
            ButtonListen.isEnabled = true
            ButtonListen.alpha = 1
        }
        else{
            ButtonListen.isEnabled = false
            ButtonListen.alpha = 0
        }
        
        ButtonAnswer1.layer.cornerRadius = 5
        ButtonAnswer2.layer.cornerRadius = 10
        ButtonAnswer3.layer.cornerRadius = 15
        
        
        ///
     /*   let storage = Storage.storage()
        let storageRef = storage.reference()
 
        let frontpic = storageRef.child("lomma_front.png")
        frontpic.getData(maxSize: 2 * 1024 * 1024) { data, error in
          if let error = error {
        
          } else {
         
            let image = UIImage(data: data!)
              self.mainPicture.image = image
          }
        }*/
       
   /*     let storage = Storage.storage()
        let storageRef = storage.reference()
 
        let frontpic = storageRef.child("lomma_front.png")
        frontpic.getData(maxSize: 2 * 1024 * 1024) { data, error in
          if let error = error {
            
          } else {
            
            let image = UIImage(data: data!)
              self.myImage.image = image
          }
        }
        let url = NSURL(string: urlstring)*/
        
        if ((URLs[questionnumberInt-1] != "") && !song){
            fetchImage()
        }
 
        
        
    }
    
    private func fetchImage(){
   //     let pathReference = storage.reference(withPath: "alnarp/al.jpg")
        let pathReference = storage.reference(withPath: URLs[questionnumberInt-1])
        
        // Create a reference to the file you want to download
      //  let islandRef = storage.child("alnarp/al.jpg")

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
          //  let image = UIImage(data: data!)
              self.myImage.image = UIImage(data: data!)
          }
        }
    }
    
    @IBAction func ButtonAnswer1(_ sender: Any) {
        ButtonAnswer1.backgroundColor = .systemGray2
        ButtonAnswer2.backgroundColor = .white
        ButtonAnswer3.backgroundColor = .white
        YourAnswer[questionnumberInt-1] = 1
        performSegue(withIdentifier: "backToMap", sender: 1)
    }
    
    @IBAction func ButtonAnswer2(_ sender: Any) {
        ButtonAnswer2.backgroundColor = .systemGray2
        ButtonAnswer1.backgroundColor = .white
        ButtonAnswer3.backgroundColor = .white
        YourAnswer[questionnumberInt-1] = 2
        performSegue(withIdentifier: "backToMap", sender: 1)
    }
    
    @IBAction func ButtonAnswer3(_ sender: Any) {
        ButtonAnswer3.backgroundColor = .systemGray2
        ButtonAnswer1.backgroundColor = .white
        ButtonAnswer2.backgroundColor = .white
        YourAnswer[questionnumberInt-1] = 3
        performSegue(withIdentifier: "backToMap", sender: 1)
    }
    
    
    @IBAction func ButtonListenClick(_ sender: Any) {
        Talk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "backToMap"){
        
            let dest = segue.destination as! VCGPSMap
            questionnumberInt += 1
            dest.questionnumberInt = questionnumberInt
            dest.quizname = quizname
            dest.BlockRender = false
        }
        else{
            
            if (segue.identifier == "backToStart"){
                let dest = segue.destination as! ViewController
            }else{
                let dest = segue.destination as! VCResultat
                dest.quizname = quizname
                dest.YourAnswer = YourAnswer
            }
        }
    }
    
    func Talk() {
        // Then it was the last jump though here and the LYSSNA must be blocked
        if (questionnumberInt == 99){
            return
        }
  //      let videoRef = storage.reference().child("skuggor.mp3")
  //      print(questionnumberInt-1)
        
 //       var SoundName = URLs[questionnumberInt-1]
        
  //      print(SoundName)
                
        let urlstring = URLs[questionnumberInt-1]
            let url = NSURL(string: urlstring)
    //        print("the url = \(url!)")

        play(url: url!)
        
    }
    
    func play(url:NSURL) {
        print("playing \(url)")

        do {
            self.player = try AVPlayer(url: url as URL)
         //   player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }

    }

    func Talk2() {
        // Then it was the last jump though here and the LYSSNA must be blocked
        if (questionnumberInt == 99){
            return
        }
   //     let videoRef = storage.reference().child("introtal.mp3")
        print(questionnumberInt-1)
        
        var SoundName = URLs[questionnumberInt-1] + ".mp3"
        
        print(SoundName)
        
        var videoRef = storage.reference().child(SoundName)
  
 /*       if URLs[questionnumberInt-1].lowercased().range(of:"https") != nil {
            print("exists")
            videoRef = URLs[questionnumberInt-1]
        }
        else{
   
            videoRef = storage.reference().child(SoundName)
        }*/
        
        
            
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

    func TalkBefore() {
        // Then it was the last jump though here and the LYSSNA must be blocked
        if (questionnumberInt == 99){
            return
        }
        let videoRef = storage.reference().child("skuggor.mp3")
        print(questionnumberInt-1)
        
        var SoundName = URLs[questionnumberInt-1]
        
        print(SoundName)
        
        let urlstring = URLs[questionnumberInt-1]
        let url = NSURL(string: urlstring)
        print("the url = \(url!)")

        play(url: url!)
    
    }
}
