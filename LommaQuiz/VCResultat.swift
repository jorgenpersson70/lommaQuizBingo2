//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

class VCResultat: UIViewController {
    
    @IBOutlet weak var correctAnswerCount: UITextField!
    @IBOutlet weak var questButton1: UIButton!
    @IBOutlet weak var questButton2: UIButton!
    @IBOutlet weak var questButton3: UIButton!
    @IBOutlet weak var questButton4: UIButton!
    @IBOutlet weak var questButton5: UIButton!
    @IBOutlet weak var questButton6: UIButton!
    @IBOutlet weak var questButton7: UIButton!
    @IBOutlet weak var questButton8: UIButton!
    @IBOutlet weak var questButton9: UIButton!
    @IBOutlet weak var questButton10: UIButton!
    @IBOutlet weak var questButton11: UIButton!
    @IBOutlet weak var questButton12: UIButton!
    @IBOutlet weak var questionMissed: UIButton!
    
    
    var quizname : String = ""
    var infotext = ""
    var YourAnswer = Array(repeating: 0, count: 12)
    var ref: DatabaseReference!
    var correctanswers = [String]()
    var FoundDate = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionMissed.isEnabled = false
        questionMissed.alpha = 0
        
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
                    for quizNameChild in snapshot.children
                    {
                        let quizNameChildSnap = quizNameChild as! DataSnapshot
                        let quizNameChildInfo = quizNameChildSnap.value as! [String : String]
                          
                        self.correctanswers.append(quizNameChildInfo["Correct Answer"]!)
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
                else
                {
  
                }
            }
        })
    }
    
    func loadQuestionAndAnswers() {
  
       var CountCorrectAnswers = 0
            
        for i in 1...12{
            var test3 = YourAnswer[i-1]
            var test = Int(correctanswers[i-1])
  
            if (test == test3)
            {
                CountCorrectAnswers += 1
                MarkButtons(questNumber: i)
                
            }
            
            if (test3 == 0){
                questionMissed.isEnabled = true
                questionMissed.alpha = 1
            }
        }
        correctAnswerCount.text = String(CountCorrectAnswers)
    }
    
    func MarkButtons(questNumber : Int){
        switch questNumber{
        case 1 : questButton1.backgroundColor = .green
        case 2 : questButton2.backgroundColor = .green
        case 3 : questButton3.backgroundColor = .green
        case 4 : questButton4.backgroundColor = .green
        case 5 : questButton5.backgroundColor = .green
        case 6 : questButton6.backgroundColor = .green
        case 7 : questButton7.backgroundColor = .green
        case 8 : questButton8.backgroundColor = .green
        case 9 : questButton9.backgroundColor = .green
        case 10 : questButton10.backgroundColor = .green
        case 11 : questButton11.backgroundColor = .green
        default : questButton12.backgroundColor = .green
        }
    }
    
    @IBAction func ToStartMenu(_ sender: Any) {
        performSegue(withIdentifier: "toStartMenu", sender: 1)
    }
    
    @IBAction func ButtonSeeQ1(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 1)
    }
    
    @IBAction func ButtonSeeQ2(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 2)
    }
    
    @IBAction func ButtonSeeQ3(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 3)
    }
    
    @IBAction func ButtonSeeQ4(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 4)
    }
    
    @IBAction func ButtonSeeQ5(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 5)
    }
    
    @IBAction func ButtonSeeQ6(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 6)
    }
    
    @IBAction func ButtonSeeQ7(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 7)
    }
    
    @IBAction func ButtonSeeQ8(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 8)
    }
    
    @IBAction func ButtonSeeQ9(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 9)
    }
    
    @IBAction func ButtonSeeQ10(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 10)
    }
    
    @IBAction func ButtonSeeQ11(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 11)
    }
    
    @IBAction func ButtonSeeQ12(_ sender: Any) {
        performSegue(withIdentifier: "SeeQuestion", sender: 12)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "SeeQuestion"){
            let dest = segue.destination as! VCSeeResultOneByOne
            
            dest.quizname = quizname
            dest.infotext = infotext
            dest.YourAnswer = YourAnswer
            dest.questionnumberInt = sender as! Int
        }
        
        if (segue.identifier == "toStartMenu"){
            let dest = segue.destination as! ViewController
        }
    }

}
