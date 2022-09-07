//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

class VCSetCoords: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
//    @IBOutlet weak var quizWalkNumber: UILabel!
    @IBOutlet weak var saveCoordinates: UIButton!
    @IBOutlet weak var saveCoordinateText: UILabel!
    @IBOutlet weak var quizPosNumber: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var nameOfWalk: UITextField!
    
    var QuestCoordLongitude : [Double] = [13.076251074659215,13.076603173915528,13.07686334818293,13.077120840246137,13.077356874635825,13.07767337530735,13.074486910948394,13.074299156312744,13.07408457958629,13.07498580183741,13.075833379906916,13.07599967686992]
    
    var QuestCoordLatitude : [Double] = [55.67786646547556,55.678472026112516,55.67898016471325,55.67951400559161,55.68006598638061,55.680705669424434,55.67819753778474,55.67775593269402,55.67709351571015,55.6770360452147,55.6770057975516,55.677341545300955]
    var render = 0
    var walkNumber : Int = 0
    var questionPosition : Int = 1
    var ref: DatabaseReference!
    var timer = Timer()
    var timerButton = Timer()
    var blockRender : Bool = false
    var QuestCoordLongitudeMine : Double = 0.0 // behövs ?
    var QuestCoordLatitudeMine : Double = 0.0
    var quizWalkName = "Walk"
    var timeForButtonGrey = 0

    let manager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.nameOfWalk.delegate = self
        
        nameOfWalk.text = ""
        
        if (VCLogin().isRundacLoggedIn()){
            nameOfWalk.isHidden = false
        }else{
            nameOfWalk.isHidden = true
        }
 
        checkIfWalkExists() // If not exist, den make an empty save.
//        quizWalkNumber.text = "RUNDA " + String(walkNumber)
        quizWalkName += String(walkNumber)
        print(quizWalkName)
        quizPosNumber.text = "GÅ TILL KOORDINAT " + String(questionPosition) + ", SPARA"
        saveCoordinateText.text = "SPARA KOORDINAT"
                                
        // Ask for Authorisation from the User.
        self.manager.requestAlwaysAuthorization()

        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
 
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
       //     manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            
            manager.startUpdatingLocation()
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
                self.updateCounting()
            })
        }
        self.timerButton = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            self.updateCountingButton()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Den plockar bort keyboard
    @IBAction func Done(_ sender: UITextField) {
        nameOfWalk.resignFirstResponder()
 
    }
    
    /*textField.resignFirstResponder()
        return true*/
    
    func updateCountingButton(){
        timeForButtonGrey += 1
        if (timeForButtonGrey > 4){
            saveCoordinates.backgroundColor = .white
            timeForButtonGrey = 0
        }
    }
    
    func updateCounting(){
      if (!blockRender){
          blockRender = true
          manager.stopUpdatingLocation()
      }
      else{
          blockRender = false
          manager.startUpdatingLocation()
      }
      print("counting...")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopUpdatingLocation()
          return
       }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            let location = locations.first
            render(location!)
    }
    
    func render(_ location: CLLocation){
        var coordinateNow = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        if !blockRender{
            QuestCoordLongitudeMine = location.coordinate.longitude
            QuestCoordLatitudeMine = location.coordinate.latitude
            
            mapView.showsUserLocation = true
            
            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                
            let region = MKCoordinateRegion(center: coordinateNow, span: span)
            mapView.setRegion(
                region, animated: true)
        }
    }
    
    @IBAction func saveCoordinates(_ sender: Any) {
        saveCoordinates.backgroundColor = .systemGray3
        timeForButtonGrey = 0
        if (VCLogin().isRundacLoggedIn()){
            if (nameOfWalk.text != ""){
                if (questionPosition < 13){
                    SaveCoords()
                }
                
                if (questionPosition == 12){
                    saveCoordinates.backgroundColor = .green
                    timerButton.invalidate()
                    saveCoordinateText.text = "KLAR. TRYCK Back."
                }
                
                if (questionPosition < 12){
                    questionPosition += 1
               //     quizPosNumber.text = "KOORDINAT " + String(questionPosition)
                    quizPosNumber.text = "GÅ TILL KOORDINAT " + String(questionPosition) + ", SPARA"
                }
            }
            
        }else{
            if (questionPosition < 13){
                SaveCoords()
            }
            
            if (questionPosition == 12){
                saveCoordinates.backgroundColor = .green
                timerButton.invalidate()
                saveCoordinateText.text = "KLAR. TRYCK Back."
            }
            
            if (questionPosition < 12){
                questionPosition += 1
           //     quizPosNumber.text = "KOORDINAT " + String(questionPosition)
                quizPosNumber.text = "GÅ TILL KOORDINAT " + String(questionPosition) + ", SPARA"
            }
        }
    }
    // testa att köra createemptysave direkt
    func checkIfWalkExists(){
        CreateEmptySave()
    }
    
    func SaveCoords() {
        var stringLong = ""
        var stringLat = ""
        stringLong.append(Character(UnicodeScalar(64+questionPosition)!))
        stringLat.append(Character(UnicodeScalar(64+questionPosition)!))

        if (loggedInToWrite)
        {
            if (loggedInHighest){
                self.ref.child("QuizWalks").child("maps").child(quizWalkName).child(stringLong).child("posLongitude").setValue(QuestCoordLongitudeMine)
                self.ref.child("QuizWalks").child("maps").child(quizWalkName).child(stringLat).child("posLatitude").setValue(QuestCoordLatitudeMine)
            }
            else
            {
                self.ref.child("QuizWalks").child("maps").child(questUser).child(stringLong).child("posLongitude").setValue(QuestCoordLongitudeMine)
                self.ref.child("QuizWalks").child("maps").child(questUser).child(stringLat).child("posLatitude").setValue(QuestCoordLatitudeMine)
            }
        }else{
            if (VCLogin().isRundacLoggedIn()){
                self.ref.child("QuizWalks").child("maps").child(nameOfWalk.text!).child(stringLong).child("posLongitude").setValue(QuestCoordLongitudeMine)
                self.ref.child("QuizWalks").child("maps").child(nameOfWalk.text!).child(stringLat).child("posLatitude").setValue(QuestCoordLatitudeMine)
            }
        }
    }
    
    
    @IBAction func endOfWritingName(_ sender: UITextField) {
       // nameOfWalk.resignFirstResponder()
        self.view.endEditing(true)
        CreateEmptySave()
    }
    
    
    
    func CreateEmptySave()
    {
        // jag testar
        ref = Database.database().reference()
        
        for i in 0 ... 11
        {
            var string = ""
            string.append(Character(UnicodeScalar(65+i)!))
            print(quizWalkName)
            if (loggedInToWrite)
            {
                if (loggedInHighest)
                {
                    self.ref.child("QuizWalks").child("maps").child(quizWalkName).child(string).child("posLongitude").setValue(QuestCoordLongitude[i])
                    self.ref.child("QuizWalks").child("maps").child(quizWalkName).child(string).child("posLatitude").setValue(QuestCoordLatitude[i])
                }
                else
                { // theLoggedUser
                    self.ref.child("QuizWalks").child("maps").child(questUser).child(string).child("posLongitude").setValue(QuestCoordLongitude[i])
                    self.ref.child("QuizWalks").child("maps").child(questUser).child(string).child("posLatitude").setValue(QuestCoordLatitude[i])
                }
            }
            if (VCLogin().isRundacLoggedIn()){
                if (nameOfWalk.text != ""){
                    self.ref.child("QuizWalks").child("maps").child(nameOfWalk.text!).child(string).child("posLongitude").setValue(QuestCoordLongitude[i])
                    self.ref.child("QuizWalks").child("maps").child(nameOfWalk.text!).child(string).child("posLatitude").setValue(QuestCoordLatitude[i])
                }
            }
        }
    }
}
