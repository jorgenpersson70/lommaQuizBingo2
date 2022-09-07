//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import FirebaseStorage
import AVFoundation
import Firebase
import AVKit
import AVFAudio

class VCShowImageNew: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var showURLString: UITextField!
    @IBOutlet weak var ShowImage: UIImageView!
    
    let storage = Storage.storage()
    var player:AVPlayer!
    var audioPlayer: AVAudioPlayer!
    var urlStringFrom = ""
    var urlStringFrom2 = ""
    
    let urlstring = "https://www.dropbox.com/preview/Beep%20Ping.mp3?context=browse&role=personal"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pathReference = storage.reference(withPath: "alnarp/al.jpg")
        
        // Create a reference to the file you want to download
      //  let islandRef = storage.child("alnarp/al.jpg")

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
          //  let image = UIImage(data: data!)
              self.ShowImage.image = UIImage(data: data!)
          }
        }
        
        
     /*   let url = NSURL(string: urlstring)
        print("the url = \(url!)")
      

  
        if (urlStringFrom != "testar URL"){
            fetchImage()
            showURLString.text = urlStringFrom
        }
        else{
            showURLString.text = "Bild finns inte att visa"
        }*/
        
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func fetchImage(){
        print("\(urlStringFrom)")
        guard let url=URL(string:urlStringFrom)
        else{
            return
        }
        print(url)
 
        var urlStringFrom2 = " https://www.dropbox.com/preview/Beep%20Ping.mp3?context=browse&role=personal"
        
        let getDataTask=URLSession.shared.dataTask(with: url) {data, _,error in guard let data = data,error == nil else
            {return}
            DispatchQueue.main.async {
               // let image = UIImage(data: data)
                self.ShowImage.image = UIImage(data: data)
            }
        }
        
        getDataTask.resume()
    }
    

    @IBAction func testSound(_ sender: Any) {
   
        let videoRef = storage.reference().child("latt odmjuk.mp3")

        videoRef.getData(maxSize: 10 * 1024 * 1024) { data, error in

          if let error = error {

            print("ERROR: \(error)")
            print("Did not find video!")

          } else {

            let tmpFileURL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent("latt odmjuk").appendingPathExtension("mp3")
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
