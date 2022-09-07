//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import UIKit
import FirebaseAuth

class VCAuth: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
 //   @IBOutlet weak var showStatusText: UITextField!
    
    @IBOutlet weak var showStatusTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to make it easier for the people creating bingo-rundor
        emailText.text = "bingoc@icloud.com"
        if (Auth.auth().currentUser?.email == "jorgen_raby@hotmail.com"){
            showStatusTV.text = "Inloggad"
        }
        if (Auth.auth().currentUser?.email == "jorgen@icloud.com"){
            showStatusTV.text = "Inloggad"
        }
        if (Auth.auth().currentUser?.email == "bingou@icloud.com"){
            showStatusTV.text = "Inloggad för att gå BINGORUNDA"
        }
        if (Auth.auth().currentUser?.email == "bingoc@icloud.com"){
            showStatusTV.text = "Inloggad för att skapa BINGORUNDA, tryck Back och Back välj SKAPA BINGORUNDA"
        }
        if (Auth.auth().currentUser?.email == "rundac@icloud.com"){
            showStatusTV.text = "Inloggad för att skapa runda, tryck Back och Back och VÄLJ PROMENAD"
        }
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
       
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                showStatusTV.text = "Utloggad"
                masterLoggedIn = false
                authPassedForUser = false
                loggedInHighest = false
                loggedInToWrite = false
                // bingo
                takeAwayButtonToChooseRunda = false
                questUserBingo = ""
                BingoName = ""
            } catch
                let signOutError as NSError
            {
              print("Error signing out: %@", signOutError)
                showStatusTV.text = "Fel vid utloggning"
            }
    }
    
    func forceLogout() {
       
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
   //             showStatusText.text = "Utloggad"
                masterLoggedIn = false
                authPassedForUser = false
                loggedInHighest = false
                loggedInToWrite = false
            } catch
                let signOutError as NSError
            {
   //           print("Error signing out: %@", signOutError)
    //            showStatusText.text = "Fel vid utloggning"
            }
    }
        
    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if error == nil{
                // hurra
                self!.showStatusTV.text = "Inloggad. Tryck Back och logga in där också."
                print("login ok")
                print(Auth.auth().currentUser?.uid)
                print(Auth.auth().currentUser?.displayName)
                print(Auth.auth().currentUser?.email)
                if (Auth.auth().currentUser?.email == "jorgen_raby@hotmail.com"){
                    print("jorgen hotmail")
                }
                if (Auth.auth().currentUser?.email == "jorgen@icloud.com"){
                    print("jorgen icloud")
                }
                if (Auth.auth().currentUser?.email == "bingoc@icloud.com"){
                    self!.showStatusTV.text = "Inloggad. Tryck Back och Back och välj SKAPA BINGORUNDA"
                }
                if (Auth.auth().currentUser?.email == "rundac@icloud.com"){
                    self!.showStatusTV.text = "Inloggad. Tryck Back och Back och välj VÄLJ PROMENAD OCH välj SKAPA RUNDA"
                }
                
                self!.dismiss(animated: false, completion: nil)
            }
            else{
                // ajdå
                print("login fel")
                self!.showStatusTV.text = "Fel vid inloggning"
            }
        }
    }
    
    func forceBingoLogin(email : String, password : String) {
        print(email)
        print(password)
        print("hej")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if error == nil{
                self!.dismiss(animated: false, completion: nil)
            }
            else{
                // ajdå
                print("login fel")
            }
        }
    }
    
    // I keep it here but I dont use it
    @IBAction func registerUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authResult, error in
            if error == nil{
                // hurra
                print("reg ok")
                self.showStatusTV.text = "Registrering OK"
                self.dismiss(animated: false, completion: nil)
            }
            else{
                // ajdå
                print("reg ej ok")
                self.showStatusTV.text = "Registrering ej OK"
            }
        }
    }
}
