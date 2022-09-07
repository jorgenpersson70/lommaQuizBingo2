//
//  runBackGround.swift
//  piaxv5firebase
//
//  Created by jörgen persson on 2021-11-26.
//

import UIKit
import CoreLocation
import MapKit
import AVFoundation

private var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
private var backgroundTaskIdentifier2: UIBackgroundTaskIdentifier?

class runBackGround: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  //  UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
    let locationManager = CLLocationManager()
    var backgroundTimer = Timer()
    var counter = 0
    var coordinate = CLLocationCoordinate2D(latitude: 55.67786646547556, longitude: 13.076251074659215)
    
    let manager = CLLocationManager()
    
    @IBOutlet weak var runText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
/*
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.requestWhenInUseAuthorization()

        self.locationManager.allowsBackgroundLocationUpdates = true
      
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()*/
        
        self.manager.requestAlwaysAuthorization()
        self.manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.manager.allowsBackgroundLocationUpdates = true
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.manager.startUpdatingLocation()
            
            view.addSubview(mapView)
            mapView.frame = view.bounds
            
            mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)), animated: false)
            mapView.delegate = self
            
        }
        
        
        
        
        

   //     var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateLocation", userInfo: nil, repeats: true)
        // NSInvalidArgumentException
    //    var timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: "updateLocation", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
 //       var timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: Selector("updateLocation"), userInfo: nil, repeats: true)
        print("jag kör")
        runText.text = "jag kör"
        
        self.backgroundTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            self.updateCounting()
        })
    }
                                                    
    func updateCounting()
    {
        var teststring = "antal "
        teststring.append(String(counter))
        counter += 1
        runText.text = teststring
   //     startPlayer()
    }
    
    
    /*
     
     let state = UIApplication.shared.applicationState
     if state == .background || state == .inactive {
         // background
     } else if state == .active {
         // foreground
     }

     switch UIApplication.shared.applicationState {
         case .background, .inactive:
             // background
         case .active:
             // foreground
         default:
             break
     }
     
     */
    
    /* swift 4
     
     switch UIApplication.shared.applicationState {
     case .active:
         //app is currently active, can update badges count here
         break
     case .inactive:
         //app is transitioning from background to foreground (user taps notification), do what you need when user taps here
         break
     case .background:
         //app is in background, if content-available key of your notification is set to 1, poll to your backend to retrieve data and update your interface here
         break
     default:
         break
     }
     
     */
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopUpdatingLocation()
          return
       }
       // Notify the user of any errors.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    // wow, _ manager gick func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
     /*  if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
            
        }*/
 //       if (Toggle){
    //    if (self.cordsRead){
        
        
        if ((counter % 10) == 1 ){
            startPlayer()
        }
        var teststring = "antal "
        teststring.append(String(counter))
        counter += 1
        runText.text = teststring
        
        if (!readNewCoordinates){
            let location = locations.first
  //          render(location!)
        }
   //     }
    }
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

        runText.text = "updatelocation"
        
        if UIApplication.shared.applicationState == .active {

        } else {

            backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in
                
                self.backgroundTimer.invalidate()
           
                self.backgroundTimer = Timer.scheduledTimer( timeInterval: 60.0, target: self, selector: "updateLocation", userInfo: nil, repeats: true)
            })
        }
    }*/
    
    /*do {
     try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
     print("Playback OK")
     try AVAudioSession.sharedInstance().setActive(true)
     print("Session is Active")
 } catch {
     print(error)
 }*/
    
    /*
     let path = Bundle.main.path(forResource:"Bismallah", ofType: "mp3")

         do{
             try playerr = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
         } catch {
             print("File is not Loaded")
         }
         let session = AVAudioSession.sharedInstance()
         do{
             try session.setCategory(AVAudioSessionCategoryPlayback)
         }
         catch{
         }

         player.play()
     */
    
    /*
     audioPlayer.delegate = self
     audioPlayer.prepareToPlay()
     let audioSession = AVAudioSession.sharedInstance()
     do{
         try audioSession.setCategory(AVAudioSession.Category.playback)
     }
     catch{
         fatalError("playback failed")
     }
     */
    
    
    func startPlayer() {
        
        let path = Bundle.main.path(forResource: "Pling-sound-effect", ofType: "mp3")

            do{
                try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            } catch {
                print("File is not Loaded")
            }
            let session = AVAudioSession.sharedInstance()
            do{
                try session.setCategory(AVAudioSession.Category.playback)
            }
            catch{
            }

            audioPlayer.play()
        
        
     /*       guard let sound = Bundle.main.path(forResource: "Pling-sound-effect", ofType: "mp3") else {
                print("Error getting the mp3 file from the main bundle.")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            } catch {
                print("Audio file error.")
            }
            audioPlayer.play()*/
        }
    
    /* denna funkade
    
    func startPlayer() {
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
        }*/


    func updateLocation() {

  //      var timeRemaining = UIApplication.sharedApplication().backgroundTimeRemaining
        var timeRemaining = UIApplication.shared.backgroundTimeRemaining

        print(timeRemaining)

        if timeRemaining > 60.0 {
                print("timeRemaining > 60.0")
            }
         else
         {
            if timeRemaining == 0 {
  //            print("timeRemaining = 0")  UIApplication.sharedApplication().endBackgroundTask(backgroundTaskIdentifier)
                print("timeRemaining = 0")
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier!)
            }

        //    backgroundTaskIdentifier2 = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
             backgroundTaskIdentifier2 = UIApplication.shared.beginBackgroundTask(expirationHandler:
                                                                                    { () -> Void in
                self.backgroundTimer.invalidate()
                 self.backgroundTimer = Timer.scheduledTimer( timeInterval: 60.0, target: self, selector: "updateLocation", userInfo: nil, repeats: true)
            })
        }
    }



    
/* detta var kanske intressant
 
 private var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
 var timer: Timer?


 @IBAction func buttontapped(_ sender: Any)
 {
     timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block:
     {
         (timer) in

         NSLog("$$$$$ Time remaining: \(UIApplication.shared.backgroundTimeRemaining)")
     })

     self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler:
     {
         NSLog("$$$$$ Timer expired: Your app will not be executing code in background anymore.")

         if let indentifier = self.backgroundTaskIdentifier
         {
             UIApplication.shared.endBackgroundTask(indentifier)
         }
     })

     NSLog("$$$$$ start")
     DispatchQueue.main.asyncAfter(deadline:.now() + 30)
     {
         NSLog("$$$$$ end")
         if let indentifier = self.backgroundTaskIdentifier
         {
             UIApplication.shared.endBackgroundTask(indentifier)
         }
     }
 }
 */

/*
 
 import UIKit

 class ViewController: UIViewController {

     var time = 0

     var timer = Timer()

     @IBOutlet weak var outputLabel: UILabel!

     @IBOutlet weak var start: UIButton!

     @IBOutlet weak var paused: UIButton!

     @IBAction func startButton(_ sender: UIButton) {

         startButtonPressed()

     }

     @IBAction func pausedButton(_ sender: UIButton) {

         pausedButtonPressed()

     }

     @IBOutlet weak var timerLabel: UILabel!

     func updateTimerLabel() {

         let hours = Int(self.time) / 3600
         let minutes = Int(self.time) / 60 % 60
         let seconds = Int(self.time) % 60

         timerLabel.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)

     }

     func startButtonPressed() {

         outputLabel.text = "Workout Started"
         start.isHidden = true
         paused.isHidden = false

         _backgroundTimer(repeated: true)
         print("Calling _backgroundTimer(_:)")

     }

     func pausedButtonPressed(){

         outputLabel.text = "Workout Paused"
         timer.invalidate()
         pauseWorkout()

     }

     func pauseWorkout(){

         paused.isHidden = true
         start.isHidden = false

     }


     func _backgroundTimer(repeated: Bool) -> Void {
         NSLog("_backgroundTimer invoked.");

         //The thread I used is a background thread, dispatch_async will set up a background thread to execute the code in the block.

         DispatchQueue.global(qos:.userInitiated).async{
             NSLog("NSTimer will be scheduled...");

             //Define a NSTimer
             self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self._backgroundTimerAction(_:)), userInfo: nil, repeats: true);
             print("Starting timer")

             //Get the current RunLoop
             let runLoop:RunLoop = RunLoop.current;

             //Add the timer to the RunLoop
             runLoop.add(self.timer, forMode: RunLoopMode.defaultRunLoopMode);

             //Invoke the run method of RunLoop manually
             NSLog("NSTimer scheduled...");
             runLoop.run();

         }

     }

     @objc func _backgroundTimerAction(_ timer: Foundation.Timer) -> Void {

         print("_backgroundTimerAction(_:)")

         time += 1

         NSLog("time count -> \(time)");
     }


     override func viewDidLoad() {
         super.viewDidLoad()

         print("viewDidLoad()")

         print("Hiding buttons")
         paused.isHidden = true
         start.isHidden = false

         print("Clearing Labels")
         outputLabel.text = ""
         timerLabel.text = ""

         print("\(timer)")
         timer.invalidate()
         time = 0

     }
 }
 
 */
    
        
        

}
