//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

class VCWriteQuestion: UIViewController, UITextViewDelegate {
    var infotext = ""
    var questionnumber = "1"
    var questionnumberInt : Int = 1 // chansar
    var correctAnswer : Int = 0
    
    @IBOutlet weak var quizWalkName: UITextField!
    @IBOutlet weak var LabelQuestNbr: UILabel!
    @IBOutlet weak var MyTextView: UITextView!
    @IBOutlet weak var Answer1TextView: UITextView!
    @IBOutlet weak var Answer2TextView: UITextView!
    @IBOutlet weak var Answer3TextView: UITextView!
    @IBOutlet weak var ButtonAnswer1: UIButton!
    @IBOutlet weak var ButtonAnswerX: UIButton!
    @IBOutlet weak var ButtonAnswer2: UIButton!
    @IBOutlet weak var ButtonSound: UIButton!
    
    var ref: DatabaseReference!
    var quizWalkName2 : String = ""
    var questions = [String]()
    var answers1 = [String]()
    var answers2 = [String]()
    var answers3 = [String]()
    var correctanswers = [String]()
    var quiznamelist = [String]()
    
    var FoundDate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(VCWriteQuestion.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(VCWriteQuestion.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
 
        quizWalkName.text = quizWalkName2
        
        ref = Database.database().reference()
        
        self.MyTextView.delegate = self
        self.Answer1TextView.delegate = self
        self.Answer2TextView.delegate = self
        self.Answer3TextView.delegate = self
        ButtonSound.backgroundColor = .white
        if (!loggedInHighest){
            ButtonSound.isEnabled = false
            ButtonSound.alpha = 0
        }
    
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
            searchString = quizWalkName2

            var result = quiznamelist.contains(where: searchString.contains)
 
                DispatchQueue.main.async
                {
                    if (!result){
                        self.CreateEmptySave()
                        result = true
                    }
                }
            })
       
        ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).getData(completion:{error, snapshot in
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
                        self.correctanswers.append(quizNameInfo["Correct Answer"]!)
                        self.FoundDate = 1
                    }
                    
                }
                else
                {
                    print("snapshot == nil")
                }
                DispatchQueue.main.async
                {
                    if (self.FoundDate == 1){
                        self.loadQuestionAndAnswers()
                    }
                }
            })
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == Answer1TextView{
        //    self.view.frame.origin.y = 0 - keyboardSize.height
            self.view.frame.origin.y = 0 - 250
        }
        if textView == Answer2TextView{
        //    self.view.frame.origin.y = 0 - keyboardSize.height
            self.view.frame.origin.y = 0 - 300
        }
        if textView == Answer3TextView{
        //    self.view.frame.origin.y = 0 - keyboardSize.height
            self.view.frame.origin.y = 0 - 350
        }
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
    
    // hur kunde koden under funka?
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func loadQuestionAndAnswers() {
        LabelQuestNbr.text?.append(questionnumber)
        questionnumberInt = Int(questionnumber)!
        
        MyTextView.text = questions[questionnumberInt-1]
    
        Answer1TextView.text = answers1[questionnumberInt-1]
        Answer2TextView.text = answers2[questionnumberInt-1]
        Answer3TextView.text = answers3[questionnumberInt-1]
        if (correctanswers[questionnumberInt-1] == "1"){
            ButtonAnswer1.backgroundColor = .green
            ButtonAnswerX.backgroundColor = .white
            ButtonAnswer2.backgroundColor = .white
            correctAnswer = 1
        }
        if (correctanswers[questionnumberInt-1] == "2"){
            ButtonAnswerX.backgroundColor = .green
            ButtonAnswer1.backgroundColor = .white
            ButtonAnswer2.backgroundColor = .white
            correctAnswer = 2
        }
        if (correctanswers[questionnumberInt-1] == "3"){
            ButtonAnswer2.backgroundColor = .green
            ButtonAnswerX.backgroundColor = .white
            ButtonAnswer1.backgroundColor = .white
            correctAnswer = 3
        }
    }
    
    
    @IBAction func ButtonSoundClick(_ sender: Any) {
        if (ButtonSound.backgroundColor == .white){
            ButtonSound.backgroundColor = .green
        }
        else{
            ButtonSound.backgroundColor = .white
        }
    }
    
    @IBAction func ButtonSave(_ sender: Any) {
        for i in 1 ... 12{
            var qstring = "Fråga " + String(i)
            
            var string = "Fråga "
            string.append(Character(UnicodeScalar(64+i)!))
            
            if (questionnumberInt == i){
                self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Fråga").setValue(MyTextView.text)
                self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Answer 1").setValue(Answer1TextView.text)
                self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Answer 2").setValue(Answer2TextView.text)
                self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Answer 3").setValue(Answer3TextView.text)
               
                if (ButtonSound.backgroundColor == .white){
                    self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("URLString").setValue("")
                }
                else{
                    self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("URLString").setValue("flicka talar")
                }
                             
                if (correctAnswer == 1){
                    self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Correct Answer").setValue("1")}
                if (correctAnswer == 2){
                    self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Correct Answer").setValue("2")}
                if (correctAnswer == 3){
                    self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Correct Answer").setValue("3")}
            }
        }
        // We jump back to 12 buttons-view
        navigationController?.popViewController(animated: true)
    }
    
    func CreateEmptySave() {
        if (loggedInHighest){
            self.ref.child("QuizWalks").child("QuizNameList").childByAutoId().setValue(["name" : quizWalkName.text!, "user" : "everyone"])
        }
        else{
            if (loggedInToWrite){
                self.ref.child("QuizWalks").child("QuizNameList").childByAutoId().setValue(["name" : quizWalkName.text!, "user" : questUser])
            }
        }
        
        for i in 1 ... 12{
            var qstring = "Fråga " + String(i)
            var string = "Fråga "
            
            string.append(Character(UnicodeScalar(64+i)!))
            self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Fråga").setValue(MyTextView.text)
            self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Answer 1").setValue(Answer1TextView.text)
            self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Answer 2").setValue(Answer2TextView.text)
            self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Answer 3").setValue(Answer3TextView.text)
            self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("Correct Answer").setValue(qstring)
            self.ref.child("QuizWalks").child("QuizNames").child(quizWalkName.text!).child(string).child("URLString").setValue("")
        }
        questionnumber = "1"
        LabelQuestNbr.text?.append(questionnumber)       
        MyTextView.text = "Skriv Fråga"
    }
    
    @IBAction func ButtonAnswer1(_ sender: Any) {
        ButtonAnswer1.backgroundColor = .green
        ButtonAnswerX.backgroundColor = .white
        ButtonAnswer2.backgroundColor = .white
        correctAnswer = 1
    }
    
    @IBAction func ButtonAnswerX(_ sender: Any) {
        ButtonAnswerX.backgroundColor = .green
        ButtonAnswer1.backgroundColor = .white
        ButtonAnswer2.backgroundColor = .white
        correctAnswer = 2
    }
    
    @IBAction func ButtonAnswer2(_ sender: Any) {
        ButtonAnswer2.backgroundColor = .green
        ButtonAnswerX.backgroundColor = .white
        ButtonAnswer1.backgroundColor = .white
        correctAnswer = 3
    }
}
