//
//  VCBingo.swift
//  LommaQuiz
//
//  Created by jörgen persson on 2022-08-19.
//

import UIKit
import Firebase
//var test : String = "hej"

//var dataArray:[Any] = []
//var testar : BingoPresentValues = [Int]

//var one : [Int] = []
//var one2 :  Bingo1 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15]
//var testar : [Bingo1] = []

/*[[ValuesToPresentBRead, ValuesToPresentBRead, ValuesToPresentBRead, ValuesToPresentBRead, ValuesToPresentBRead]]*/


// to be able to create own bingo, they must log in as jorgen@icloud.com or bingoc@icloud.com
// this means that all users must be logged in because everybody reads and writes so that the number of
// participants can be counted.
var takeAwayButtonToChooseRunda = false

class VCBingo: UIViewController {
    var ref: DatabaseReference!
    
    @IBOutlet weak var BingGroupName: UITextField!
    @IBOutlet weak var BingoCountPersons: UITextField!
    @IBOutlet weak var BingoConnectRunda: UITextField!
    @IBOutlet weak var LogginPassword: UITextField!
    
    @IBOutlet weak var AlertTextView: UITextView!
    
    
    
    
    let BValues = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    let IValues = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    let NValues = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    let GValues = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    let OValues = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues2 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues2 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues2 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues2 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues2 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues3 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues3 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues3 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues3 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues3 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues4 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues4 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues4 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues4 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues4 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues5 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues5 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues5 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues5 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues5 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues6 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues6 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues6 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues6 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues6 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues7 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues7 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues7 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues7 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues7 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues8 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues8 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues8 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues8 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues8 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues9 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues9 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues9 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues9 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues9 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues10 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues10 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues10 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues10 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues10 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValues11 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValues11 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValues11 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValues11 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValues11 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var BValuesTemp = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var IValuesTemp = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var NValuesTemp = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var GValuesTemp = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var OValuesTemp = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var ValuesToPresentB = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
    var ValuesToPresentI = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
    var ValuesToPresentN = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
    var ValuesToPresentG = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
    var ValuesToPresentO = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
    
    var ValuesToEvaluateB = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateI = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateN = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateG = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateO = [1, 2, 3,4,5,6,7]
    
 /*   var BValuesTemp = [1, 2, 3,4,5,6,7,8,9].shuffled()
    var IValuesTemp = [11, 12, 13,14,15,16,17,18,19].shuffled()
    var NValuesTemp = [21, 22, 23,24,25,26,27,28,29].shuffled()*/
    
    var WhereToPutIt = Int.random(in: 1..<37)
    
 //   var WhereToPutIt = Int.random(in: 31..<37)
    
    var WinnerNumbers = [0,0,0,0,0]
    
    var NumberInBChart1 = 0
    var NumberInBChart2 = 0
    var NumberInBChart3 = 0
    
    var NumberInRow1Chart1 = 0
    var NumberInRow2Chart1 = 0
    var NumberInRow3Chart1 = 0
    var NumberInRow4Chart1 = 0
    var NumberInRow5Chart1 = 0
    
    var NumberInIChart1 = 0
    var NumberInIChart2 = 0
    var NumberInIChart3 = 0
    
    var NumberInRow1Chart2 = 0
    var NumberInRow2Chart2 = 0
    var NumberInRow3Chart2 = 0
    var NumberInRow4Chart2 = 0
    var NumberInRow5Chart2 = 0
    
    var NumberInNChart1 = 0
    var NumberInNChart2 = 0
    var NumberInNChart3 = 0
    
    var NumberInRow1Chart3 = 0
    var NumberInRow2Chart3 = 0
    var NumberInRow3Chart3 = 0
    var NumberInRow4Chart3 = 0
    var NumberInRow5Chart3 = 0
    
    var NumberInGChart1 = 0
    var NumberInGChart2 = 0
    var NumberInGChart3 = 0
    
    var NumberInOChart1 = 0
    var NumberInOChart2 = 0
    var NumberInOChart3 = 0
    
    var LatestPassword = "0"
    
    var Year = ""
    var Month = ""
    var Day = ""
    
    
    var ReadYear = ""
    var ReadDay = ""
    var ReadMonth = ""
    
    var BingoNameErase = ""
    var ChildByAutoErase = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        LogginPassword.text = "INGET LÖSEN ÄNNU"
        AlertTextView.isHidden = true
        BingGroupName.text = ""
        BingoConnectRunda.text = ""
        BingoCountPersons.text = ""
        takeAwayButtonToChooseRunda = false
        
        loadPassword()
     
        getDate()
        checkIfWeShouldErase()
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (ownWalk2 != ""){
            BingoConnectRunda.text = ownWalk2
        }
    }
    
    @IBAction func done(_ sender: UITextField) {
        BingoConnectRunda.resignFirstResponder()
    }
    
    @IBAction func doneCount(_ sender: UITextField) {
        BingoCountPersons.resignFirstResponder()
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func loadPassword() {
        self.ref.child("BingoName").child("BingoPassword").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                    print(error!.localizedDescription)
                    return;
                }
                 print(snapshot)
            if (snapshot != nil)
                {
                    for quizNameChild in snapshot.children
                    {
                        let quizNameChildSnap = quizNameChild as! DataSnapshot
                        let quizNameChildInfo = quizNameChildSnap.value as! String
                        LatestPassword = quizNameChildInfo
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
                DispatchQueue.main.async
                {
                    
                }
            })
    }
    
   
    @IBAction func nemeFinich(_ sender: UITextField) {
        //sender.resignFirstResponder()
        view.endEditing(true)
    }
    
    
   /* @IBAction func participantsFinich(_ sender: Any) {
    }*/
    
    
    @IBAction func countParticipantsFinich(_ sender: UITextField) {
        //sender.resignFirstResponder()
        view.endEditing(true)
    }
    
    /*@IBAction func getpasswordbtn(_ sender: Any) {
        loadPassword()
    }*/
    
    
    func saveCharts() {
        
        var Exists = false
        var TempStr = "Player "
        
        var childBy = ref.childByAutoId().key
        
        //let keyValue = ref.childByAutoId.key
        
        let CountInt = (BingoCountPersons.text as! NSString).intValue
        
        // KOLLA SÅ ATT INTE BingGroupName.text REDAN FINNS
        self.ref.child("BingoName").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                    print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                    return;
                }
                 print(snapshot)
                if (snapshot != nil)
                    {
                    var j = 0
                    var connectedWalk = ""
                        for quizNameChild in snapshot.children
                        {
                            let quizNameChildSnap = quizNameChild as! DataSnapshot
                            let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                            
                            print("", snapshot.key)
                            print("", snapshot.key)
                           
                            print("", quizNameChildSnap.key)
                            print("", quizNameChildSnap.key)
                            
                            if (quizNameChildSnap.key != "BingoPassword"){
                                
                                if (quizNameChildInfo["name"] == BingGroupName.text){
                                    Exists = true
 //                                   return;
                                }
                            }
                        }
                    
                        var walkExists = false
                        var checkIfThisWalkExists = ""
                        if (BingoConnectRunda.text == ""){
                       //     BingoConnectRunda.text = "Walk1"
                            checkIfThisWalkExists = "Walk1"
                        }
                        else{
                            checkIfThisWalkExists = BingoConnectRunda.text!
                        }
                        // check if walk exists
                        ref.child("QuizWalks").child("maps").child(checkIfThisWalkExists).getData(completion:{error, snapshot in
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
                                                walkExists = true
 //                                               takeAwayButtonToChooseRunda = true
                                            }
                        
                                            if ((BingoCountPersons.text != "") && (BingGroupName.text != "") && (CountInt > 0) && (CountInt < 11) && (Exists == false) && (walkExists)){
                                                
                                                // sätt maxlängd på sträng för namn
                                                
                                                LatestPassword = String(Int(LatestPassword)! + 1)
                                                LogginPassword.text = LatestPassword
                                                AlertTextView.isHidden = false
                                                AlertTextView.text = "FÖR LÖSENORD, SE NEDAN"
                                                
                                              //  var dateString = Year+
                                                
                                                self.ref.child("BingoName").child(String(childBy!)).setValue(["name" : (String(BingGroupName.text!)), "Password" : LatestPassword, "PersonsLoggedIn" : "0", "CountExpected" : (String(BingoCountPersons.text!)), "Year" : Year, "Month" : Month, "Day" : Day])
                                                
                                               
                                                
                                                // annars kolla så att den finns
                                                if (BingoConnectRunda.text == ""){
                                             //       self.ref.child("BingoName").child(String(childBy!)).child("ConnectToWalk").setValue("Walk1")
                                                    self.ref.child("BingoName").child(String(childBy!)).child("ConnectToWalk").setValue("")
                                            
                                                }
                                                else{
                                                    // kolla så att den finns
                                                   self.ref.child("BingoName").child(String(childBy!)).child("ConnectToWalk").setValue(BingoConnectRunda.text)
                                                
                                                }
                                                
                                                self.ref.child("BingoName").child(String(childBy!)).child("ChildByAuto").setValue(String(childBy!))
                                                
                                                // the winner must not be the first logged in always
                                                var TheChosenWinner = Int.random(in: 1..<Int(CountInt+1))
                                                
                                                self.ref.child("BingoName").child(String(childBy!)).child("SelectedWinner").setValue(String(TheChosenWinner))
                                             
                                                self.ref.child("BingoName").child("BingoPassword").child("BingoPassword").setValue(LatestPassword)
                                                
                                                self.ref.child("BingoPlayersValuesToPresent").child(String(BingGroupName.text!)).setValue(["B1ValuesToPresent" : ValuesToPresentB,
                                                                                                                             "B2IValuesToPresent" : ValuesToPresentI,
                                                                                                                             "B3NValuesToPresent" : ValuesToPresentN,
                                                                                                                           "B4GValuesToPresent" : ValuesToPresentG,
                                                                                                                             "B5OValuesToPresent" : ValuesToPresentO])
                                                
                                                self.ref.child("BingoPlayerWinner").child(String(BingGroupName.text!)).child("TheWinner").setValue("0")
                                                
                                                for i in 1 ... 11{
                                                         
                                                            switch (i){
                                                                case 1:
                                                                    self.BValuesTemp = self.BValues
                                                                    self.IValuesTemp = self.IValues
                                                                    self.NValuesTemp = self.NValues
                                                                    self.GValuesTemp = self.GValues
                                                                    self.OValuesTemp = self.OValues
                                                                case 2:
                                                                    self.BValuesTemp = self.BValues2
                                                                    self.IValuesTemp = self.IValues2
                                                                    self.NValuesTemp = self.NValues2
                                                                    self.GValuesTemp = self.GValues2
                                                                    self.OValuesTemp = self.OValues2
                                                                case 3:
                                                                    self.BValuesTemp = self.BValues3
                                                                    self.IValuesTemp = self.IValues3
                                                                    self.NValuesTemp = self.NValues3
                                                                    self.GValuesTemp = self.GValues3
                                                                    self.OValuesTemp = self.OValues3
                                                                case 4:
                                                                    self.BValuesTemp = self.BValues4
                                                                    self.IValuesTemp = self.IValues4
                                                                    self.NValuesTemp = self.NValues4
                                                                    self.GValuesTemp = self.GValues4
                                                                    self.OValuesTemp = self.OValues4
                                                                case 5:
                                                                    self.BValuesTemp = self.BValues5
                                                                    self.IValuesTemp = self.IValues5
                                                                    self.NValuesTemp = self.NValues5
                                                                    self.GValuesTemp = self.GValues5
                                                                    self.OValuesTemp = self.OValues5
                                                                case 6:
                                                                    self.BValuesTemp = self.BValues6
                                                                    self.IValuesTemp = self.IValues6
                                                                    self.NValuesTemp = self.NValues6
                                                                    self.GValuesTemp = self.GValues6
                                                                    self.OValuesTemp = self.OValues6
                                                                case 7:
                                                                    self.BValuesTemp = self.BValues7
                                                                    self.IValuesTemp = self.IValues7
                                                                    self.NValuesTemp = self.NValues7
                                                                    self.GValuesTemp = self.GValues7
                                                                    self.OValuesTemp = self.OValues7
                                                                case 8:
                                                                    self.BValuesTemp = self.BValues8
                                                                    self.IValuesTemp = self.IValues8
                                                                    self.NValuesTemp = self.NValues8
                                                                    self.GValuesTemp = self.GValues8
                                                                    self.OValuesTemp = self.OValues8
                                                                case 9:
                                                                    self.BValuesTemp = self.BValues9
                                                                    self.IValuesTemp = self.IValues9
                                                                    self.NValuesTemp = self.NValues9
                                                                    self.GValuesTemp = self.GValues9
                                                                    self.OValuesTemp = self.OValues9
                                                                case 10:
                                                                    self.BValuesTemp = self.BValues10
                                                                    self.IValuesTemp = self.IValues10
                                                                    self.NValuesTemp = self.NValues10
                                                                    self.GValuesTemp = self.GValues10
                                                                    self.OValuesTemp = self.OValues10
                                                                case 11:
                                                                    self.BValuesTemp = self.BValues11
                                                                    self.IValuesTemp = self.IValues11
                                                                    self.NValuesTemp = self.NValues11
                                                                    self.GValuesTemp = self.GValues11
                                                                    self.OValuesTemp = self.OValues11
                                                            
                                                            default:
                                                                self.BValuesTemp = self.BValues
                                                                self.IValuesTemp = self.IValues
                                                                self.NValuesTemp = self.NValues
                                                                self.GValuesTemp = self.GValues
                                                                self.OValuesTemp = self.OValues
                                                            }
                                                        // eller skall de vara under arne ??
                                                    self.ref.child("BingoPlayersCharts").child(String(BingGroupName.text!)).child(TempStr + String(i)).child("B1values").setValue(self.BValuesTemp)
                                                    self.ref.child("BingoPlayersCharts").child(String(BingGroupName.text!)).child(TempStr + String(i)).child("B2Ivalues").setValue(self.IValuesTemp)
                                                    self.ref.child("BingoPlayersCharts").child(String(BingGroupName.text!)).child(TempStr + String(i)).child("B3Ivalues").setValue(self.NValuesTemp)
                                                    self.ref.child("BingoPlayersCharts").child(String(BingGroupName.text!)).child(TempStr + String(i)).child("B4Gvalues").setValue(self.GValuesTemp)
                                                    self.ref.child("BingoPlayersCharts").child(String(BingGroupName.text!)).child(TempStr + String(i)).child("B5Ovalues").setValue(self.OValuesTemp)
                                                        }
                                            }
                                            else{
                                                AlertTextView.isHidden = false
                                                
                                                if (!walkExists){
                                                    AlertTextView.text = "DET FINNS INGEN RUNDA MED DET NAMNET"
                                                }else{
                                                    if (Exists){
                                                        AlertTextView.text = "NAMNET FINNS REDAN"
                                                    } else{
                                                        if ((CountInt < 1) || (CountInt > 10)){
                                                            AlertTextView.text = "JUSTERA ANTAL"
                                                        }else{
                                                            
                                                            AlertTextView.text = "JUSTERA NAMN"
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                    else
                                    {
                                        print("snapshot == nil")
                                    }
                            }) // BingoConnectRunda.text
                }
                else
                {
                    print("snapshot == nil")
                }
                DispatchQueue.main.async
                {
                    
                }
        })
    }
    
    
    
    @IBAction func CreateBingoChartBtn(_ sender: Any) {
        // make keyboard disappear
        view.endEditing(true)
        CreateBingoChart()
        saveCharts()
    }
    
    func CreateBingoChart()
    {
        var WinnerFound = true
        WhereToPutIt = Int.random(in: 1..<37)
    //    WhereToPutIt = Int.random(in: 31..<37)
        
   //     WhereToPutIt = Int.random(in: 35..<37)
        
        GetWinnerNumbers()
        
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer2()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer3()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer4()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer5()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer6()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer7()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer8()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer9()
            }
            WinnerFound = true
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer10()
            }
            while (WinnerFound){
                WinnerFound = GetNewValuesPlayer11()
            }
    }
    
    func GetWinnerNumbers(){
        var HowMany = 0
        // rows
           if (WhereToPutIt < 16){
               WinnerNumbers[0] = BValues[WhereToPutIt-1]
               WinnerNumbers[1] = IValues[WhereToPutIt-1]
               WinnerNumbers[2] = NValues[WhereToPutIt-1]
               WinnerNumbers[3] = GValues[WhereToPutIt-1]
               WinnerNumbers[4] = OValues[WhereToPutIt-1]
               
               for m in 0...6{
                   if (WinnerNumbers[0] == ValuesToPresentB[m]){
                       var temp = ValuesToPresentB[6]
                  
                       // change so the they walk the hole round, pos 11 or pos 12 before there is a winner
                       ValuesToPresentB[6] = WinnerNumbers[0]
                       
                       ValuesToPresentB[m] = temp
                       
                       HowMany += 1
                       break
                   }
               }
               // not found
               if (HowMany == 0){
                   var temp = ValuesToPresentB[6]
                   ValuesToPresentB[6] = WinnerNumbers[0]
                   
                   ValuesToPresentB[0] = temp
                   
                   HowMany += 1
               }
               for m in 0...6{
                   if (WinnerNumbers[1] == ValuesToPresentI[m]){
                       var temp = ValuesToPresentI[6]
                       ValuesToPresentI[6] = WinnerNumbers[1]
                       ValuesToPresentI[m] = temp
                       
                       HowMany += 1
                       break
                   }
               }
               // not found
               if (HowMany == 1){
                   var temp = ValuesToPresentI[6]
                   ValuesToPresentI[6] = WinnerNumbers[1]
                   
                   ValuesToPresentI[0] = temp
                   
                   HowMany += 1
               }
               for m in 0...6{
                   if (WinnerNumbers[2] == ValuesToPresentN[m]){
                       var temp = ValuesToPresentN[6]
                       ValuesToPresentN[6] = WinnerNumbers[2]
                       ValuesToPresentN[m] = temp
                       
                       HowMany += 1
                       break
                   }
               }
               // not found
               if (HowMany == 2){
                   var temp = ValuesToPresentN[6]
                   ValuesToPresentN[6] = WinnerNumbers[2]
                   
                   ValuesToPresentN[0] = temp
                   
                   HowMany += 1
               }
               for m in 0...6{
                   if (WinnerNumbers[3] == ValuesToPresentG[m]){
                       var temp = ValuesToPresentG[6]
                       ValuesToPresentG[6] = WinnerNumbers[3]
                       ValuesToPresentG[m] = temp
                       
                       HowMany += 1
                       break
                   }
               }
               // not found
               if (HowMany == 3){
                   var temp = ValuesToPresentG[6]
                   ValuesToPresentG[6] = WinnerNumbers[3]
                   
                   ValuesToPresentG[0] = temp
                   
                   HowMany += 1
               }
               for m in 0...6{
                   if (WinnerNumbers[4] == ValuesToPresentO[m]){
                       var temp = ValuesToPresentO[6]
                       ValuesToPresentO[6] = WinnerNumbers[4]
                       ValuesToPresentO[m] = temp
                       
                       HowMany += 1
                       break
                   }
               }
               // not found
               if (HowMany == 4){
                   var temp = ValuesToPresentO[6]
                   ValuesToPresentO[6] = WinnerNumbers[4]
                   
                   ValuesToPresentO[0] = temp
                   
                   HowMany += 1
               }
               print("sä många ", String(HowMany))
               print("sä många ", String(HowMany))
        }
    
           // columns
        if ((WhereToPutIt > 15) && (WhereToPutIt < 31))
        {
           if (WhereToPutIt == 16){
               WinnerNumbers[0] = BValues[0]
               WinnerNumbers[1] = BValues[1]
               WinnerNumbers[2] = BValues[2]
               WinnerNumbers[3] = BValues[3]
               WinnerNumbers[4] = BValues[4]
           }
           if (WhereToPutIt == 17){
               WinnerNumbers[0] = IValues[0]
               WinnerNumbers[1] = IValues[1]
               WinnerNumbers[2] = IValues[2]
               WinnerNumbers[3] = IValues[3]
               WinnerNumbers[4] = IValues[4]
           }
           if (WhereToPutIt == 18){
               WinnerNumbers[0] = NValues[0]
               WinnerNumbers[1] = NValues[1]
               WinnerNumbers[2] = NValues[2]
               WinnerNumbers[3] = NValues[3]
               WinnerNumbers[4] = NValues[4]
           }
            if (WhereToPutIt == 19){
                WinnerNumbers[0] = GValues[0]
                WinnerNumbers[1] = GValues[1]
                WinnerNumbers[2] = GValues[2]
                WinnerNumbers[3] = GValues[3]
                WinnerNumbers[4] = GValues[4]
            }
            if (WhereToPutIt == 20){
                WinnerNumbers[0] = OValues[0]
                WinnerNumbers[1] = OValues[1]
                WinnerNumbers[2] = OValues[2]
                WinnerNumbers[3] = OValues[3]
                WinnerNumbers[4] = OValues[4]
            }
            
            
            if (WhereToPutIt == 21){
                WinnerNumbers[0] = BValues[5]
                WinnerNumbers[1] = BValues[6]
                WinnerNumbers[2] = BValues[7]
                WinnerNumbers[3] = BValues[8]
                WinnerNumbers[4] = BValues[9]
            }
            if (WhereToPutIt == 22){
                WinnerNumbers[0] = IValues[5]
                WinnerNumbers[1] = IValues[6]
                WinnerNumbers[2] = IValues[7]
                WinnerNumbers[3] = IValues[8]
                WinnerNumbers[4] = IValues[9]
            }
            if (WhereToPutIt == 23){
                WinnerNumbers[0] = NValues[5]
                WinnerNumbers[1] = NValues[6]
                WinnerNumbers[2] = NValues[7]
                WinnerNumbers[3] = NValues[8]
                WinnerNumbers[4] = NValues[9]
            }
             if (WhereToPutIt == 24){
                 WinnerNumbers[0] = GValues[5]
                 WinnerNumbers[1] = GValues[6]
                 WinnerNumbers[2] = GValues[7]
                 WinnerNumbers[3] = GValues[8]
                 WinnerNumbers[4] = GValues[9]
             }
             if (WhereToPutIt == 25){
                 WinnerNumbers[0] = OValues[5]
                 WinnerNumbers[1] = OValues[6]
                 WinnerNumbers[2] = OValues[7]
                 WinnerNumbers[3] = OValues[8]
                 WinnerNumbers[4] = OValues[9]
             }
            
            if (WhereToPutIt == 26){
                WinnerNumbers[0] = BValues[10]
                WinnerNumbers[1] = BValues[11]
                WinnerNumbers[2] = BValues[12]
                WinnerNumbers[3] = BValues[13]
                WinnerNumbers[4] = BValues[14]
            }
            if (WhereToPutIt == 27){
                WinnerNumbers[0] = IValues[10]
                WinnerNumbers[1] = IValues[11]
                WinnerNumbers[2] = IValues[12]
                WinnerNumbers[3] = IValues[13]
                WinnerNumbers[4] = IValues[14]
            }
            if (WhereToPutIt == 28){
                WinnerNumbers[0] = NValues[10]
                WinnerNumbers[1] = NValues[11]
                WinnerNumbers[2] = NValues[12]
                WinnerNumbers[3] = NValues[13]
                WinnerNumbers[4] = NValues[14]
            }
             if (WhereToPutIt == 29){
                 WinnerNumbers[0] = GValues[10]
                 WinnerNumbers[1] = GValues[11]
                 WinnerNumbers[2] = GValues[12]
                 WinnerNumbers[3] = GValues[13]
                 WinnerNumbers[4] = GValues[14]
             }
             if (WhereToPutIt == 30){
                 WinnerNumbers[0] = OValues[10]
                 WinnerNumbers[1] = OValues[11]
                 WinnerNumbers[2] = OValues[12]
                 WinnerNumbers[3] = OValues[13]
                 WinnerNumbers[4] = OValues[14]
             }
            
            var n = (WhereToPutIt-1) % 5
            
            
            // risk för dubbel ?
            
            // column B
            if (n == 0){
                for m in 0...5{
                    if (WinnerNumbers[0] == ValuesToPresentB[m]){
                        
                        var temp = ValuesToPresentB[6]
                   //     ValuesToPresentB[6] = WinnerNumbers[0]
                        
                        ValuesToPresentB[m] = temp
                        
                        HowMany += 1
                        break
                        
                    }
                }
                ValuesToPresentB[0] = WinnerNumbers[0]
                ValuesToPresentB[2] = WinnerNumbers[1]
                ValuesToPresentB[4] = WinnerNumbers[2]
                ValuesToPresentB[5] = WinnerNumbers[3]
                ValuesToPresentB[6] = WinnerNumbers[4]
                // check if 1 and 3 is duplicate winnernumber
                while testDoubleB1(){
                    
                }
                
                while testDoubleB3(){
                    
                }
            }
            
            
            // column I
            if (n == 1){
                for m in 0...5{
                    // all five must be here
                    if (WinnerNumbers[1] == ValuesToPresentI[m]){
                        var temp = ValuesToPresentI[6]
             //           ValuesToPresentB[6] = WinnerNumbers[0]
                        
                        ValuesToPresentB[m] = temp
                        
                        HowMany += 1
                        break
                    }
                }
                ValuesToPresentI[0] = WinnerNumbers[0]
                ValuesToPresentI[2] = WinnerNumbers[1]
                ValuesToPresentI[4] = WinnerNumbers[2]
                ValuesToPresentI[5] = WinnerNumbers[3]
                ValuesToPresentI[6] = WinnerNumbers[4]
                // check if 1 and 3 is duplicate winnernumber
                while testDoubleI1(){
                    
                }
                
                while testDoubleI3(){
                    
                }
            
            }
            
            // column N
            if (n == 2){
                for m in 0...5{
                    if (WinnerNumbers[2] == ValuesToPresentN[m]){
                        var temp = ValuesToPresentN[6]
             //           ValuesToPresentB[6] = WinnerNumbers[0]
                        
                        ValuesToPresentN[m] = temp
                        
                        HowMany += 1
                        break
                    }
                }
            
                ValuesToPresentN[0] = WinnerNumbers[0]
                ValuesToPresentN[2] = WinnerNumbers[1]
                ValuesToPresentN[4] = WinnerNumbers[2]
                ValuesToPresentN[5] = WinnerNumbers[3]
                ValuesToPresentN[6] = WinnerNumbers[4]
                
                // check if 1 and 3 is duplicate winnernumber
                while testDoubleN1(){
                    
                }
                
                while testDoubleN3(){
                    
                }
            }
            
            // column G
            if (n == 3){
                for m in 0...5{
                    if (WinnerNumbers[3] == ValuesToPresentG[m]){
                        var temp = ValuesToPresentG[6]
             //           ValuesToPresentB[6] = WinnerNumbers[0]
                        
                        ValuesToPresentG[m] = temp
                        
                        HowMany += 1
                        break
                    }
                }
                ValuesToPresentG[0] = WinnerNumbers[0]
                ValuesToPresentG[2] = WinnerNumbers[1]
                ValuesToPresentG[4] = WinnerNumbers[2]
                ValuesToPresentG[5] = WinnerNumbers[3]
                ValuesToPresentG[6] = WinnerNumbers[4]
                
                // check if 1 and 3 is duplicate winnernumber
                while testDoubleG1(){
                    
                }
                
                while testDoubleG3(){
                    
                }
            }
            
            // column O
            if (n == 4){
                for m in 0...5{
                    if (WinnerNumbers[4] == ValuesToPresentO[m]){
                        var temp = ValuesToPresentO[6]
             //           ValuesToPresentB[6] = WinnerNumbers[0]
                        
                        ValuesToPresentO[m] = temp
                        
                        HowMany += 1
                        break
                    }
                }
                ValuesToPresentO[0] = WinnerNumbers[0]
                ValuesToPresentO[2] = WinnerNumbers[1]
                ValuesToPresentO[4] = WinnerNumbers[2]
                ValuesToPresentO[5] = WinnerNumbers[3]
                ValuesToPresentO[6] = WinnerNumbers[4]
                
                // check if 1 and 3 is duplicate winnernumber
                while testDoubleO1(){
                    
                }
                
                while testDoubleO3(){
                    
                }
            }
            
            
            print("sä många ", String(HowMany))
            print("sä många ", String(HowMany))
            
        }
        
        // Diagonal
        if ((WhereToPutIt > 30) && (WhereToPutIt < 37)){
            // chart 1
            // X
            //   X
            //     X
            if (WhereToPutIt == 31){
                WinnerNumbers[0] = BValues[0]
                WinnerNumbers[1] = IValues[1]
                WinnerNumbers[2] = NValues[2]
                WinnerNumbers[3] = GValues[3]
                WinnerNumbers[4] = OValues[4]
                print("b-nummer ", String(WinnerNumbers[0]))
                print("i-nummer ", String(WinnerNumbers[1]))
                print("n-nummer ", String(WinnerNumbers[2]))
                print("g-nummer ", String(WinnerNumbers[3]))
                print("o-nummer ", String(WinnerNumbers[4]))
                print("o-nummer ", String(WinnerNumbers[4]))
                
            }
            // chart 1
            //     X
            //   X
            //  X
            if (WhereToPutIt == 32){
                WinnerNumbers[0] = BValues[4]
                WinnerNumbers[1] = IValues[3]
                WinnerNumbers[2] = NValues[2]
                WinnerNumbers[3] = GValues[1]
                WinnerNumbers[4] = OValues[0]
                print("b-nummer ", String(WinnerNumbers[0]))
                print("i-nummer ", String(WinnerNumbers[1]))
                print("n-nummer ", String(WinnerNumbers[2]))
                print("g-nummer ", String(WinnerNumbers[3]))
                print("o-nummer ", String(WinnerNumbers[4]))
                print("o-nummer ", String(WinnerNumbers[4]))
            }
            // chart 2
            // X
            //   X
            //     X
            if (WhereToPutIt == 33){
                WinnerNumbers[0] = BValues[5]
                WinnerNumbers[1] = IValues[6]
                WinnerNumbers[2] = NValues[7]
                WinnerNumbers[3] = GValues[8]
                WinnerNumbers[4] = OValues[9]
                print("b-nummer ", String(WinnerNumbers[0]))
                print("i-nummer ", String(WinnerNumbers[1]))
                print("n-nummer ", String(WinnerNumbers[2]))
                print("g-nummer ", String(WinnerNumbers[3]))
                print("o-nummer ", String(WinnerNumbers[4]))
                print("o-nummer ", String(WinnerNumbers[4]))
            }
            // chart 2
            //     X
            //   X
            //  X
            if (WhereToPutIt == 34){
                WinnerNumbers[0] = BValues[9]
                WinnerNumbers[1] = IValues[8]
                WinnerNumbers[2] = NValues[7]
                WinnerNumbers[3] = GValues[6]
                WinnerNumbers[4] = OValues[5]
                print("b-nummer ", String(WinnerNumbers[0]))
                print("i-nummer ", String(WinnerNumbers[1]))
                print("n-nummer ", String(WinnerNumbers[2]))
                print("g-nummer ", String(WinnerNumbers[3]))
                print("o-nummer ", String(WinnerNumbers[4]))
                print("o-nummer ", String(WinnerNumbers[4]))
            }
            // chart 3
            // X
            //   X
            //     X
            if (WhereToPutIt == 35){
                WinnerNumbers[0] = BValues[10]
                WinnerNumbers[1] = IValues[11]
                WinnerNumbers[2] = NValues[12]
                WinnerNumbers[3] = GValues[13]
                WinnerNumbers[4] = OValues[14]
                print("b-nummer ", String(WinnerNumbers[0]))
                print("i-nummer ", String(WinnerNumbers[1]))
                print("n-nummer ", String(WinnerNumbers[2]))
                print("g-nummer ", String(WinnerNumbers[3]))
                print("o-nummer ", String(WinnerNumbers[4]))
                print("o-nummer ", String(WinnerNumbers[4]))
            }
            // chart 3
            //     X
            //   X
            //  X
            if (WhereToPutIt == 36){
                WinnerNumbers[0] = BValues[14]
                WinnerNumbers[1] = IValues[13]
                WinnerNumbers[2] = NValues[12]
                WinnerNumbers[3] = GValues[11]
                WinnerNumbers[4] = OValues[10]
                print("b-nummer ", String(WinnerNumbers[0]))
                print("i-nummer ", String(WinnerNumbers[1]))
                print("n-nummer ", String(WinnerNumbers[2]))
                print("g-nummer ", String(WinnerNumbers[3]))
                print("o-nummer ", String(WinnerNumbers[4]))
                print("o-nummer ", String(WinnerNumbers[4]))
            }
            
            for m in 0...5{
                if (WinnerNumbers[0] == ValuesToPresentB[m]){
                    var temp = ValuesToPresentB[6]
         //           ValuesToPresentB[6] = WinnerNumbers[0]
                    
                    ValuesToPresentB[m] = temp
                    
                    HowMany += 1
                    break
                }
            }
            ValuesToPresentB[6] = WinnerNumbers[0]
            
            for m in 0...5{
                if (WinnerNumbers[1] == ValuesToPresentI[m]){
                    var temp = ValuesToPresentI[6]
         //           ValuesToPresentB[6] = WinnerNumbers[0]
                    
                    ValuesToPresentI[m] = temp
                    
                    HowMany += 1
                    break
                }
            }
            ValuesToPresentI[6] = WinnerNumbers[1]
            
            for m in 0...5{
                if (WinnerNumbers[2] == ValuesToPresentN[m]){
                    var temp = ValuesToPresentN[6]
         //           ValuesToPresentB[6] = WinnerNumbers[0]
                    
                    ValuesToPresentN[m] = temp
                    
                    HowMany += 1
                    break
                }
            }
            ValuesToPresentN[6] = WinnerNumbers[2]
            
            for m in 0...5{
                if (WinnerNumbers[3] == ValuesToPresentG[m]){
                    var temp = ValuesToPresentG[6]
         //           ValuesToPresentB[6] = WinnerNumbers[0]
                    
                    ValuesToPresentG[m] = temp
                    
                    HowMany += 1
                    break
                }
            }
            ValuesToPresentG[6] = WinnerNumbers[3]
            
            for m in 0...5{
                if (WinnerNumbers[4] == ValuesToPresentO[m]){
                    var temp = ValuesToPresentO[6]
         //           ValuesToPresentB[6] = WinnerNumbers[0]
                    
                    ValuesToPresentO[m] = temp
                    
                    HowMany += 1
                    break
                }
            }
            ValuesToPresentO[6] = WinnerNumbers[4]
            
            print("b-nummer ", String(ValuesToPresentB[6]))
            print("i-nummer ", String(ValuesToPresentI[6]))
            print("n-nummer ", String(ValuesToPresentN[6]))
            print("g-nummer ", String(ValuesToPresentG[6]))
            print("o-nummer ", String(ValuesToPresentO[6]))
            
            print("b-nummer ", String(ValuesToPresentO[6]))
            
            // The winning numbers must now be placed among the values that is to be presented
            
            
        }
    }
    
    // I have produced the b-values to present but I wanted a winner at position 11 or 12. To do that,
    // I put the winning numbers at position 0,2,4,5,6. position 1 and 3 must nor contain a winner number
    func testDoubleB1()->Bool{
        var New = Int.random(in: 1..<16)
        ValuesToPresentB[1] = New
        if ((ValuesToPresentB[1] == WinnerNumbers[0])
            || (ValuesToPresentB[1] == WinnerNumbers[1])
            || (ValuesToPresentB[1] == WinnerNumbers[2])
            || (ValuesToPresentB[1] == WinnerNumbers[3])
            || (ValuesToPresentB[1] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    // kanske att 1 och 3 har möjlighet att få samma värde ??
    func testDoubleB3()->Bool{
        var New = Int.random(in: 1..<16)
        ValuesToPresentB[3] = New
        if ((ValuesToPresentB[3] == WinnerNumbers[0])
            || (ValuesToPresentB[3] == WinnerNumbers[1])
            || (ValuesToPresentB[3] == WinnerNumbers[2])
            || (ValuesToPresentB[3] == WinnerNumbers[3])
            || (ValuesToPresentB[3] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleI1()->Bool{
        var New = Int.random(in: 16..<31)
        ValuesToPresentI[1] = New
        if ((ValuesToPresentI[1] == WinnerNumbers[0])
            || (ValuesToPresentI[1] == WinnerNumbers[1])
            || (ValuesToPresentI[1] == WinnerNumbers[2])
            || (ValuesToPresentI[1] == WinnerNumbers[3])
            || (ValuesToPresentI[1] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleI3()->Bool{
        var New = Int.random(in: 16..<31)
        ValuesToPresentI[3] = New
        if ((ValuesToPresentI[3] == WinnerNumbers[0])
            || (ValuesToPresentI[3] == WinnerNumbers[1])
            || (ValuesToPresentI[3] == WinnerNumbers[2])
            || (ValuesToPresentI[3] == WinnerNumbers[3])
            || (ValuesToPresentI[3] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    
    
    func testDoubleN1()->Bool{
        var New = Int.random(in: 31..<46)
        ValuesToPresentN[1] = New
        if ((ValuesToPresentN[1] == WinnerNumbers[0])
            || (ValuesToPresentN[1] == WinnerNumbers[1])
            || (ValuesToPresentN[1] == WinnerNumbers[2])
            || (ValuesToPresentN[1] == WinnerNumbers[3])
            || (ValuesToPresentN[1] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleN3()->Bool{
        var New = Int.random(in: 31..<46)
        ValuesToPresentN[3] = New
        if ((ValuesToPresentN[3] == WinnerNumbers[0])
            || (ValuesToPresentN[3] == WinnerNumbers[1])
            || (ValuesToPresentN[3] == WinnerNumbers[2])
            || (ValuesToPresentN[3] == WinnerNumbers[3])
            || (ValuesToPresentN[3] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleG1()->Bool{
        var New = Int.random(in: 46..<61)
        ValuesToPresentG[1] = New
        if ((ValuesToPresentG[1] == WinnerNumbers[0])
            || (ValuesToPresentG[1] == WinnerNumbers[1])
            || (ValuesToPresentG[1] == WinnerNumbers[2])
            || (ValuesToPresentG[1] == WinnerNumbers[3])
            || (ValuesToPresentG[1] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleG3()->Bool{
        var New = Int.random(in: 46..<61)
        ValuesToPresentG[3] = New
        if ((ValuesToPresentG[3] == WinnerNumbers[0])
            || (ValuesToPresentG[3] == WinnerNumbers[1])
            || (ValuesToPresentG[3] == WinnerNumbers[2])
            || (ValuesToPresentG[3] == WinnerNumbers[3])
            || (ValuesToPresentG[3] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleO1()->Bool{
        var New = Int.random(in: 61..<76)
        ValuesToPresentO[1] = New
        if ((ValuesToPresentO[1] == WinnerNumbers[0])
            || (ValuesToPresentO[1] == WinnerNumbers[1])
            || (ValuesToPresentO[1] == WinnerNumbers[2])
            || (ValuesToPresentO[1] == WinnerNumbers[3])
            || (ValuesToPresentO[1] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func testDoubleO3()->Bool{
        var New = Int.random(in: 61..<76)
        ValuesToPresentO[3] = New
        if ((ValuesToPresentO[3] == WinnerNumbers[0])
            || (ValuesToPresentO[3] == WinnerNumbers[1])
            || (ValuesToPresentO[3] == WinnerNumbers[2])
            || (ValuesToPresentO[3] == WinnerNumbers[3])
            || (ValuesToPresentO[3] == WinnerNumbers[4])){
            return true
        }
        else{
            return false
        }
    }
    
    func GetNewValuesPlayer2()->Bool {
        BValues2 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues2 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues2 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues2 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues2 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues2
        IValuesTemp = IValues2
        NValuesTemp = NValues2
        GValuesTemp = GValues2
        OValuesTemp = OValues2
        
        var FoundWinner = true
       
        
            if (CheckColumns()){
                return true
            }
            
            
            if (CheckRows()){
                return true
            }
        
        if (CheckDiagonal()){
            return true
        }
       
        return false
    }
    
    func GetNewValuesPlayer3()->Bool {
        BValues3 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues3 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues3 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues3 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues3 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues3
        IValuesTemp = IValues3
        NValuesTemp = NValues3
        GValuesTemp = GValues3
        OValuesTemp = OValues3
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer4()->Bool {
        BValues4 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues4 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues4 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues4 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues4 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues4
        IValuesTemp = IValues4
        NValuesTemp = NValues4
        GValuesTemp = GValues4
        OValuesTemp = OValues4
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer5()->Bool {
        BValues5 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues5 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues5 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues5 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues5 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues5
        IValuesTemp = IValues5
        NValuesTemp = NValues5
        GValuesTemp = GValues5
        OValuesTemp = OValues5
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer6()->Bool {
        BValues6 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues6 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues6 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues6 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues6 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues6
        IValuesTemp = IValues6
        NValuesTemp = NValues6
        GValuesTemp = GValues6
        OValuesTemp = OValues6
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer7()->Bool {
        BValues7 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues7 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues7 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues7 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues7 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues7
        IValuesTemp = IValues7
        NValuesTemp = NValues7
        GValuesTemp = GValues7
        OValuesTemp = OValues7
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer8()->Bool {
        BValues8 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues8 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues8 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues8 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues8 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues8
        IValuesTemp = IValues8
        NValuesTemp = NValues8
        GValuesTemp = GValues8
        OValuesTemp = OValues8
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer9()->Bool {
        BValues9 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues9 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues9 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues9 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues9 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues9
        IValuesTemp = IValues9
        NValuesTemp = NValues9
        GValuesTemp = GValues9
        OValuesTemp = OValues9
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer10()->Bool {
        BValues10 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues10 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues10 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues10 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues10 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues10
        IValuesTemp = IValues10
        NValuesTemp = NValues10
        GValuesTemp = GValues10
        OValuesTemp = OValues10
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
    
    func GetNewValuesPlayer11()->Bool {
        BValues11 = [1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15].shuffled()
        IValues11 = [16, 17, 18,19,20,21,22,23,24,25,26,27,28,29,30].shuffled()
        NValues11 = [31, 32, 33,34,35,36,37,38,39,40,41,42,43,44,45].shuffled()
        GValues11 = [46, 47, 48,49,50,51,52,53,54,55,56,57,58,59,60].shuffled()
        OValues11 = [61, 62, 63,64,65,66,67,68,69,70,71,72,73,74,75].shuffled()
        
        BValuesTemp = BValues11
        IValuesTemp = IValues11
        NValuesTemp = NValues11
        GValuesTemp = GValues11
        OValuesTemp = OValues11
        
        var FoundWinner = true
       
        if (CheckColumns()){
            return true
        }
        
        
        if (CheckRows()){
            return true
        }
        
        if (CheckDiagonal()){
            return true
        }
        
        return false
    }
   //     performSegue(withIdentifier: "WalkNumber", sender: "12")
    
    
    @IBAction func SeePlayer0Button(_ sender: Any) {
        performSegue(withIdentifier: "SeeBingoPlayer", sender: "0")
    }
    
    
    func CheckColumns()-> Bool{
        var Winner = false
        
        NumberInBChart1 = 0
        NumberInBChart2 = 0
        NumberInBChart3 = 0
        
        NumberInIChart1 = 0
        NumberInIChart2 = 0
        NumberInIChart3 = 0
        
        NumberInNChart1 = 0
        NumberInNChart2 = 0
        NumberInNChart3 = 0
        
        NumberInGChart1 = 0
        NumberInGChart2 = 0
        NumberInGChart3 = 0
        
        NumberInOChart1 = 0
        NumberInOChart2 = 0
        NumberInOChart3 = 0
        
        
  // det skall väl vara denna      ValuesToPresentB
        
        // Check all B, Chart1
        for i in 0...4{
            for m in 0...6{
                if (BValuesTemp[i] == ValuesToPresentB[m]){
                    NumberInBChart1 += 1
                }
            }
        }
        
        // Check all B, Chart2
        for i in 5...9{
            for m in 0...6{
                if (BValuesTemp[i] == ValuesToPresentB[m]){
                    NumberInBChart2 += 1
                }
            }
        }
        // Check all B, Chart3
        for i in 10...14{
            for m in 0...6{
                if (BValuesTemp[i] == ValuesToPresentB[m]){
                    NumberInBChart3 += 1
                }
            }
        }
        
        // Check all I, Chart1
        for i in 0...4{
            for m in 0...6{
                if (IValuesTemp[i] == ValuesToPresentI[m]){
                    NumberInIChart1 += 1
                }
            }
        }
        // Check all I, Chart2
        for i in 5...9{
            for m in 0...6{
                if (IValuesTemp[i] == ValuesToPresentI[m]){
                    NumberInIChart2 += 1
                }
            }
        }
        // Check all I, Chart3
        for i in 10...14{
            for m in 0...6{
                if (IValuesTemp[i] == ValuesToPresentI[m]){
                    NumberInIChart3 += 1
                }
            }
        }
        
        // Check all N, Chart1
        for i in 0...4{
            for m in 0...6{
                if (NValuesTemp[i] == ValuesToPresentN[m]){
                    NumberInNChart1 += 1
                }
            }
        }
        // Check all N, Chart2
        for i in 5...9{
            for m in 0...6{
                if (NValuesTemp[i] == ValuesToPresentN[m]){
                    NumberInNChart2 += 1
                }
            }
        }
        // Check all N, Chart3
        for i in 10...14{
            for m in 0...6{
                if (NValuesTemp[i] == ValuesToPresentN[m]){
                    NumberInNChart3 += 1
                }
            }
        }
        // Check all G, Chart1
        for i in 0...4{
            for m in 0...6{
                if (GValuesTemp[i] == ValuesToPresentG[m]){
                    NumberInGChart1 += 1
                }
            }
        }
        // Check all G, Chart2
        for i in 5...9{
            for m in 0...6{
                if (GValuesTemp[i] == ValuesToPresentG[m]){
                    NumberInGChart2 += 1
                }
            }
        }
        // Check all G, Chart3
        for i in 10...14{
            for m in 0...6{
                if (GValuesTemp[i] == ValuesToPresentG[m]){
                    NumberInGChart3 += 1
                }
            }
        }
        // Check all O, Chart1
        for i in 0...4{
            for m in 0...6{
                if (OValuesTemp[i] == ValuesToPresentO[m]){
                    NumberInOChart1 += 1
                }
            }
        }
        // Check all O, Chart2
        for i in 5...9{
            for m in 0...6{
                if (OValuesTemp[i] == ValuesToPresentO[m]){
                    NumberInOChart2 += 1
                }
            }
        }
        // Check all O, Chart3
        for i in 10...14{
            for m in 0...6{
                if (OValuesTemp[i] == ValuesToPresentO[m]){
                    NumberInOChart3 += 1
                }
            }
        }
        
        
        if ((NumberInBChart1 == 5) || (NumberInBChart2 == 5) || (NumberInBChart3 == 5)){
            print("chart1 ", String(NumberInBChart1))
            print("chart2 ", String(NumberInBChart2))
            print("chart3 ", String(NumberInBChart3))
            
            for l in 0...14{
                print("värde 0 ", String(BValuesTemp[l]))
            }
           
            
            Winner = true
        }
        
        if ((NumberInIChart1 == 5) || (NumberInIChart2 == 5) || (NumberInIChart3 == 5)){
            
            print("chart1 ", String(NumberInIChart1))
            print("chart2 ", String(NumberInIChart2))
            print("chart3 ", String(NumberInIChart3))
            
            for l in 0...14{
                print("värde 0 ", String(IValuesTemp[l]))
            }
            
            Winner = true
        }
        
        if ((NumberInNChart1 == 5) || (NumberInNChart2 == 5) || (NumberInNChart3 == 5)){
            
            print("chart1 ", String(NumberInNChart1))
            print("chart2 ", String(NumberInNChart2))
            print("chart3 ", String(NumberInNChart3))
            
            for l in 0...14{
                print("värde 0 ", String(NValuesTemp[l]))
            }
            Winner = true
        }
        
        if ((NumberInGChart1 == 5) || (NumberInGChart2 == 5) || (NumberInGChart3 == 5)){
            print("chart1 ", String(NumberInGChart1))
            print("chart2 ", String(NumberInGChart2))
            print("chart3 ", String(NumberInGChart3))
            
            for l in 0...14{
                print("värde 0 ", String(GValuesTemp[l]))
            }
        
            Winner = true
        }
        if ((NumberInOChart1 == 5) || (NumberInOChart2 == 5) || (NumberInOChart3 == 5)){
            
            print("chart1 ", String(NumberInOChart1))
            print("chart2 ", String(NumberInOChart2))
            print("chart3 ", String(NumberInOChart3))
            
            for l in 0...14{
                print("värde 0 ", String(OValuesTemp[l]))
            }
       
            Winner = true
        }
        
      
        
        if (Winner){
            return true
        }else{
            return false
        }
    }
    
    func CheckRows()->Bool{
        var NumberInRow1B = 0
        var NumberInRow1I = 0
        var NumberInRow1N = 0
        var NumberInRow1G = 0
        var NumberInRow1O = 0
        
        var SumNumberInRow = 0
        
        var Winner = false
        
        // Check all rows, Chart1
        for i in 0...14{
            NumberInRow1B = 0
            NumberInRow1I = 0
            NumberInRow1N = 0
            NumberInRow1G = 0
            NumberInRow1O = 0
            
            for m in 0...6{
                if (BValuesTemp[i] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[i] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[i] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[i] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[i] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
 
        }
        return false
    }
    
    func CheckDiagonal()->Bool{
        var NumberInRow1B = 0
        var NumberInRow1I = 0
        var NumberInRow1N = 0
        var NumberInRow1G = 0
        var NumberInRow1O = 0
        
        var SumNumberInRow = 0
        
        var Winner = false
        
        // Check all rows, Chart1
        for i in 0...14{
            NumberInRow1B = 0
            NumberInRow1I = 0
            NumberInRow1N = 0
            NumberInRow1G = 0
            NumberInRow1O = 0
            
            
            
          // chart 1
            for m in 0...6{
                if (BValuesTemp[0] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[1] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[2] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[3] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[4] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
            
            
            for m in 0...6{
                if (BValuesTemp[4] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[3] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[2] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[1] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[0] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
            
            // chart 2
            for m in 0...6{
                if (BValuesTemp[5] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[6] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[7] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[8] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[9] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
            
            for m in 0...6{
                if (BValuesTemp[9] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[8] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[7] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[6] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[5] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
            
            // chart 3
            
            for m in 0...6{
                if (BValuesTemp[10] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[11] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[12] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[13] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[14] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
            
            for m in 0...6{
                if (BValuesTemp[14] == ValuesToPresentB[m]){
                    NumberInRow1B = 1
                }
            }
            for m in 0...6{
                if (IValuesTemp[13] == ValuesToPresentI[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (NValuesTemp[12] == ValuesToPresentN[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (GValuesTemp[11] == ValuesToPresentG[m]){
                    NumberInRow1B += 1
                }
            }
            for m in 0...6{
                if (OValuesTemp[10] == ValuesToPresentO[m]){
                    NumberInRow1B += 1
                }
            }
            
            if (NumberInRow1B == 5){
                return true
            }
            
        }
        return false
    }
    
    func getDate(){
        // get the current date and time
        let currentDateTime = Date()

        // get the user's calendar
        let userCalendar = Calendar.current

        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]

        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)

        // now the components are available
        dateTimeComponents.year   // 2016
        dateTimeComponents.month  // 10
        dateTimeComponents.day    // 8
        dateTimeComponents.hour   // 22
        dateTimeComponents.minute // 42
        dateTimeComponents.second // 17
        
        print("year ", String(dateTimeComponents.year!))
        print("month ", String(dateTimeComponents.month!))
        print("day ", String(dateTimeComponents.day!))
        print("day ", String(dateTimeComponents.day!))
        
        Year = String(dateTimeComponents.year!)
        Month = String(dateTimeComponents.month!)
        Day = String(dateTimeComponents.day!)
        
 
    }
    
    func checkIfWeShouldErase(){
        self.ref.child("BingoName").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                    print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                    return;
                }
                 print(snapshot)
            if (snapshot != nil)
                {
                var j = 0
                    for quizNameChild in snapshot.children
                    {
                        let quizNameChildSnap = quizNameChild as! DataSnapshot
                        let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                        
                        print("", snapshot.key)
                        print("", snapshot.key)
                       
                        print("", quizNameChildSnap.key)
                        print("", quizNameChildSnap.key)
                        
                        
                        if (quizNameChildSnap.key != "BingoPassword"){
                        
                            ReadYear = quizNameChildInfo["Year"]!
                            ReadDay = quizNameChildInfo["Day"]!
                            ReadMonth = quizNameChildInfo["Month"]!
                            
                            
                            BingoNameErase = quizNameChildInfo["name"]!
                            ChildByAutoErase = quizNameChildInfo["ChildByAuto"]!
                                    
                            print("year ", ReadYear)
                            print("day ", ReadDay)
                            print("month ", ReadMonth)
                            
                            print("month ", ReadMonth)
                            
                            let ReadYearInt = (ReadYear as NSString).intValue
                            let ReadMonthInt = (ReadMonth as NSString).intValue
                            let ReadDayInt = (ReadDay as NSString).intValue
                            
                            let TodayYearInt = (Year as NSString).intValue
                            let TodayMonthInt = (Month as NSString).intValue
                            let TodayDayInt = (Day as NSString).intValue
                            
                            var erase = false
                            if (TodayYearInt > ReadYearInt){
                                print("a")
                                erase = true
                            }
                            if (TodayMonthInt > ReadMonthInt){
                                print("b")
                                erase = true
                            }
                            if (TodayDayInt > ReadDayInt){
                                print("c")
                                erase = true
                            }
                            
                            if (erase){
                                removeFromFirebase(child1: "BingoName", child2: ChildByAutoErase)
                                removeFromFirebase(child1: "BingoPlayerWinner", child2: BingoNameErase)
                                removeFromFirebase(child1: "BingoPlayersCharts", child2: BingoNameErase)
                                removeFromFirebase(child1: "BingoPlayersValuesToPresent", child2: BingoNameErase)
                            }
                            
                            
                        }
                        
                    }
                
               
              /*      let secondsFloat = (ReadSeconds as NSString).floatValue
                    
                    if ((Seconds - secondsFloat) > 10 ){
                        print("snapshot == nil")
                    }*/
                
                    
                
                }
                else
                {
                    print("snapshot == nil")
                }
                DispatchQueue.main.async
                {
                    
                }
            })
        
        
    }
    
   /* func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {*/
    
    func checkBingoGroupName(name: String) -> Bool
    {
        var Exists = false
        self.ref.child("BingoName").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                    print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                    return;
                }
                 print(snapshot)
            if (snapshot != nil)
                {
                var j = 0
                    for quizNameChild in snapshot.children
                    {
                        let quizNameChildSnap = quizNameChild as! DataSnapshot
                        let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                        
                        print("", snapshot.key)
                        print("", snapshot.key)
                       
                        print("", quizNameChildSnap.key)
                        print("", quizNameChildSnap.key)
                        
                        
                        if (quizNameChildSnap.key != "BingoPassword"){
                        
                            if (quizNameChildInfo["Name"] == name){
                                Exists = true
                                return;
                            }
                            
                        }
                        
                    }
                
               
              /*      let secondsFloat = (ReadSeconds as NSString).floatValue
                    
                    if ((Seconds - secondsFloat) > 10 ){
                        print("snapshot == nil")
                    }*/
                
                    
                
                }
                else
                {
                    print("snapshot == nil")
                }
                DispatchQueue.main.async
                {
                    
                }
            })
        
        return Exists
    }
    
    
    
    func removeFromFirebase(child1: String, child2: String)
    {
        let ref = self.ref.child(child1).child(child2)
        print(child1)
        print(child2)
        print(child2)
// OK, cannot remove if we are not logged in as jorgen_raby@hotmail.com or jorgen@icloud.com or bingou.icloud.com or bingoc@icloud.com
            ref.removeValue { error, _ in

                print(error)
            }
        
      
        
    }
    
    

}
