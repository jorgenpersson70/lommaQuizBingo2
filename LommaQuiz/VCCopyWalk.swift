//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

class VCCopyWalk: UIViewController {
    
    @IBOutlet weak var readFrom: UITextField!
    @IBOutlet weak var writeTo: UITextField!
    @IBOutlet weak var statusReadWrite: UITextField!
    @IBOutlet weak var readFromWalk: UITextField!
    @IBOutlet weak var writeToWalk: UITextField!
    
    var quizWalkName2 : String = ""
    var questions = [String]()
    var answers1 = [String]()
    var answers2 = [String]()
    var answers3 = [String]()
    var correctanswers = [String]()
    var quiznamelist = [String]()
    var URLlist = [String]()
    
    var questionPosition : Int = 1
    var cordsRead = false
    var foundQuizName = false
    var ref: DatabaseReference!
    var QuestCoordLongitudeCopy : [Double] = [13.076251074659215,13.076603173915528,13.07686334818293,13.077120840246137,13.077356874635825,13.07767337530735,13.074486910948394,13.074299156312744,13.07408457958629,13.07498580183741,13.075833379906916,13.07599967686992]

    var QuestCoordLatitudeCopy : [Double] = [55.67786646547556,55.678472026112516,55.67898016471325,55.67951400559161,55.68006598638061,55.680705669424434,55.67819753778474,55.67775593269402,55.67709351571015,55.6770360452147,55.6770057975516,55.677341545300955]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func copyButton(_ sender: Any) {
        GetCoords()
    }
    
    func SaveCoords() {
        var string = ""
        let quizWalkName = writeTo.text
    
        for i in 0...11{
            string = String(Character(UnicodeScalar(65+i)!))
            self.ref.child("QuizWalks").child("maps").child(quizWalkName!).child(string).child("posLongitude").setValue(QuestCoordLongitudeCopy[i])
            self.ref.child("QuizWalks").child("maps").child(quizWalkName!).child(string).child("posLatitude").setValue(QuestCoordLatitudeCopy[i])
        }
        statusReadWrite.text = "\(readFrom.text!) Kopierad till \(writeTo.text!)"
    }
    
    func GetCoords() {
        var quizWalkName = "Walk1"
        self.cordsRead = false
        var i = 0
 
        if (readFrom.text != ""){
            quizWalkName = readFrom.text!
        }
 
        print(quizWalkName)
        ref.child("QuizWalks").child("maps").child(quizWalkName).getData(completion:{ [self]error, snapshot in
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
                        
                        QuestCoordLongitudeCopy[i] = QuizWalkMapChildInfo["posLongitude"]!
                        QuestCoordLatitudeCopy[i] = QuizWalkMapChildInfo["posLatitude"]!
                        i += 1  // Could use QuizWalkMapChild
                        self.cordsRead = true
                    }
                    if (self.cordsRead){
                        SaveCoords()
                    }
                    else{
                        statusReadWrite.text = "Namnet på rundan finns inte"
                    }
                }
                else
                {
                    print("snapshot == nil")
                    statusReadWrite.text = "Namnet på rundan finns inte"
                }
            })
    }
    
    func SaveWalk() {
        for i in 0 ... 11{
            var qstring = "Fråga " + String(i)
            
            var string = "Fråga "
            string.append(Character(UnicodeScalar(65+i)!))
   
            self.ref.child("QuizWalks").child("QuizNames").child(writeToWalk.text!).child(string).child("Fråga").setValue(self.questions[i])
            self.ref.child("QuizWalks").child("QuizNames").child(writeToWalk.text!).child(string).child("Answer 1").setValue(self.answers1[i])
            self.ref.child("QuizWalks").child("QuizNames").child(writeToWalk.text!).child(string).child("Answer 2").setValue(self.answers2[i])
            self.ref.child("QuizWalks").child("QuizNames").child(writeToWalk.text!).child(string).child("Answer 3").setValue(self.answers3[i])
            self.ref.child("QuizWalks").child("QuizNames").child(writeToWalk.text!).child(string).child("URLString").setValue(self.URLlist[i])
            self.ref.child("QuizWalks").child("QuizNames").child(writeToWalk.text!).child(string).child("Correct Answer").setValue(self.correctanswers[i])
        }
        statusReadWrite.text = "\(readFrom.text!) Kopierad till \(writeTo.text!)"
    }
    
    
    @IBAction func copyButton2(_ sender: Any) {
        GetWalk()
    }
    
    func GetWalk() {
        questions.removeAll()
        answers1.removeAll()
        answers2.removeAll()
        answers3.removeAll()
        correctanswers.removeAll()
        quiznamelist.removeAll()
        URLlist.removeAll()
        
        self.foundQuizName = false
        var readCountQuest = 0
        ref.child("QuizWalks").child("QuizNameList").getData(completion:{ [self]error, snapshot in
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
                  
                        let quizNameInfo = quizNameChildSnap.value as! [String : String]
                          
                        self.quiznamelist.append(quizNameInfo["name"]!)
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
            // nu har vi en hel lista med namn på frågerundor, nu skall vi kolla om en frågerunda med det inskrivna namnet finns i listan
       
            var searchString = "Historia Sverige 1" // ända till tom
            //searchString = quizWalkName2
            
            searchString = readFromWalk.text!

            var result = quiznamelist.contains(where: searchString.contains)
 
                DispatchQueue.main.async
                {
                    if (!result){
                      //  self.CreateEmptySave()
                      //  statusReadWrite.text = "\(readFrom.text!) Kopierad till \(writeTo.text!)"
                        statusReadWrite.text = "namnet finns inte"
                        return
                    }
                    else{
                        SaveWalkName()
                    }
                }
            })
       
        ref.child("QuizWalks").child("QuizNames").child(readFromWalk.text!).getData(completion:{error, snapshot in
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
                    
                        let quizNameInfo = quizNameChildSnap.value as! [String : String]
                          
                        self.questions.append(quizNameInfo["Fråga"]!)
                        self.answers1.append(quizNameInfo["Answer 1"]!)
                        self.answers2.append(quizNameInfo["Answer 2"]!)
                        self.answers3.append(quizNameInfo["Answer 3"]!)
                        self.URLlist.append(quizNameInfo["URLString"]!)
                        self.correctanswers.append(quizNameInfo["Correct Answer"]!)
 
                        readCountQuest += 1
                    }
 
                    DispatchQueue.main.async
                    {
                        if (readCountQuest == 12){
                            self.SaveWalk()
                        }
                    }
                    
                }
                else
                {
                    print("snapshot == nil")
                }
            })
           

    }
    
    func SaveWalkName() {
        if (loggedInHighest){
            self.ref.child("QuizWalks").child("QuizNameList").childByAutoId().setValue(["name" : writeToWalk.text!, "user" : "everyone"])
        }
    }

}
