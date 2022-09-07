//
//  VCListSpecialWalk.swift
//  LommaQuiz
//
//  Created by jörgen persson on 2022-09-04.
//

import UIKit
import Firebase

var ownWalk2 = ""
class VCListSpecialWalk: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var specialWalkName: UITextField!
    @IBOutlet weak var doesSpecialWalkExist: UITextField!
    @IBOutlet weak var ListOfSpecialWalks: UITableView!
    
    var quiznamelist = [String]()
    var quizUserlist = [String]()
    var ownWalkExist = false
    
    var ref: DatabaseReference!
    // specialWalkRow
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        loadQuizNames()
        
        specialWalkName.text = ""
        doesSpecialWalkExist.text = ""

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func beginWritingName(_ sender: UITextField) {
        ownWalkExist = false
    }
    
    @IBAction func endWritingName(_ sender: UITextField) {
        checkIfWalkExists()
    }
    
    
    @IBAction func done(_ sender: UITextField) {
        specialWalkName.resignFirstResponder()
    }
    
    
    
    func loadQuizNames() {
        
        
        ref.child("QuizWalks").child("maps").getData(completion:{ [self]error, snapshot in
                guard error == nil else
                {
                print(error!.localizedDescription)
                return;
            }

            if (snapshot != nil)
            {
                    for quizNameChild in snapshot.children
                    {
                        let quizNameChildSnap = quizNameChild as! DataSnapshot
               
                        // I deside that these are not to be shown
                        if ((quizNameChildSnap.key == "Walk1") || (quizNameChildSnap.key == "Walk2") || (quizNameChildSnap.key == "Walk3") || (quizNameChildSnap.key == "Walk4") || (quizNameChildSnap.key == "Walk5") || (quizNameChildSnap.key == "Walk")){
                            
                        }else{
                            self.quiznamelist.append(quizNameChildSnap.key)
                        }
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
            DispatchQueue.main.async {
                self.ListOfSpecialWalks.reloadData()
            }
            
        })
    }
    
    func checkIfWalkExists()
    {
     //   var walkExists = false
    // check if walk exists
        if (specialWalkName.text != ""){
            ref.child("QuizWalks").child("maps").child(specialWalkName.text!).getData(completion:{ [self]error, snapshot in
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
                             //   walkExists = true
                                self.doesSpecialWalkExist.text = "Rundan finns och är nu vald"
                                ownWalkExist = true
                                VCGPSMap().GetCoords(WalkNumberIn: specialWalkName.text!)
                                chosenWalkGlobal = 0
                                ownWalk2 = specialWalkName.text!
                            }
        
                            if (!ownWalkExist){
                         
                                self.doesSpecialWalkExist.text = "Rundan finns inte"
                                ownWalkExist = true
                            }
                    }
                    else
                    {
                        print("snapshot == nil")
                    }
            }) // BingoConnectRunda.text
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quiznamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specialWalk") as! TVCSpecialWalk
        
   //     cell.specialWalkRow.text = "hallå där"
        // se över detta nedan
        
        if (quiznamelist.count > indexPath.row){
            cell.specialWalkRow.text = quiznamelist[indexPath.row]
        }else{
            print("kolla här")
        }
     
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        print("Klickat på en rad " + String(indexPath.row))
        ownWalk2 = quiznamelist[indexPath.row]
        specialWalkName.text = ownWalk2
        self.doesSpecialWalkExist.text = "Rundan finns och är nu vald"
        VCGPSMap().GetCoords(WalkNumberIn: specialWalkName.text!)
        chosenWalkGlobal = 0
    }

}
