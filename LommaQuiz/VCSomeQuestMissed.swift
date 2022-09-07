//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import Firebase

class VCSomeQuestMissed: UIViewController {

    @IBOutlet weak var someTextMissedQuest: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getText()
    }
  
    func getText() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("QuizWalks").child("VidMissadeFrågorText").getData(completion:{ [self]error, snapshot in
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
 
                        let LoginInfo = loginChildSnap.value as! String
                    
                        print(LoginInfo)
                        someTextMissedQuest.text = LoginInfo
                    }
                }
                else
                {
                    print("snapshot == nil")
                }
            
        })
    }
}
