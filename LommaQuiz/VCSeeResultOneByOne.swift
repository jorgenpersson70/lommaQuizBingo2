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

class VCSeeResultOneByOne: UIViewController {
    @IBOutlet weak var Answer1Label: UILabel!
    @IBOutlet weak var Answer2Label: UILabel!
    @IBOutlet weak var Answer3Label: UILabel!
    @IBOutlet weak var LabelQuestNbr: UILabel!
    @IBOutlet weak var MyTextView: UITextView!
    @IBOutlet weak var Answer1TextView: UITextView!
    @IBOutlet weak var Answer2TextView: UITextView!
    @IBOutlet weak var Answer3TextView: UITextView!
    @IBOutlet weak var ButtonListen: UIButton!
    
    @IBOutlet weak var myImage: UIImageView!
    
    let storage = Storage.storage()
    var player:AVPlayer!
    var infotext = ""
    var quizname : String = ""
    var YourAnswer = Array(repeating: 0, count: 12)
    var questionnumberInt : Int = 0
    var ref: DatabaseReference!
    var questions = [String]()
    var answers1 = [String]()
    var answers2 = [String]()
    var answers3 = [String]()
    var correctanswers = [String]()
    var URLs = [String]()
    var FoundDate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    for quizWalkNameChild in snapshot.children
                    {
                        let quizWalkNameChildSnap = quizWalkNameChild as! DataSnapshot
                        let quizWalkNameChildInfo = quizWalkNameChildSnap.value as! [String : String]
                          
                        self.questions.append(quizWalkNameChildInfo["Fråga"]!)
                        self.answers1.append(quizWalkNameChildInfo["Answer 1"]!)
                        self.answers2.append(quizWalkNameChildInfo["Answer 2"]!)
                        self.answers3.append(quizWalkNameChildInfo["Answer 3"]!)
                        self.correctanswers.append(quizWalkNameChildInfo["Correct Answer"]!)
                        
                        self.URLs.append(quizWalkNameChildInfo["URLString"]!)
                        
                        self.FoundDate = 1
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
            // I dont know if this is neccessary but I keep it, it has been here forever
                DispatchQueue.main.async
                {
                    if (self.FoundDate == 1){
                        self.loadQuestionAndAnswers()
                    }
                    else{
                    }
                }
            })
 
    }
    
    @IBAction func ButtonListenClick(_ sender: Any) {
       // Talk()
        TalkNew()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        var song = false
        
        if (YourAnswer[questionnumberInt-1] == 1){
            Answer1Label.backgroundColor = .red
        }
        if (YourAnswer[questionnumberInt-1] == 2){
            Answer2Label.backgroundColor = .red
        }
        if (YourAnswer[questionnumberInt-1] == 3){
            Answer3Label.backgroundColor = .red
        }
                
        if ((correctanswers[questionnumberInt-1] == "1") && (YourAnswer[questionnumberInt-1] == 1))
        {
            Answer1Label.backgroundColor = .green
        }
        
        if ((correctanswers[questionnumberInt-1] == "2") && (YourAnswer[questionnumberInt-1] == 2))
        {
            Answer2Label.backgroundColor = .green
        }
        
        if ((correctanswers[questionnumberInt-1] == "3") && (YourAnswer[questionnumberInt-1] == 3))
        {
            Answer3Label.backgroundColor = .green
        }
        
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
    
    func loadQuestionAndAnswers() {

        LabelQuestNbr.text = "Fråga Nummer " + String(questionnumberInt)
        
        MyTextView.text = questions[questionnumberInt-1]
    
        Answer1TextView.text = answers1[questionnumberInt-1]
        Answer2TextView.text = answers2[questionnumberInt-1]
        Answer3TextView.text = answers3[questionnumberInt-1]
  
        if (correctanswers[questionnumberInt-1] == "1"){
            Answer1TextView.backgroundColor = .green
        }
        
        if (correctanswers[questionnumberInt-1] == "2"){
            Answer2TextView.backgroundColor = .green
        }
        
        if (correctanswers[questionnumberInt-1] == "3"){
            Answer3TextView.backgroundColor = .green
        }
    }
    
    func TalkNew() {
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
    
    func Talk() {
        var SoundName = URLs[questionnumberInt-1] + ".mp3"
        let videoRef = storage.reference().child(SoundName)
        
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
