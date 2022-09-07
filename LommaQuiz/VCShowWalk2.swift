//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

class VCShowWalk2: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var shownWalk: MKMapView!
    var longitudeHere = [Double]()
    var latitudeHere = [Double]()
    var walkNumber : Int = 0
    var timer = Timer()
    var cordsRead = false
    var questionPos = 0
 //   var chosenOwnWalk = ""
    
    var coordinate = CLLocationCoordinate2D(latitude: 55.67786646547556, longitude: 13.076251074659215) // bör plocka från rundans första
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // not really correct to talk the choice away here
        ownWalk2 = ""
        view.addSubview(shownWalk)
        shownWalk.frame = view.bounds
  
            self.GetCoords()
        // bara inte timer hinner före coords
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateCounting()
        })
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
    
    @IBAction func walkSelected(_ sender: Any){
        VCGPSMap().GetCoords(WalkNumberIn: String(walkNumber))
        // if they have chosen a special walk and then chose 1-5, then erase the own walk choice
     /*   if ((walkNumber > 0) && (walkNumber < 6)){
            ownWalk = ""
        }*/
        ownWalk2 = ""
        performSegue(withIdentifier: "backToStart", sender: 5)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        let dest = segue.destination as! ViewController
       
        dest.chosenWalk = walkNumber
    }
        
    // I dont remember why I created this timer and made it invalidate, was it to be sure that the coordinates has been read ?
    
    // OK, I used the timer to be sure that it is finiched, reading from firebase.
    func updateCounting(){
        
        if (self.cordsRead){
            coordinate.latitude = latitudeHere[0]
            coordinate.longitude = longitudeHere[0]
            
            shownWalk.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: false)
            shownWalk.delegate = self
            
            for i in 0...11{
                print("------------------------------")
                   print(self.latitudeHere[i])
                   print(self.longitudeHere[i])
                print("------------------------------")
                self.coordinate.latitude = self.latitudeHere[i]
                self.coordinate.longitude = self.longitudeHere[i]
                self.addCustomPin()
               }
            self.timer.invalidate()
        }
    }
    
 
    
    private func addCustomPin(){
 
        var imageString = "pin"
        
        var pin : AnnotationPin
        
        questionPos += 1
              
        imageString.append(String(questionPos))
        
        print(coordinate.longitude)
        print(coordinate.latitude)
        
        pin = AnnotationPin(title: "pin", subtitle: "pin", image: UIImage(named: imageString)!, coordinate: coordinate)
        
        self.shownWalk.addAnnotation(pin)
    }
    
    
    func GetCoords() {
        var ref: DatabaseReference!
        var quizWalkNumber = "Walk" + String(walkNumber)
        var longitudeDouble : Double = 0.0
        var latitudeDouble : Double = 0.0
        
        ref = Database.database().reference()
        
        if (loggedInToWrite)
        {
            if (!loggedInHighest)
            {
                quizWalkNumber = questUser
            }
        }
        print(quizWalkNumber)
        
        // dirty fix
        if (ownWalk2 != ""){
            quizWalkNumber = ownWalk2
        }
        
        ref.child("QuizWalks").child("maps").child(quizWalkNumber).getData(completion:{error, snapshot in
                guard error == nil else
                {
                    print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                    return;
                }
                 print(snapshot)
            if (snapshot != nil)
                {
                    for mapsChild in snapshot.children
                    {
                        let mapsChildSnap = mapsChild as! DataSnapshot
                       
                        let mapsChildInfo = mapsChildSnap.value as! [String : Double]
                        
                        longitudeDouble = mapsChildInfo["posLongitude"]!
                        latitudeDouble = mapsChildInfo["posLatitude"]!
                        
                        print("longitude \(longitudeDouble)")
                        print("longitude \(latitudeDouble)")
                        
                        self.longitudeHere.append(longitudeDouble) // global
                        self.latitudeHere.append(latitudeDouble) // global
          // denna var kanske fel
                    }
                    self.cordsRead = true
                }
                else
                {
                    print("snapshot == nil")
                }
            
            })
    }
   
}
