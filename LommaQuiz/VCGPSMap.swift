//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import CoreLocation
import MapKit
import AVFoundation
import Firebase
import Lottie

var QuestFound : [Bool] = [false,false,false,false,false,false,false,false,false,false,false,false]
var useCheatCoordinates : Bool = false
var saveLongitude : Double = 0.0
var saveLatitude : Double = 0.0
var finiched = false
var longitude = [Double]()
var latitude = [Double]()

var QuestCoordLongitude1 : [Double] = [13.076251074659215,13.076603173915528,13.07686334818293,13.077120840246137,13.077356874635825,13.07767337530735,13.074486910948394,13.074299156312744,13.07408457958629,13.07498580183741,13.075833379906916,13.07599967686992]

var QuestCoordLatitude1 : [Double] = [55.67786646547556,55.678472026112516,55.67898016471325,55.67951400559161,55.68006598638061,55.680705669424434,55.67819753778474,55.67775593269402,55.67709351571015,55.6770360452147,55.6770057975516,55.677341545300955]

var readNewCoordinates = true
var counter = 0

class VCGPSMap: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var CheatCordLongitude : Double = 13.075822651070526
    var CheatCordLatitude : Double = 55.677364608933054
    var BlockRender : Bool = false // eller det löser sig kanske när vi lämnat vyn och jag stoppat timer och update
    var quizname : String = ""
    var questionnumberInt : Int = 0
    var WalkNumber = "1"
    var timer = Timer()
    let manager = CLLocationManager()
    var cordsRead = false
    var questionPos = 0
    var coordinate = CLLocationCoordinate2D(latitude: 55.67786646547556, longitude: 13.076251074659215)
    var nextQuestionPin = true // vid segue, kolla så att den blir true
    
    var counter = 0
//    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customAnimationView = AnimationView(name: "79155-heart-lottie-animation")
        customAnimationView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        //Do your configurations
        customAnimationView.loopMode = .loop
        customAnimationView.backgroundBehavior = .pauseAndRestore

        customAnimationView.play()

        //Initilise a bar button with this custom Lottie view and use it
        let yourBarButton = UIBarButtonItem(customView: customAnimationView)
        navigationItem.setRightBarButton(yourBarButton, animated: true)
        
       if (readNewCoordinates){
           checkIfTestSimulator()
           print("walknumer \(WalkNumber)")
            GetCoords(WalkNumberIn: WalkNumber) // kanske att vi inte skall läsa varje gång vi går in. vi kan komma via segue efter att ha svarat på fråga
  
        }
        
        if (quizname == "Bingo"){
            print("Binfo")
            print("Binfo")
        }
  
        self.manager.requestAlwaysAuthorization()
        self.manager.requestWhenInUseAuthorization()
 
        coordinate.longitude = QuestCoordLongitude1[0]
        coordinate.latitude = QuestCoordLatitude1[0]
         
        if CLLocationManager.locationServicesEnabled() {
            manager.allowsBackgroundLocationUpdates = true  // men timer är nedstängd när appen går i background
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  // nja, det blev inget bättre i klassrummet i vart fall          manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            
           manager.startUpdatingLocation()
            
            view.addSubview(mapView)
            mapView.frame = view.bounds
            
      //    Is it a bug or what ? if i change to 0.001, 0.001 it puts first pin where the last pin should be. I dont understand
            mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: false)
            mapView.delegate = self
        }
        
    }
 
    func checkIfTestSimulator() {
        var ref2: DatabaseReference!
        
        ref2 = Database.database().reference()
        
 //       bara för test nu
 //       loggedInHighest = true
        
        ref2.child("QuizWalks").child("TestFlag").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                print(error!.localizedDescription)
                return;
            }
            print(snapshot)
         
            if (snapshot != nil)
                {
                    print(snapshot.children)
                    for loginChild in snapshot.children
                    {
                        let loginChildSnap = loginChild as! DataSnapshot
                    
                        let LoginInfo = loginChildSnap.value as! String
                 
                        if (LoginInfo == "No"){
                            useCheatCoordinates = false
                        }else{
                            useCheatCoordinates = true
                        }
     // hallå test
                      // Nej !! nu har jag releasad version som inte tittar på highest
                        print(LoginInfo)
                        if ((LoginInfo == "Yes") && (loggedInHighest)){
                            useCheatCoordinates = true
                            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
                                self.updateCounting()
                            })
                        }
                        
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
        })
    }
    
    func checkIfTestSimulator2(){
        useCheatCoordinates = true
    }
    
    @IBAction func StopWalk(_ sender: Any) {
        walkFiniched()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.mapView.removeAnnotations(self.mapView.annotations)
        
        // ok, jag kom in här men det blev inte moving from parent. tryckte jag back så var det moving from parent
        if self.isMovingFromParent {
            print("you pressed back")
        }
        manager.stopUpdatingLocation()   // kanske inte, startar den igen tro ?
        self.timer.invalidate() // kan detta vara bra ? den verkade stoppa timer
    }
    
    
    // I only have this to make it easier to run in simulator, if TestFlag in firebase is "Yes", the timer will be turned on
    func updateCounting(){
        var coordinateNow = CLLocationCoordinate2D(latitude: QuestCoordLongitude1[questionnumberInt-1], longitude: QuestCoordLatitude1[questionnumberInt-1])
        
        if (useCheatCoordinates){
            print(questionnumberInt)
            if (questionnumberInt < 13){
                coordinateNow.longitude = QuestCoordLongitude1[questionnumberInt-1]
                coordinateNow.latitude = QuestCoordLatitude1[questionnumberInt-1]
            }
        
            self.mapView.showsUserLocation = true
  
            WithInLimits(longitudeIn:coordinateNow.longitude,latitudeIn:coordinateNow.latitude)
        }
    }
 
    func GetCoords(WalkNumberIn : String) {
        var ref: DatabaseReference!
        var quizWalkNumber = "Walk" + WalkNumberIn
        var i = 0
        
        ref = Database.database().reference()
        
        // I do this dirty save
        
        if ((WalkNumberIn == "1") || (WalkNumberIn == "2") || (WalkNumberIn == "3") || (WalkNumberIn == "4") || (WalkNumberIn == "5")){
            
        }else{
            if (ownWalk2 != ""){
                quizWalkNumber = ownWalk2
            }else{
                quizWalkNumber = WalkNumberIn
            }
        }
 
        if (questUser != "")
        {
            if (!loggedInHighest){
                quizWalkNumber = questUser
            }
        }
        
        if (questUserBingo != "")
        {
            if (!loggedInHighest){
                quizWalkNumber = questUserBingo
            }
        }
        
        print(quizWalkNumber)
        ref.child("QuizWalks").child("maps").child(quizWalkNumber).getData(completion:{error, snapshot in
                guard error == nil else
                {
                    print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                    return;
                }
                 print(snapshot)
            if (snapshot != nil)
                {
                    for QuizWalkMapChild in snapshot.children
                    {
                        let QuizWalkMapChildSnap = QuizWalkMapChild as! DataSnapshot
                        let QuizWalkMapChildInfo = QuizWalkMapChildSnap.value as! [String : Double]
  
                        QuestCoordLongitude1[i] = QuizWalkMapChildInfo["posLongitude"]!
                        QuestCoordLatitude1[i] = QuizWalkMapChildInfo["posLatitude"]!
                        i += 1
                        
                        self.cordsRead = true // denna bör nog bort
                    }
                    readNewCoordinates = false
                }
                else
                {
                    print("snapshot == nil")
                }
            })
    }
    
    /*func PrintCords(){
        for i in 0...11{
        }
    }
    
    func PrintCords2(){
        for i in 0...11{
        }
    }*/
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
           print(error)
          // Location updates are not authorized.
          manager.stopUpdatingLocation()
          return
       }
       // Notify the user of any errors.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
  
        if (!readNewCoordinates){
            var location = locations.first
                render(location!)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let myAnnotation = annotation as? AnnotationPin  else {
            return nil
        }

        let annotationIdentifier = "AnnotationIdentifier"

        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        if let annotationView = annotationView {
           
            annotationView.canShowCallout = true
            annotationView.image = myAnnotation.image
        }

        return annotationView
    }
    
    private func addCustomPin(pinPointNumber:Int){
        var imageString = "pin"
        var coordinateHere = CLLocationCoordinate2D(latitude: 55.67786646547556, longitude: 13.076251074659215)
        var pin : AnnotationPin
        
        coordinateHere.latitude = QuestCoordLatitude1[pinPointNumber]
        coordinateHere.longitude = QuestCoordLongitude1[pinPointNumber]
        
        print(coordinateHere.latitude)
        print(coordinateHere.longitude)
              
        imageString.append(String(pinPointNumber+1))
        
        print(imageString)
        
        pin = AnnotationPin(title: "pin", subtitle: "pin", image: UIImage(named: imageString)!, coordinate: coordinateHere)
 
        mapView.addAnnotation(pin)
    }
    
    func render(_ location: CLLocation){
        var coordinateNow = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        if (BlockRender){
            return
        }
        
        counter += 1
 //       test.text = String(counter)
 
        self.mapView.showsUserLocation = true
  
        WithInLimits(longitudeIn:coordinateNow.longitude,latitudeIn:coordinateNow.latitude)
    }
    
    func WithInLimits(longitudeIn:CLLocationDegrees,latitudeIn:CLLocationDegrees){
 
        let pin = MKPointAnnotation()
        var TwelweAnswers : Int = 0
        
        // vi ligger och tittar på alla frågornas position, kanske dumt
        for i in 0...11{
            print(QuestCoordLongitude1[i])
            print(QuestCoordLatitude1[i])
            if (!QuestFound[i]){
                if (!BlockRender){
                    if (useCheatCoordinates){
                        pin.coordinate.latitude = 10
                        pin.coordinate.longitude = 10
                    }else{
                    pin.coordinate.longitude = (longitudeIn - QuestCoordLongitude1[i])*100000
                    pin.coordinate.latitude = (latitudeIn - QuestCoordLatitude1[i])*100000
                    
                        if (nextQuestionPin){
                            self.addCustomPin(pinPointNumber:i) // den går in och sätter pin hela tiden
                            nextQuestionPin = false
                        }
                        
                        if (pin.coordinate.latitude < 0){
                            pin.coordinate.latitude *= -1
                        }
                        if (pin.coordinate.longitude < 0){
                            pin.coordinate.longitude *= -1
                        }
                    }
                    
                    print("-------------------")
                    print(pin.coordinate.latitude)
                    print(pin.coordinate.longitude)
                    print("-------------------")
                    print("questionnumber \(i+1)")
                    // I think this is around the same as meters
                    if (pin.coordinate.latitude < 15){
                        if (pin.coordinate.longitude < 15){
                            // kanske detta gör att vi inte hela tiden hoppar hem
                            coordinate.longitude = QuestCoordLongitude1[i]
                            coordinate.latitude = QuestCoordLatitude1[i]
                            
                            startPlayer()
                            BlockRender = true
                            
                            print("-------------------")
                            print(pin.coordinate.latitude)
                            print(pin.coordinate.longitude)
                            print("-------------------")
                            print("questionnumber \(i+1)")
                         
                            GoToQuestion(questionNumber:i+1)
                            QuestFound[i] = true
                            saveLongitude = longitudeIn
                            saveLatitude = latitudeIn
                        }
                    }
                }
            }
            else{
                TwelweAnswers += 1
                if (TwelweAnswers == 11){
                    print("elva")
                }
                
                if (TwelweAnswers == 12){
                    walkFiniched()
                }
            }
        }
    }
    
    func walkFiniched(){
        finiched = true
        BlockRender = true
        
        manager.stopUpdatingLocation()
        self.timer.invalidate()
        
        performSegue(withIdentifier: "showQuestion", sender: 99)
    }

    func GoToQuestion(questionNumber:Int) {
        if (quizname == "Bingo"){
            performSegue(withIdentifier: "showBingo", sender: questionNumber)
        }else{
            performSegue(withIdentifier: "showQuestion", sender: questionNumber)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showQuestion"){
            let dest = segue.destination as! VCWalkKm
            
            dest.finiched = finiched
            dest.quizname = quizname
     
            dest.questionnumberInt = sender as! Int
        }else{
            let dest = segue.destination as! VCSeeBingoPlayerRun
            var BingoPosInt = sender as! Int
            
            var ValuePos = 0
            
            BingoPosInt -= 1
            
            ValuePos = BingoPosInt * 3
            
            dest.ValuesToEvaluateB = ValuesToPresentBRead
            dest.ValuesToEvaluateI = ValuesToPresentIRead
            dest.ValuesToEvaluateN = ValuesToPresentNRead
            dest.ValuesToEvaluateG = ValuesToPresentGRead
            dest.ValuesToEvaluateO = ValuesToPresentORead
            
            dest.ValueToPopUp1 = ValuesToPopUp[ValuePos]
            dest.ValueToPopUp2 = ValuesToPopUp[ValuePos+1]
            if (ValuePos == 33){
                dest.ValueToPopUp3 = 0
            }else{
                dest.ValueToPopUp3 = ValuesToPopUp[ValuePos+2]
            }
            
            dest.BValues = BValuesRead
            dest.IValues = IValuesRead
            dest.NValues = NValuesRead
            dest.GValues = GValuesRead
            dest.OValues = OValuesRead
            
            dest.quizname = quizname
            dest.questionnumberInt = sender as! Int
        }
        
    }
    
    func startPlayer() {
        // This code allowed it to run in background
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
    }

}
