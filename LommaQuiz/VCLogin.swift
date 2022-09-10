//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase
import FirebaseAuth

/*
class Food {
      var name: String
      var category: String
    }

struct Group {
      var title: String
      var foods: [Food]

    mutating func add(food: Food) {
      foods.append(food)
    }

var groups = [Group]()*/

//var myArray = [Int](count: 5, repeatedValue: 0)
//var myDoubles = [Int](count: 5, repeatedValue: 2)

struct Bingo1 {
    var A : Int
    var B : Int
    var C : Int
    var D : Int
    var E : Int
    var F : Int
    var G : Int
    var H : Int
    var I : Int
    var J : Int
    var K : Int
    var L : Int
    var M : Int
    var N : Int
    var O : Int
//    var P : Int
}

struct BingoPlayer {
    var B : Bingo1
    var I : Bingo1
    var N : Bingo1
    var G : Bingo1
    var O : Bingo1
}

struct BingoPresentValues {
    var B : Bingo1
    var I : Bingo1
    var N : Bingo1
    var G : Bingo1
    var O : Bingo1
}

var loggedInHighest = false
var loggedInToWrite = false
var loggedInToWalkSombodysSpecial = false
var questUser = ""
var questCreator = ""
var masterLoggedIn = false
var authPassedForUser = false
var foundBingoPassword = false
var BingoName = ""
var ChildByAuto = ""
var PersonsLoggedIn = ""
var youAreplayer = 0
var questUserBingo = ""


var BValuesRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var IValuesRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var NValuesRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var GValuesRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var OValuesRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

var ValuesToPresentBRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var ValuesToPresentIRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var ValuesToPresentNRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var ValuesToPresentGRead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var ValuesToPresentORead = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

var ValuesToPopUp = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

let BingoValues = [BValuesRead, IValuesRead, NValuesRead, GValuesRead, OValuesRead]
let BingoValuesToPresent = [ValuesToPresentBRead, ValuesToPresentIRead, ValuesToPresentNRead, ValuesToPresentGRead, ValuesToPresentORead]



class VCLogin: UIViewController {
    @IBOutlet weak var writtenPassword: UITextField!
    
    @IBOutlet weak var writtenPasswordBingo: UITextField!
    @IBOutlet weak var showIfLoginLogout: UITextField!
    @IBOutlet weak var questionCreator: UITextField!
    @IBOutlet weak var questionUser: UITextField!
    @IBOutlet weak var saveNewQuestionWriter: UIButton!
    @IBOutlet weak var permissionToWrite: UITextField!
    @IBOutlet weak var textToExplain: UITextView!
    @IBOutlet weak var textViewText: UITextView!
    var ref: DatabaseReference!
    var quizCreatorList = [String]()
    var quizUserList = [String]()
    var permissionToWriteList = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(VCWriteQuestion.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(VCWriteQuestion.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
     
        ref = Database.database().reference()
        
        getLogins()
        getLoginText()
        makeInvisable()
        
        showIfLoginLogout.text = "Du är inte inloggad"
        if (loggedInToWalkSombodysSpecial){
            showIfLoginLogout.text = "Du är inloggad på rundan"
        }
        if (loggedInToWrite){
            if (loggedInHighest){
                makeVisibleHigh()
                showIfLoginLogout.text = "Du är inloggad med skrivrättighet"
            }
            else{
                logOut("")
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
   /* func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }*/
    
    @IBAction func returnWritePassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func endWritingBingoName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // gets rid of the keyboard
    @IBAction func returnWriteBingoName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    func makeInvisable(){
        questionCreator.isEnabled = false
        questionUser.isEnabled = false
        saveNewQuestionWriter.isEnabled = false
        permissionToWrite.isEnabled = false
        questionCreator.alpha = 0
        questionUser.alpha = 0
        saveNewQuestionWriter.alpha = 0
        permissionToWrite.alpha = 0
        textToExplain.isHidden = true
    }
    
    func makeVisibleHigh(){
        loggedInToWrite = true
        showIfLoginLogout.text = "Du är inloggad"
        questionCreator.isEnabled = true
        questionUser.isEnabled = true
        questionCreator.alpha = 1
        questionUser.alpha = 1
        saveNewQuestionWriter.isEnabled = true
        saveNewQuestionWriter.alpha = 1
        permissionToWrite.isEnabled = true
        permissionToWrite.alpha = 1
    }
    
    /*
     
     let quizNameInfo = quizNameChildSnap.value as! [String : String]

     self.quizUserlist.append(quizNameInfo["user"]!)
     
     */
    
    // logga ut skall inte finnas på bingorundan
    
    
    func CheckIfBingoPassword()->Bool {
        foundBingoPassword = false
        
        
        
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
                        
                        
                        if (quizNameChildInfo["Password"] == writtenPasswordBingo.text){
                                var countExpected = String(quizNameChildInfo["CountExpected"]!)
                                var countLoggedIn = String(quizNameChildInfo["PersonsLoggedIn"]!)
                                
                                let countExpectedInt = (countExpected as NSString).integerValue
                                let countLoggedInInt = (countLoggedIn as NSString).integerValue
                              
                                var selectedWinner = String(quizNameChildInfo["SelectedWinner"]!)
                                let selectedWinnerInt = (selectedWinner as NSString).integerValue
                            
                                // check if maximum participants have been reached
                                if (countExpected == countLoggedIn){
                                    showIfLoginLogout.text = "Max antal deltagare har redan loggat in"
                                    return;
                                }
                            
                                foundBingoPassword = true
                                BingoName = quizNameChildInfo["name"]!
                                ChildByAuto = quizNameChildInfo["ChildByAuto"]!
                            
                                if (quizNameChildInfo["ConnectToWalk"]! != ""){
                                        questUserBingo = quizNameChildInfo["ConnectToWalk"]!
                                        takeAwayButtonToChooseRunda = true
                                }else{
                                    takeAwayButtonToChooseRunda = false
                                }
                            
                            
                                
                                
                                self.ref.child("BingoPlayersValuesToPresent").child(BingoName).getData(completion:{ [self]error, snapshot in
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
                                           //     let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                                                let quizNameChildInfo = quizNameChildSnap.value as! [Int]
                                                
                                                switch (j){
                                                case 1:
                                                    ValuesToPresentIRead = quizNameChildInfo
                                              //      print("IValues", IValuesRead[0])
                                                case 2:
                                                    ValuesToPresentNRead = quizNameChildInfo
                                                case 3:
                                                    ValuesToPresentGRead = quizNameChildInfo
                                                case 4:
                                                    ValuesToPresentORead = quizNameChildInfo
                                                  //  print("OValues", OValuesRead[0])
                                                default:
                                                    ValuesToPresentBRead = quizNameChildInfo
                                                  //  print("BValues", BValuesRead[0])
                                                }
                                                j += 1
                                           
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
                                
                                    // read what player you are
                                    self.ref.child("BingoName").child(ChildByAuto).child("PersonsLoggedIn").getData(completion:{ [self]error, snapshot in
                                            guard error == nil else
                                            {
                                                print(error!.localizedDescription) // När jag inte har datum så trodde jag att vi skulle hamna här.
                                                return;
                                            }
                                             print(snapshot)
                                            if (snapshot != nil)
                                            {
                                                PersonsLoggedIn = snapshot.value as! String
                                                youAreplayer = Int(PersonsLoggedIn)!
                                                youAreplayer += 1
                                                
                                                // sätt maxlängd på sträng
                                                showIfLoginLogout.text = "Du är inloggad på " + BingoName + " som deltagare nr " + String(youAreplayer)
                                                // from VCBingoSmall, I think I have to reset it to be sure
                                                waitToTheLastToShowLooser = false
                                                WinnerIs = ""
                                                
                                                // here we know that values to present have been read
                                                getTheValuesToPopUp()
                                                
                                                var PointToPlayer = youAreplayer + 1
                                                
                                                if (selectedWinnerInt == youAreplayer){
                                                    print("vinnaren har loggat in")
                                                    PointToPlayer = 1
                                                }
                                                
                                                self.ref.child("BingoName").child(ChildByAuto).child("PersonsLoggedIn").setValue(String(youAreplayer))
                                                
                                                
                                                // the winning numbers are placed at "BingoPlayersCharts" "name" "Player 1" so everyone points at Player 2 and over and the winner is pointed to Player 1
                                                
                                                // youAreplayer
                                                
                                                self.ref.child("BingoPlayersCharts").child(BingoName).child("Player " + String(PointToPlayer)).getData(completion:{ [self]error,
                                                snapshot in
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
                                                           //     let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                                                                let quizNameChildInfo = quizNameChildSnap.value as! [Int]
                                                                
                                                                switch (j){
                                                                case 1:
                                                                    IValuesRead = quizNameChildInfo
                                                                    print("IValues", IValuesRead[0])
                                                                case 2:
                                                                    NValuesRead = quizNameChildInfo
                                                                case 3:
                                                                    GValuesRead = quizNameChildInfo
                                                                case 4:
                                                                    OValuesRead = quizNameChildInfo
                                                                    print("OValues", OValuesRead[0])
                                                                default:
                                                                    BValuesRead = quizNameChildInfo
                                                                    print("BValues", BValuesRead[0])
                                                                }
                                                                j += 1
                                                           
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
                                            else
                                            {
                                                print("snapshot == nil")
                                            }
                                            DispatchQueue.main.async
                                            {
                                                
                                            }
                                        })
                          //      } // if (countExpected > countLoggedIn)
                  
                        }
                    
     
                        
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
        
        // kan vara att svar inte kommit utan måste utvärderas lite senare
        
        // kan vara att om max antal redan var inloggade så bör vi kanske returnera false ??
        return foundBingoPassword
    }
    
    // I do this because when a user goes a bingo-walk, the program writes to database
    @IBAction func startedWriteBingoLogin(_ sender: UITextField) {
   
  //      VCAuth().forceBingoLogin(email: "bingou@icloud.com", password: "bingou")
        // if it was not a correct password for bingo, force logout
    }
    
    
    
    
    @IBAction func endedWriteBingoLogin(_ sender: UITextField) {
        VCAuth().forceBingoLogin(email: "bingou@icloud.com", password: "bingou")
    }
    
    
    func getTheValuesToPopUp(){
        var j = 0
        for n in 0...6{
            ValuesToPopUp[j] = ValuesToPresentBRead[n]
            ValuesToPopUp[j+1] = ValuesToPresentIRead[n]
            ValuesToPopUp[j+2] = ValuesToPresentNRead[n]
            ValuesToPopUp[j+3] = ValuesToPresentGRead[n]
            ValuesToPopUp[j+4] = ValuesToPresentORead[n]
            j += 5
        }
    }
    
    @IBAction func logIn(_ sender: Any) {
        
            if (BingoName == ""){
                if (CheckIfBingoPassword()){
                    
                }
            }
        
            var login = quizCreatorList.contains(where: writtenPassword.text!.contains)
            
            var isItHighestPriority = false
            var foundSomeoneToLogin = 0
            
            if (Auth.auth().currentUser?.email == "jorgen_raby@hotmail.com"){
                print("hej")
                masterLoggedIn = true
            }
            if (Auth.auth().currentUser?.email == "jorgen@icloud.com"){
                print("hej")
                authPassedForUser = true
            }
   /*     if (Auth.auth().currentUser?.email == "jorgen_raby@icloud.com"){
            print("hej")
            authPassedForUser = true
        }*/
     
            if let FoundSomeOne = quizCreatorList.firstIndex(of: writtenPassword.text!){
                foundSomeoneToLogin = FoundSomeOne
                
                isItHighestPriority = (quizUserList[foundSomeoneToLogin] == "adminmaster")
                
                if (!isItHighestPriority){
                    loggedInToWrite = (permissionToWriteList[foundSomeoneToLogin] == "Ja")
                }
                
                if (isItHighestPriority && (!masterLoggedIn)){
                    isItHighestPriority = false
                    showIfLoginLogout.text = "Logga in för skrivrättighet"
                }
                
                if (loggedInToWrite && (!authPassedForUser)){
                    loggedInToWrite = false
                    showIfLoginLogout.text = "Logga in för skrivrättighet"
                }
                
                // Only to make the keyboard disappear
                writtenPassword.isEnabled = false
                writtenPassword.isEnabled = true
            }
            
            if (isItHighestPriority){
                makeVisibleHigh()
                loggedInHighest = true
                self.view.frame.origin.y = 0 - 200
            }
            
            // om man kommer åter så bör jag ta hand om detta
            if (login){
                if (loggedInToWrite){
                    showIfLoginLogout.text = "Du är inloggad med skrivrättighet"
                    questUser = quizUserList[foundSomeoneToLogin]
                    questCreator = quizCreatorList[foundSomeoneToLogin]
                    if (!isItHighestPriority){
                   //     textToExplain.text.append(" " + quizUserList[foundSomeoneToLogin])
                        textToExplain.text = "Användare av din runda loggar in med: " + quizUserList[foundSomeoneToLogin]
                        textToExplain.isHidden = false
                    }
                }
                else{
                    showIfLoginLogout.text = "Du är inloggad utan skrivrättighet"
                    questUser = quizUserList[foundSomeoneToLogin]
                    loggedInToWalkSombodysSpecial = true
                }
            }
        
       
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        loggedInToWrite = false
        showIfLoginLogout.text = "Du är inte inloggad"
        writtenPassword.text = ""
        makeInvisable()
        questUser = ""
        loggedInToWalkSombodysSpecial = false
        loggedInHighest = false
        
        questUserBingo = ""
        
        BingoName = ""
        self.view.frame.origin.y = 0
    }
    
   
    
    @IBAction func SaveNewQuestionWriter(_ sender: Any) {
        self.ref.child("QuizWalks").child("Login").childByAutoId().setValue(["questionCreator" : questionCreator.text!, "questionUser" : questionUser.text!, "writePermission" : permissionToWrite.text!, "haveQuestions" : "Nej"])
        // I save a new User for this writer
        self.ref.child("QuizWalks").child("Login").childByAutoId().setValue(["questionCreator" : questionUser.text!, "questionUser" : questionUser.text!, "writePermission" : "Nej", "haveQuestions" : "Nej"])
        
        // I have to do this to get it to save correct in 
        questUser = questionUser.text!
        loggedInHighest = false
        var userType = VCSetCoords().CreateEmptySave()
        loggedInHighest = true
        questUser = ""
   //     var testa = "Någon eller några frågor missades tyvärr. Jag gissar att det handlar om att appen inte har tillåtits att köra i bakgrunden. När du inte är aktiv på telefonen under en viss tid, då går appen i bakgrundsläge. Gå in på inställningar, leta upp Frågerundan. Under Plats finner du TILLÅT ÅTKOMST TILL PLATSINFO. Där kan du markera Alltid. Om appen missade frågor trots att Alltid var ikryssad, då vill jag gärna veta det och skicka gärna ett meddelande till jorgen_raby@icloud.com. Du kan bara läsa frågor och svar nu på de frågor som missades. mvh Jörgen";
        
        getLogins()
        
  //      self.ref.child("QuizWalks").child("TestFlag").child("TestFlag").setValue("Hej")
   //     self.ref.child("QuizWalks").child("VidMissadeFrågorText").child("VidMissadeFrågorText").setValue(testa)
    }
    
    // vet inte om jag skall sätta master och auth
    func isBingoCreateLoggedIn()->Bool{
        if (Auth.auth().currentUser?.email == "jorgen_raby@hotmail.com"){
            print("hej")
            masterLoggedIn = true
            return true
        }
        if (Auth.auth().currentUser?.email == "jorgen@icloud.com"){
            print("hej")
            authPassedForUser = true
            return true
        }
        // creator of bingo is logged in
        if (Auth.auth().currentUser?.email == "bingoc@icloud.com"){
            print("hej")
            authPassedForUser = true
            return true
        }
        // denna skall nog bort sen
    /*    if (Auth.auth().currentUser?.email == "bingo@icloud.com"){
            print("hej")
            authPassedForUser = true
            return true
        }*/
        return false
    }
    
    func isBingoUserLoggedIn()->Bool{
       
        // user of bingo is logged in
        if (Auth.auth().currentUser?.email == "bingou@icloud.com"){
            return true
        }
 
        return false
    }
    
    func isRundacLoggedIn()->Bool{
       
        // user of bingo is logged in
        if (Auth.auth().currentUser?.email == "rundac@icloud.com"){
            return true
        }
 
        return false
    }
    
    func getLogins() {
        self.ref.child("QuizWalks").child("Login").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                print(error!.localizedDescription)
                return;
            }

            if (snapshot != nil)
                {
                    for loginChild in snapshot.children
                    {
                        let loginChildSnap = loginChild as! DataSnapshot
                        let LoginInfo = loginChildSnap.value as! [String : String]
                        // jag kan inte göra append varje gång, rensa
                        self.quizCreatorList.append(LoginInfo["questionCreator"]!)
                        self.quizUserList.append(LoginInfo["questionUser"]!)
                        self.permissionToWriteList.append(LoginInfo["writePermission"]!)
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
        })
    }
    func getLoginText() {
  
        self.ref.child("QuizWalks").child("LoginText").getData(completion:{ [self]error, snapshot in
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
                        
                        if (loginChildSnap.key == "LoginText"){
                            let LoginInfo = loginChildSnap.value as! String
                            print(LoginInfo)
                            textViewText.text = LoginInfo
                        }
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
        })
    }
    
}
