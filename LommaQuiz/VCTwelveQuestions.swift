//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

class VCTwelveQuestions: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var QuizWalkName: UITextField!
    @IBOutlet weak var Quest1Button: UIButton!
    @IBOutlet weak var Quest2Button: UIButton!
    @IBOutlet weak var Quest3Button: UIButton!
    @IBOutlet weak var Quest4Button: UIButton!
    @IBOutlet weak var Quest5Button: UIButton!
    @IBOutlet weak var Quest6Button: UIButton!
    @IBOutlet weak var Quest7Button: UIButton!
    @IBOutlet weak var Quest8Button: UIButton!
    @IBOutlet weak var Quest9Button: UIButton!
    @IBOutlet weak var Quest10Button: UIButton!
    @IBOutlet weak var Quest11Button: UIButton!
    @IBOutlet weak var Quest12Button: UIButton!
    @IBOutlet weak var QuestName: UITextField!
    @IBOutlet weak var toStartButton: UIButton!
    var saveCount = 0
    var quizname : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuizWalkName.text = quizname
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (loggedInToWrite)
        {
            print(saveCount)
            if saveCount == 12{
                toStartButton.backgroundColor = .systemGray5
            }
            if (!loggedInHighest)
            {
                QuizWalkName.text = questCreator + "s Quiz"
                QuestName.isEnabled = false
            }
        }
    }
    
    func checkIfWalkIsChosen()-> Bool{
        return (QuizWalkName.text != "")
    }
    @IBAction func toStart(_ sender: Any) {
        performSegue(withIdentifier: "toStartMenu", sender: 1)
    }
    
    @IBAction func goToChoose(_ sender: Any) {
        //choseQuestionsToAlter
        performSegue(withIdentifier: "choseQuestionsToAlter", sender: "1")
    }
    @IBAction func ButtonToWriteQuest(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "1")
            ClearAllButtons()
            Quest1Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest2(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "2")
            ClearAllButtons()
            Quest2Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest3(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "3")
            ClearAllButtons()
            Quest3Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest4(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "4")
            ClearAllButtons()
            Quest4Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest5(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "5")
            ClearAllButtons()
            Quest5Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest6(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "6")
            ClearAllButtons()
            Quest6Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest7(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "7")
            ClearAllButtons()
            Quest7Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest8(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "8")
            ClearAllButtons()
            Quest8Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest9(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "9")
            ClearAllButtons()
            Quest9Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest10(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "10")
            ClearAllButtons()
            Quest10Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest11(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "11")
            ClearAllButtons()
            Quest11Button.backgroundColor = .green
        }
    }
    
    @IBAction func ButtonQuest12(_ sender: Any) {
        if checkIfWalkIsChosen(){
            performSegue(withIdentifier: "writequestion", sender: "12")
            ClearAllButtons()
            Quest12Button.backgroundColor = .green
        }
    }
    
    func hideKeyboard(){
        QuizWalkName.isEnabled = false
        QuizWalkName.isEnabled = true
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if parent == nil {
            debugPrint("Back Button pressed.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        hideKeyboard()
        
        if (segue.identifier == "writequestion"){
            let dest = segue.destination as! VCWriteQuestion
            
            dest.quizWalkName2 = QuizWalkName.text!
            dest.questionnumber = sender as! String
        }
        
        
        if (segue.identifier == "choseQuestionsToAlter"){
            let dest = segue.destination as! VCChoseKm
            dest.cameFromChangeQuestions = true
        }
        
        if (segue.identifier == "toStartMenu"){
            let dest = segue.destination as! ViewController
        }
    }
    
    func ClearAllButtons(){
        saveCount += 1
    }
    
}
