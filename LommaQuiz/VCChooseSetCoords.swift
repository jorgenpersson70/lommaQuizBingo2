//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

var ToggleSetWalk : Bool = false // har jag denna för återhopp från ??
//var ownWalk = ""

class VCChooseSetCoords: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var SetWalkCoords: UIButton!
    @IBOutlet weak var CreateQuestions: UIButton!
    @IBOutlet weak var walk1Button: UIButton!
    @IBOutlet weak var walk2Button: UIButton!
    @IBOutlet weak var walk3Button: UIButton!
    @IBOutlet weak var walk4Button: UIButton!
    @IBOutlet weak var walk5Button: UIButton!
    @IBOutlet weak var walkButton: UIButton!
    @IBOutlet weak var copyWalkButton: UIButton!
    @IBOutlet weak var lookForWalkButton: UIButton!
    
    //   @IBOutlet weak var nameOwnWalk: UITextField!
 //   @IBOutlet weak var doesOwnWalkExist: UITextField!
    
    var enableSeRunda = false
    //var ownWalkExist = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // global variabel checked in VCGPSMap
        readNewCoordinates = true
        
        
        
        if (VCLogin().isRundacLoggedIn()){
            SetWalkCoords.isEnabled = true
            SetWalkCoords.alpha = 1
            
        }
        else{
            if (loggedInToWrite){
                SetWalkCoords.isEnabled = true
                CreateQuestions.isEnabled = true
                SetWalkCoords.alpha = 1
                CreateQuestions.alpha = 1
            }
            else{
                SetWalkCoords.isEnabled = false
                CreateQuestions.isEnabled = false
                SetWalkCoords.alpha = 0
                CreateQuestions.alpha = 0
            }
        }
        walkButton.isEnabled = false
        walkButton.alpha = 0
        copyWalkButton.isEnabled = false
        copyWalkButton.alpha = 0
        
  //      doesOwnWalkExist.text = ""
 //       nameOwnWalk.text = ""
        
    }
    
    
/*    @IBAction func endWritingNamn(_ sender: UITextField) {
        checkIfWalkExists()
    }
    
    @IBAction func startWritingName(_ sender: UITextField) {
        
    }
    
    @IBAction func Done(_ sender: UITextField) {
        nameOwnWalk.resignFirstResponder()
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        makeButtonsInvisable()
    }
    
    func makeButtonsInvisable()
    {
        if (VCLogin().isRundacLoggedIn()){
            walk1Button.isEnabled = false
            walk1Button.alpha = 0
            walk2Button.isEnabled = false
            walk2Button.alpha = 0
            walk3Button.isEnabled = false
            walk3Button.alpha = 0
            walk4Button.isEnabled = false
            walk4Button.alpha = 0
            walk5Button.isEnabled = false
            walk5Button.alpha = 0
//            walkButton.isEnabled = true
 //           walkButton.alpha = 1
            lookForWalkButton.isEnabled = false
            lookForWalkButton.alpha = 0
        }
        else{
            if (loggedInToWrite)
            {
                if (!loggedInHighest)
                {
                    walk1Button.isEnabled = false
                    walk1Button.alpha = 0
                    walk2Button.isEnabled = false
                    walk2Button.alpha = 0
                    walk3Button.isEnabled = false
                    walk3Button.alpha = 0
                    walk4Button.isEnabled = false
                    walk4Button.alpha = 0
                    walk5Button.isEnabled = false
                    walk5Button.alpha = 0
                    walkButton.isEnabled = true
                    walkButton.alpha = 1
                    lookForWalkButton.isEnabled = false
                    lookForWalkButton.alpha = 1
                }
                else{  // Special for Admin to copy one walk to another
                    copyWalkButton.isEnabled = true
                    copyWalkButton.alpha = 1
                }
            }
        }
    }
    
    @IBAction func walk1(_ sender: Any) {
        
        if (!ToggleSetWalk){
            performSegue(withIdentifier: "showWalks2", sender: 1)
        }else{
            performSegue(withIdentifier: "chosenRound", sender: 1)
        }
    }
    
    @IBAction func walk2(_ sender: Any) {
        
        if (!ToggleSetWalk){
            performSegue(withIdentifier: "showWalks2", sender: 2)
        }else{
            performSegue(withIdentifier: "chosenRound", sender: 2)
        }
    }
    
    @IBAction func walk3(_ sender: Any) {
        
        if (!ToggleSetWalk){
            performSegue(withIdentifier: "showWalks2", sender: 3)
        }else{
            performSegue(withIdentifier: "chosenRound", sender: 3)
        }
    }
    
    @IBAction func walk4(_ sender: Any) {
        
        if (!ToggleSetWalk){
            performSegue(withIdentifier: "showWalks2", sender: 4)
        }else{
            performSegue(withIdentifier: "chosenRound", sender: 4)
        }
    }
    
    @IBAction func walk5(_ sender: Any) {
        
        if (!ToggleSetWalk){
            performSegue(withIdentifier: "showWalks2", sender: 5)
        }else{
            performSegue(withIdentifier: "chosenRound", sender: 5)
        }
    }
    /*
    func clearOwnWalk(){
        ownWalk = ""
        nameOwnWalk.text = ""
        doesOwnWalkExist.text = ""
    }*/
    
    @IBAction func walk(_ sender: Any) {
        if (VCLogin().isRundacLoggedIn()){
            
        }else{
   /*         if (ownWalkExist){
                performSegue(withIdentifier: "showWalks2", sender: 10)
            }else{*/
                performSegue(withIdentifier: "showWalks2", sender: 6)
     //       }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "chosenRound"){
            let dest = segue.destination as! VCSetCoords
        
            dest.walkNumber = sender as! Int
        }
        if (segue.identifier == "showWalks2"){
            let dest = segue.destination as! VCShowWalk2
            dest.walkNumber = sender as! Int
        /*    if (ownWalkExist){
                dest.chosenOwnWalk = nameOwnWalk.text!
            }*/
        }
    }
    
    @IBAction func SetWalkCoordsButton(_ sender: Any) {
        
            if (loggedInHighest)
            {
                if (!ToggleSetWalk){
                    SetWalkCoords.backgroundColor = .red
                    ToggleSetWalk = true
                }
                else{
                    SetWalkCoords.backgroundColor = .white
                    ToggleSetWalk = false
                }
            }
            else
            {
                performSegue(withIdentifier: "chosenRound", sender: 6)
            }
        
    }
    /*
    func checkIfWalkExists()
    {
        var walkExists = false
    
        if (nameOwnWalk.text != ""){
            ref.child("QuizWalks").child("maps").child(nameOwnWalk.text!).getData(completion:{ [self]error, snapshot in
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
                                self.doesOwnWalkExist.text = "Rundan finns och är nu vald"
                                ownWalkExist = true
                                VCGPSMap().GetCoords(WalkNumberIn: nameOwnWalk.text!)
                //                performSegue(withIdentifier: "backToStart", sender: 5)
                                walkButton.isEnabled = true
                                walkButton.alpha = 1
                                ownWalk = nameOwnWalk.text!
                            }
        
                            if (walkExists){
                                
                               
                            }
                            else{
                                self.doesOwnWalkExist.text = "Rundan finns inte"
                                ownWalkExist = true
                            }
                    }
                    else
                    {
                        print("snapshot == nil")
                    }
            }) // BingoConnectRunda.text
        }
    }*/
}
