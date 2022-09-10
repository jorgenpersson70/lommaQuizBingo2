//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

class VCChoseKm: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var TVquizNames: UITableView!
 
    var walkNumber : String = ""
    var ref: DatabaseReference!
    var FoundDate : Bool = false
    var quiznamelist = [String]()
    var quizUserlist = [String]()
    var cameFromChangeQuestions = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (BingoName != ""){
            // if they just created a new bingo and start again, clear
            VCSeeBingoPlayerRun().clearGrayCells()
            VCBingoSmall().clearGrayCells()
            performSegue(withIdentifier: "karta", sender: "Bingo")
        }else{
            if (quiznamelist.isEmpty){
                loadQuizNames()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func loadQuizNames() {
        
        
        
            ref.child("QuizWalks").child("QuizNameList").getData(completion:{ [self]error, snapshot in
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
                        let quizNameInfo = quizNameChildSnap.value as! [String : String]
                   
                        // kolla så att den är som tidigare
                        
                        self.quizUserlist.append(quizNameInfo["user"]!)
                        
                        if (loggedInHighest)
                        {
                            if (quizNameInfo["user"] == "everyone")
                            {
                                self.quiznamelist.append(quizNameInfo["name"]!)
                            }
                        }
                        else
                        {
                            if (questUser == ""){
                                if (quizNameInfo["user"] == "everyone")
                                {
                                    self.quiznamelist.append(quizNameInfo["name"]!)
                                }
                            }
                            else{
                                if (questUser == quizNameInfo["user"]){
                              //  if (questUser == userString!){
                                    self.quiznamelist.append(quizNameInfo["name"]!)
                                }
                                
                            }
                        }
                        
                    }
                    for quizNameChild in snapshot.children
                    {
                        let quizNameChildSnap = quizNameChild as! DataSnapshot
                        let quizNameInfo = quizNameChildSnap.value as! [String : String]
                   
                     //   self.quizUserlist.append(quizNameInfo["user"]!)
                        
                        if (questUser != "")
                        {   // some user with permission to write are not allowed to change other than own Quiz
                            if (!loggedInToWrite){
                                if (quizNameInfo["user"] == "everyone")
                                {
                                    self.quiznamelist.append(quizNameInfo["name"]!)
                                }
                            }
                           
                        }
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
            DispatchQueue.main.async {
                self.TVquizNames.reloadData()
            }
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quiznamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daterowtest") as! TableViewCellDate
        
        // se över detta nedan
        
        if (quiznamelist.count > indexPath.row){
            cell.dateChoose.text = quiznamelist[indexPath.row]
         
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
        tableView.deselectRow(at: indexPath, animated: true)
        print("Klickat på en rad " + String(indexPath.row))
        if (cameFromChangeQuestions){
  // have to stay true because I might press back from backToWriteQuestions          cameFromChangeQuestions = false
            performSegue(withIdentifier: "backToWriteQuestions", sender: quiznamelist[indexPath.row])
        }
        else{
            performSegue(withIdentifier: "karta", sender: quiznamelist[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == "karta"){
            let dest = segue.destination as! VCGPSMap
            
            // global values
            YourAnswer = Array(repeating: 0, count: 12)
            QuestFound = Array(repeating: false, count: 12)
            readNewCoordinates = true
            longitude.removeAll()
            latitude.removeAll()
            
            dest.quizname = sender as! String
            dest.questionnumberInt = 1
            dest.WalkNumber = walkNumber
        }
        if (segue.identifier == "backToWriteQuestions"){
            let dest = segue.destination as! VCTwelveQuestions
            
            dest.quizname = sender as! String
        }
        
    }
}
