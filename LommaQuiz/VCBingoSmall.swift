//
//  VCBingoSmall.swift
//  LommaQuiz
//
//  Created by jörgen persson on 2022-09-09.
//

import UIKit
import Firebase

//var cellsThatAreGrayChart1 : [Int] = Array(repeating: 0, count: 25)
//var cellsThatAreGrayChart2 : [Int] = Array(repeating: 0, count: 25)
//var cellsThatAreGrayChart3 : [Int] = Array(repeating: 0, count: 25)
var prevNumbersSmall : [Int] = Array(repeating: 0, count: 36)
var waitToTheLastToShowLooser = false
var WinnerIs = ""

class VCBingoSmall: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var bingoChart1CV: UICollectionView!
    
    @IBOutlet weak var bingoChart2CV: UICollectionView!
    
    @IBOutlet weak var bingoChart3CV: UICollectionView!
    @IBOutlet weak var bingoPrevCV: UICollectionView!
    
    @IBOutlet weak var winnerTV: UITextView!
    
    @IBOutlet weak var proofOfWinnerAlert: UITextView!
    
    @IBOutlet weak var showPoistion: UITextField!
    
    @IBOutlet weak var NextButton: UIButton!
    
    
    @IBOutlet weak var buttonText: UILabel!
    
    @IBOutlet weak var showB: UITextField!
    @IBOutlet weak var showI: UITextField!
    @IBOutlet weak var showN: UITextField!
    @IBOutlet weak var showG: UITextField!
    @IBOutlet weak var showO: UITextField!
    
    var ref: DatabaseReference!
    
    var quizname : String = ""
    
    var questionnumberInt : Int = 0
    
    var BChart1 = 0
    var IChart1 = 0
    var NChart1 = 0
    var GChart1 = 0
    var OChart1 = 0
  
    var BChart2 = 0
    var IChart2 = 0
    var NChart2 = 0
    var GChart2 = 0
    var OChart2 = 0
    
    var BChart3 = 0
    var IChart3 = 0
    var NChart3 = 0
    var GChart3 = 0
    var OChart3 = 0
    
    var RowChart = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var i = 0
    var k = 0
    var e = 0
    
    var bEval = 0
    var iEval = 0
    var nEval = 0
    var gEval = 0
    var oEval = 0
    
    var test4 = 0
    var test5 = 5
    var test6 = 10
    
    var BValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var IValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var NValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var GValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var OValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var ValuesToEvaluateB = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateI = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateN = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateG = [1, 2, 3,4,5,6,7]
    var ValuesToEvaluateO = [1, 2, 3,4,5,6,7]
    
    var WinnerNumbers = [0,0,0,0,0]
    
    let reuseIdentifierChart1 = "BingoChart1Small" // also enter this string as the cell identifier in the storyboard
    let reuseIdentifierChart2 = "BingoChart2Small"
    let reuseIdentifierChart3 = "BingoChart3Small"
    let reuseIdentifierPrev = "bingoPrevSmall"
    
    var ValueToPopUp1 = 0
    var ValueToPopUp2 = 0
    var ValueToPopUp3 = 0
    
    var valuesPrevToShow = [0,0,0]
    var f = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        navigationItem.hidesBackButton = true
        // testa. bort sen
   //     setGrayAuto()
        
        ref = Database.database().reference()
  
        self.winnerTV.isHidden = true
        self.proofOfWinnerAlert.isHidden = true
        showPoistion.text = String(questionnumberInt)
        
        let postRef = ref.child("BingoPlayerWinner").child(BingoName)
        
        // the winner writes to database and everyone gets the message
        postRef.observe(.childChanged, with: { [self](snapshot) -> Void in
     // if we get to here it means that we have a winner
            let key = snapshot.key
                    print("KEY \(key)")
            
            
            var theWinner = snapshot.value as! String
            WinnerIs = theWinner
         //   var theWinnerInt = snapshot.value as! Int
            
            var theWinnerInt = Int(theWinner)
            
            if (theWinnerInt == youAreplayer){
                self.proofOfWinnerAlert.isHidden = false
                self.winnerTV.isHidden = false
                self.winnerTV.text = "Grattis, du har fått BINGO. Har ni satsat något, du och de andra deltagarna? En fika, kaffe, eller vem som skall diska eller dammsuga."
                // alert, when you press TILLBAKA, your proof of winning is lost.
                self.NextButton.backgroundColor = .red
                // OBS! När du trycker NÄSTA så försvinner ditt bevis på att du vann.
                proofOfWinnerAlert.text = "OBS! När du trycker NÄSTA så försvinner ditt bevis på att du vann."
            }else{
                waitToTheLastToShowLooser = true
     //           self.winnerTV.text = "Deltagare " + theWinner + " har fått BINGO"
     //           proofOfWinnerAlert.text = "OBS! När du trycker NÄSTA så kan du inte se bingobrickorna igen"
            }
            
            
            
        })
  
        
 
        if ((ValueToPopUp1 > 0) && (ValueToPopUp1 < 16)){
            showB.text = String(ValueToPopUp1)
            valuesPrevToShow[f] = ValueToPopUp1
            f += 1
     
        }
        if ((ValueToPopUp1 > 15) && (ValueToPopUp1 < 31)){
            showI.text = String(ValueToPopUp1)
            valuesPrevToShow[f] = ValueToPopUp1
            f += 1
   
        }
        if ((ValueToPopUp1 > 30) && (ValueToPopUp1 < 46)){
            showN.text = String(ValueToPopUp1)
            valuesPrevToShow[f] = ValueToPopUp1
            f += 1
  
        }
        if ((ValueToPopUp1 > 45) && (ValueToPopUp1 < 61)){
            showG.text = String(ValueToPopUp1)
            valuesPrevToShow[f] = ValueToPopUp1
            f += 1

        }
        if ((ValueToPopUp1 > 60) && (ValueToPopUp1 < 76)){
            showO.text = String(ValueToPopUp1)
            valuesPrevToShow[f] = ValueToPopUp1
            f += 1
  
        }
        
        
        if ((ValueToPopUp2 > 0) && (ValueToPopUp2 < 16)){
            showB.text = String(ValueToPopUp2)
            valuesPrevToShow[f] = ValueToPopUp2
            f += 1
   
        }
        if ((ValueToPopUp2 > 15) && (ValueToPopUp2 < 31)){
            showI.text = String(ValueToPopUp2)
            valuesPrevToShow[f] = ValueToPopUp2
            f += 1
 
        }
        if ((ValueToPopUp2 > 30) && (ValueToPopUp2 < 46)){
            showN.text = String(ValueToPopUp2)
            valuesPrevToShow[f] = ValueToPopUp2
            f += 1
 
        }
        if ((ValueToPopUp2 > 45) && (ValueToPopUp2 < 61)){
            showG.text = String(ValueToPopUp2)
            valuesPrevToShow[f] = ValueToPopUp2
            f += 1
  
        }
        if ((ValueToPopUp2 > 60) && (ValueToPopUp2 < 76)){
            showO.text = String(ValueToPopUp2)
            valuesPrevToShow[f] = ValueToPopUp2
            f += 1
 
        }
        
 
        
            if ((ValueToPopUp3 > 0) && (ValueToPopUp3 < 16)){
                showB.text = String(ValueToPopUp3)
                valuesPrevToShow[f] = ValueToPopUp3
                f += 1
   
            }
            if ((ValueToPopUp3 > 15) && (ValueToPopUp3 < 31)){
                showI.text = String(ValueToPopUp3)
                valuesPrevToShow[f] = ValueToPopUp3
                f += 1
    
            }
            if ((ValueToPopUp3 > 30) && (ValueToPopUp3 < 46)){
                showN.text = String(ValueToPopUp3)
                valuesPrevToShow[f] = ValueToPopUp3
                f += 1
   
            }
            if ((ValueToPopUp3 > 45) && (ValueToPopUp3 < 61)){
                showG.text = String(ValueToPopUp3)
                valuesPrevToShow[f] = ValueToPopUp3
                f += 1
    
            }
            if ((ValueToPopUp3 > 60) && (ValueToPopUp3 < 76)){
                showO.text = String(ValueToPopUp3)
  
                valuesPrevToShow[f] = ValueToPopUp3
                f += 1
            }
    
            for t in 0...2{
                prevNumbersSmall[(questionnumberInt-1)*3+t] = valuesPrevToShow[t]
            }
            
   
        
       // kanske bort ??
        bingoChart1CV.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    func walkfiniched()->Bool{
        var countTheValues = 0
        for t in 0...35{
            if (prevNumbersSmall[t] != 0){
                countTheValues += 1
            }
        }
        if (countTheValues == 35){
            
            return true
        }else{
            print("antal ", String(countTheValues))
            return false
        }
    }
    
    // just for test
    func setGrayAutoNotUsed(){
        for i in 0...14{
            if (i < 5){
                for n in 0...6{
                        if (BValues[i] == ValuesToEvaluateB[n]){
                            cellsThatAreGrayChart1[i*5] = 1
                        }
                }
                for n in 0...6{
                        if (IValues[i] == ValuesToEvaluateI[n]){
                            cellsThatAreGrayChart1[i*5+1] = 1
                        }
                }
                for n in 0...6{
                        if (NValues[i] == ValuesToEvaluateN[n]){
                            cellsThatAreGrayChart1[i*5+2] = 1
                        }
                }
                for n in 0...6{
                        if (GValues[i] == ValuesToEvaluateG[n]){
                            cellsThatAreGrayChart1[i*5+3] = 1
                        }
                }
                for n in 0...6{
                        if (OValues[i] == ValuesToEvaluateO[n]){
                            cellsThatAreGrayChart1[i*5+4] = 1
                        }
                }
            }
            if ((i > 4) && (i < 10)){
                var j = i-5
                for n in 0...6{
                        if (BValues[i] == ValuesToEvaluateB[n]){
                            cellsThatAreGrayChart2[j*5] = 1
                        }
                }
                for n in 0...6{
                        if (IValues[i] == ValuesToEvaluateI[n]){
                            cellsThatAreGrayChart2[j*5+1] = 1
                        }
                }
                for n in 0...6{
                        if (NValues[i] == ValuesToEvaluateN[n]){
                            cellsThatAreGrayChart2[j*5+2] = 1
                        }
                }
                for n in 0...6{
                        if (GValues[i] == ValuesToEvaluateG[n]){
                            cellsThatAreGrayChart2[j*5+3] = 1
                        }
                }
                for n in 0...6{
                        if (OValues[i] == ValuesToEvaluateO[n]){
                            cellsThatAreGrayChart2[j*5+4] = 1
                        }
                }
            }
            if ((i > 9) && (i < 15)){
                var j = i-10
                for n in 0...6{
                        if (BValues[i] == ValuesToEvaluateB[n]){
                            cellsThatAreGrayChart3[j*5] = 1
                        }
                }
                for n in 0...6{
                        if (IValues[i] == ValuesToEvaluateI[n]){
                            cellsThatAreGrayChart3[j*5+1] = 1
                        }
                }
                for n in 0...6{
                        if (NValues[i] == ValuesToEvaluateN[n]){
                            cellsThatAreGrayChart3[j*5+2] = 1
                        }
                }
                for n in 0...6{
                        if (GValues[i] == ValuesToEvaluateG[n]){
                            cellsThatAreGrayChart3[j*5+3] = 1
                        }
                }
                for n in 0...6{
                        if (OValues[i] == ValuesToEvaluateO[n]){
                            cellsThatAreGrayChart3[j*5+4] = 1
                        }
                }
            }
        }
        
        // ValuesToEvaluateB
        // cellsThatAreGrayChart1[l] != 0
        
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
  
        if (collectionView == bingoPrevCV){
            let padding: CGFloat =  1
            let collectionViewSize = collectionView.frame.size.width - padding
    
            return CGSize(width: collectionViewSize/6, height: collectionViewSize/6)
            
        }else{
            let padding: CGFloat =  1
            let collectionViewSize = collectionView.frame.size.width - padding
    
            return CGSize(width: collectionViewSize/6, height: collectionViewSize/6)
        }
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //    return UIEdgeInsets(top: 1, left: 1, bottom: 5, right: 1)
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  if (collectionView == bingoChart1CV){
        if (collectionView == bingoPrevCV){
            return 35
        }else{
            return 25
        }
    }
    
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var test = 0
        var test2 = 0
        var test3 = 0
        
        if (collectionView == bingoChart1CV){
            
            let cell = bingoChart1CV.dequeueReusableCell(withReuseIdentifier: reuseIdentifierChart1, for: indexPath as IndexPath) as! CVCell1Small
            
            print("Hoppas i är < 25 ", String(i))
            
           //     cell.backgroundColor = .red
            
            k = 0
            if (i < 25){
                k = i
            }
            if ((i > 24) && (i < 50)){
                k = i - 25
            }
            if ((i > 49) && (i < 75)){
                k = i - 50
            }
                
            if (cellsThatAreGrayChart1[k] != 0){
                cell.backgroundColor = .systemGray
            }else{
                cell.backgroundColor = .cyan
            }
            
            for l in 0...24{
                if (cellsThatAreGrayChart1[l] != 0){
                    print("jodå", String(l))
                    print("jodå", String(k))
                }
            }
            
            if (i < 75)
      //          if (i < 25)
            {
                test = i % 5
                test2 = i / 5
                test3 = test2*5+test
                print("test3 ", String(test3))
                if (((i) % 5) == 0){
                    print("test4 ", String(test4))
                    cell.bingoChart1Label.text = String(BValues[test4])
                    
                    for n in 0...6{
                            if (BValues[test4] == ValuesToEvaluateB[n]){
             //                   cell.backgroundColor = .darkGray
                                BChart1 += 1
                                RowChart[test2] += 1
                            }
                        
                    }
                                        
                }
                if (((i) % 5) == 1){
                    cell.bingoChart1Label.text = String(IValues[test4])
                    for n in 0...6{
                            if (IValues[test4] == ValuesToEvaluateI[n]){
              //                  cell.backgroundColor = .darkGray
                                IChart1 += 1
                                RowChart[test2] += 1
                            }
                    }
                }
                if (((i) % 5) == 2){
                    cell.bingoChart1Label.text = String(NValues[test4])
                    for n in 0...6{
                            if (NValues[test4] == ValuesToEvaluateN[n]){
                //                cell.backgroundColor = .darkGray
                                NChart1 += 1
                                RowChart[test2] += 1
                            }
                    }
                }
                if (((i) % 5) == 3){
                    cell.bingoChart1Label.text = String(GValues[test4])
                    for n in 0...6{
                            if (GValues[test4] == ValuesToEvaluateG[n]){
                //                cell.backgroundColor = .darkGray
                                GChart1 += 1
                                RowChart[test2] += 1
                            }
                    }
                }
                if (((i) % 5) == 4){
                    cell.bingoChart1Label.text = String(OValues[test4])
                    for n in 0...6{
                            if (OValues[test4] == ValuesToEvaluateO[n]){
                 //               cell.backgroundColor = .darkGray
                                OChart1 += 1
                                RowChart[test2] += 1
                            }
                    }
                    test4 += 1
                }
                
                
            }
            
            i += 1
            
            let indexnumer = indexPath.row
          
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 2

            return cell
        }
            // aha i her egentligen inte med saken att göra, jag tar ju från test5
            if (collectionView == bingoChart2CV){
                print("Hoppas i är 25-49 ", String(i))
                let cell2 = bingoChart2CV.dequeueReusableCell(withReuseIdentifier: reuseIdentifierChart2, for: indexPath as IndexPath) as! CVCell2Small
                
   //                 cell2.backgroundColor = .yellow
                
                k = 0
                if (i < 25){
                    k = i
                }
                if ((i > 24) && (i < 50)){
                    k = i - 25
                    
                    print("jodå1", String(k))
                }
                if ((i > 49) && (i < 75)){
                    k = i - 50
                    
                    print("jodå2", String(k))
                }
                    
                if (cellsThatAreGrayChart2[k] != 0){
                    cell2.backgroundColor = .systemGray
                }else{
                    cell2.backgroundColor = .yellow
                }
                
                for l in 0...24{
                    if (cellsThatAreGrayChart2[l] != 0){
                        print("jodå", String(l))
                        print("jodå", String(k))
                    }
                }
               
                
                if (i < 75)
         //           if ((i > 24) && (i < 50))
                {
                    test = i % 5
                    test2 = i / 5
                    test3 = test2*5+test
                    print("test3 ", String(test3))
                    if (((i) % 5) == 0){
                        print("test4 ", String(test4))
                        cell2.bingoChart2Label.text = String(BValues[test5])
                        for n in 0...6{
                                if (BValues[test5] == ValuesToEvaluateB[n]){
                 //                   cell2.backgroundColor = .darkGray
                                    BChart2 += 1
                                    RowChart[test2] += 1
                                }
                        }
                    }
                    if (((i) % 5) == 1){
                        cell2.bingoChart2Label.text = String(IValues[test5])
                        for n in 0...6{
                                if (IValues[test5] == ValuesToEvaluateI[n]){
                   //                 cell2.backgroundColor = .darkGray
                                    IChart2 += 1
                                    RowChart[test2] += 1
                                }
                        }
                    }
                    if (((i) % 5) == 2){
                        cell2.bingoChart2Label.text = String(NValues[test5])
                        for n in 0...6{
                                if (NValues[test5] == ValuesToEvaluateN[n]){
                    //                cell2.backgroundColor = .darkGray
                                    NChart2 += 1
                                    RowChart[test2] += 1
                                }
                        }
                    }
                    if (((i) % 5) == 3){
                        cell2.bingoChart2Label.text = String(GValues[test5])
                        for n in 0...6{
                                if (GValues[test5] == ValuesToEvaluateG[n]){
                    //                cell2.backgroundColor = .darkGray
                                    GChart2 += 1
                                    RowChart[test2] += 1
                                }
                        }
                    }
                    if (((i) % 5) == 4){
                        cell2.bingoChart2Label.text = String(OValues[test5])
                        for n in 0...6{
                                if (OValues[test5] == ValuesToEvaluateO[n]){
                   //                 cell2.backgroundColor = .darkGray
                                    OChart2 += 1
                                    RowChart[test2] += 1
                                }
                        }
                        test5 += 1
                    }
                  //  if (test == 4){
                        
                 //   }
                }
                
                i += 1
                
                cell2.layer.borderWidth = 1
                cell2.layer.cornerRadius = 2
                
                
                return cell2
            }else{
            
                if (collectionView == bingoChart3CV){
                    print("Hoppas i är 50-74 ", String(i))
                    let cell3 = bingoChart3CV.dequeueReusableCell(withReuseIdentifier: reuseIdentifierChart3, for: indexPath as IndexPath) as! CVCell3Small
                    
          //              cell3.backgroundColor = .green
               
                k = 0
                if (i < 25){
                    k = i
                }
                if ((i > 24) && (i < 50)){
                    k = i - 25
                }
                if ((i > 49) && (i < 75)){
                    k = i - 50
                }
                    
                if (cellsThatAreGrayChart3[k] != 0){
                    cell3.backgroundColor = .systemGray
                }else{
                    cell3.backgroundColor = .green
                }
                
                for l in 0...24{
                    if (cellsThatAreGrayChart3[l] != 0){
                        print("jodå", String(l))
                        print("jodå", String(k))
                    }
                }
                
                    if (i < 75)
              //      if ((i > 50) && (i < 75))
                    {
                        test = i % 5
                        test2 = i / 5
                        test3 = test2*5+test
                        print("test3 ", String(test3))
                        if (((i) % 5) == 0){
                            print("test4 ", String(test4))
                            cell3.bingoChart3Label.text = String(BValues[test6])
                            for n in 0...6{
                                    if (BValues[test6] == ValuesToEvaluateB[n]){
                       //                 cell3.backgroundColor = .darkGray
                                        BChart3 += 1
                                        RowChart[test2] += 1
                                    }
                            }
                        }
                        if (((i) % 5) == 1){
                            cell3.bingoChart3Label.text = String(IValues[test6])
                            for n in 0...6{
                                    if (IValues[test6] == ValuesToEvaluateI[n]){
                      //                  cell3.backgroundColor = .darkGray
                                        IChart3 += 1
                                        RowChart[test2] += 1
                                    }
                            }
                        }
                        if (((i) % 5) == 2){
                            cell3.bingoChart3Label.text = String(NValues[test6])
                            for n in 0...6{
                                    if (NValues[test6] == ValuesToEvaluateN[n]){
                      //                  cell3.backgroundColor = .darkGray
                                        NChart3 += 1
                                        RowChart[test2] += 1
                                    }
                            }
                        }
                        if (((i) % 5) == 3){
                            cell3.bingoChart3Label.text = String(GValues[test6])
                            for n in 0...6{
                                    if (GValues[test6] == ValuesToEvaluateG[n]){
                        //                cell3.backgroundColor = .darkGray
                                        GChart3 += 1
                                        RowChart[test2] += 1
                                    }
                            }
                        }
                        if (((i) % 5) == 4){
                            cell3.bingoChart3Label.text = String(OValues[test6])
                            for n in 0...6{
                                    if (OValues[test6] == ValuesToEvaluateO[n]){
                       //                 cell3.backgroundColor = .darkGray
                                        OChart3 += 1
                                        RowChart[test2] += 1
                                    }
                            }
                            test6 += 1
                        }

                    }
                    
                    i += 1
                    
                    cell3.layer.borderWidth = 1
                    cell3.layer.cornerRadius = 2
                    
                    return cell3
                }else{
                    let cell4 = bingoPrevCV.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPrev, for: indexPath as IndexPath) as! CVCellBingoShowPrevSmall
                    
                    if (prevNumbersSmall[e] != 0){
                        cell4.showPrevValues.text = String(prevNumbersSmall[e])
                    }
                    e += 1
                    
                    cell4.layer.borderWidth = 1
                    cell4.layer.cornerRadius = 2
                    cell4.backgroundColor = .white
                    
                    return cell4
                }
            }
                
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == bingoChart1CV){
            let cell = collectionView.cellForItem(at: indexPath) as! CVCell1Small
            
            if ((cell.bingoChart1Label.text == showB.text) || (cell.bingoChart1Label.text == showI.text) || (cell.bingoChart1Label.text == showN.text) || (cell.bingoChart1Label.text == showG.text) || (cell.bingoChart1Label.text == showO.text)){
                cell.backgroundColor = .systemGray
    
                cellsThatAreGrayChart1[indexPath.row] = 1
            }else{
                for j in 0...35{
                    if (String(prevNumbersSmall[j]) == cell.bingoChart1Label.text){
                        cell.backgroundColor = .systemGray
                        cellsThatAreGrayChart1[indexPath.row] = 1
                    }
                }
            }
            
        }
        if (collectionView == bingoChart2CV){
            let cell = collectionView.cellForItem(at: indexPath) as! CVCell2Small
            
            if ((cell.bingoChart2Label.text == showB.text) || (cell.bingoChart2Label.text == showI.text) || (cell.bingoChart2Label.text == showN.text) || (cell.bingoChart2Label.text == showG.text) || (cell.bingoChart2Label.text == showO.text)){
                cell.backgroundColor = .systemGray
        
                cellsThatAreGrayChart2[indexPath.row] = 1
            }
            else{
                for j in 0...35{
                    if (String(prevNumbersSmall[j]) == cell.bingoChart2Label.text){
                        cell.backgroundColor = .systemGray
                        cellsThatAreGrayChart2[indexPath.row] = 1
                    }
                }
            }
            
        }
        if (collectionView == bingoChart3CV){
            let cell = collectionView.cellForItem(at: indexPath) as! CVCell3Small
            
            if ((cell.bingoChart3Label.text == showB.text) || (cell.bingoChart3Label.text == showI.text) || (cell.bingoChart3Label.text == showN.text) || (cell.bingoChart3Label.text == showG.text) || (cell.bingoChart3Label.text == showO.text)){
                cell.backgroundColor = .systemGray
         
                cellsThatAreGrayChart3[indexPath.row] = 1
            }
            else{
                for j in 0...35{
                    if (String(prevNumbersSmall[j]) == cell.bingoChart3Label.text){
                        cell.backgroundColor = .systemGray
                        cellsThatAreGrayChart3[indexPath.row] = 1
                    }
                }
            }
            
        }
        if (collectionView == bingoPrevCV){
 
           
        }
        
        checkIfBingo()
        if ((waitToTheLastToShowLooser) && walkfiniched()){
            self.proofOfWinnerAlert.isHidden = false
            self.winnerTV.isHidden = false
            self.winnerTV.text = "Deltagare " + WinnerIs + " har fått BINGO"
            proofOfWinnerAlert.text = "OBS! När du trycker NÄSTA så kan du inte se bingobrickorna igen"
        }
    }

    func checkIfBingo(){
        var countInRow1 = 0
        var countInRow2 = 0
        var countInRow3 = 0
        var countInRow4 = 0
        var countInRow5 = 0
        var weHaveAWinner = false
       

        for i in 0...4{
            if (cellsThatAreGrayChart1[i] != 0){
                countInRow1 += 1
            }
        }
        for i in 5...9{
            if (cellsThatAreGrayChart1[i] != 0){
                countInRow2 += 1
            }
        }
        for i in 10...14{
            if (cellsThatAreGrayChart1[i] != 0){
                countInRow3 += 1
            }
        }
        for i in 15...19{
            if (cellsThatAreGrayChart1[i] != 0){
                countInRow4 += 1
            }
        }
        for i in 20...24{
            if (cellsThatAreGrayChart1[i] != 0){
                countInRow5 += 1
            }
        }
        
        if ((countInRow1 == 5) || (countInRow2 == 5) || (countInRow3 == 5) || (countInRow4 == 5) || (countInRow5 == 5)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        countInRow1 = 0
        countInRow2 = 0
        countInRow3 = 0
        countInRow4 = 0
        countInRow5 = 0
        
        for i in 0...4{
            if (cellsThatAreGrayChart2[i] != 0){
                countInRow1 += 1
            }
        }
        for i in 5...9{
            if (cellsThatAreGrayChart2[i] != 0){
                countInRow2 += 1
            }
        }
        for i in 10...14{
            if (cellsThatAreGrayChart2[i] != 0){
                countInRow3 += 1
            }
        }
        for i in 15...19{
            if (cellsThatAreGrayChart2[i] != 0){
                countInRow4 += 1
            }
        }
        for i in 20...24{
            if (cellsThatAreGrayChart2[i] != 0){
                countInRow5 += 1
            }
        }
        
        if ((countInRow1 == 5) || (countInRow2 == 5) || (countInRow3 == 5) || (countInRow4 == 5) || (countInRow5 == 5)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        countInRow1 = 0
        countInRow2 = 0
        countInRow3 = 0
        countInRow4 = 0
        countInRow5 = 0
        
        for i in 0...4{
            if (cellsThatAreGrayChart3[i] != 0){
                countInRow1 += 1
            }
        }
        for i in 5...9{
            if (cellsThatAreGrayChart3[i] != 0){
                countInRow2 += 1
            }
        }
        for i in 10...14{
            if (cellsThatAreGrayChart3[i] != 0){
                countInRow3 += 1
            }
        }
        for i in 15...19{
            if (cellsThatAreGrayChart3[i] != 0){
                countInRow4 += 1
            }
        }
        for i in 20...24{
            if (cellsThatAreGrayChart3[i] != 0){
                countInRow5 += 1
            }
        }
        
        if ((countInRow1 == 5) || (countInRow2 == 5) || (countInRow3 == 5) || (countInRow4 == 5) || (countInRow5 == 5)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        /// column
        if ((cellsThatAreGrayChart1[0] != 0) && (cellsThatAreGrayChart1[5] != 0) && (cellsThatAreGrayChart1[10] != 0) && (cellsThatAreGrayChart1[15] != 0) && (cellsThatAreGrayChart1[20] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
         
        if ((cellsThatAreGrayChart1[0+1] != 0) && (cellsThatAreGrayChart1[5+1] != 0) && (cellsThatAreGrayChart1[10+1] != 0) && (cellsThatAreGrayChart1[15+1] != 0) && (cellsThatAreGrayChart1[20+1] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart1[0+2] != 0) && (cellsThatAreGrayChart1[5+2] != 0) && (cellsThatAreGrayChart1[10+2] != 0) && (cellsThatAreGrayChart1[15+2] != 0) && (cellsThatAreGrayChart1[20+2] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart1[0+3] != 0) && (cellsThatAreGrayChart1[5+3] != 0) && (cellsThatAreGrayChart1[10+3] != 0) && (cellsThatAreGrayChart1[15+3] != 0) && (cellsThatAreGrayChart1[20+3] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart1[0+4] != 0) && (cellsThatAreGrayChart1[5+4] != 0) && (cellsThatAreGrayChart1[10+4] != 0) && (cellsThatAreGrayChart1[15+4] != 0) && (cellsThatAreGrayChart1[20+4] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        ///
        
        if ((cellsThatAreGrayChart2[0] != 0) && (cellsThatAreGrayChart2[5] != 0) && (cellsThatAreGrayChart2[10] != 0) && (cellsThatAreGrayChart2[15] != 0) && (cellsThatAreGrayChart2[20] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
         
        if ((cellsThatAreGrayChart2[0+1] != 0) && (cellsThatAreGrayChart2[5+1] != 0) && (cellsThatAreGrayChart2[10+1] != 0) && (cellsThatAreGrayChart2[15+1] != 0) && (cellsThatAreGrayChart2[20+1] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart2[0+2] != 0) && (cellsThatAreGrayChart2[5+2] != 0) && (cellsThatAreGrayChart2[10+2] != 0) && (cellsThatAreGrayChart2[15+2] != 0) && (cellsThatAreGrayChart2[20+2] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart2[0+3] != 0) && (cellsThatAreGrayChart2[5+3] != 0) && (cellsThatAreGrayChart2[10+3] != 0) && (cellsThatAreGrayChart2[15+3] != 0) && (cellsThatAreGrayChart2[20+3] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart2[0+4] != 0) && (cellsThatAreGrayChart2[5+4] != 0) && (cellsThatAreGrayChart2[10+4] != 0) && (cellsThatAreGrayChart2[15+4] != 0) && (cellsThatAreGrayChart2[20+4] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        ///
         
        if ((cellsThatAreGrayChart3[0] != 0) && (cellsThatAreGrayChart3[5] != 0) && (cellsThatAreGrayChart3[10] != 0) && (cellsThatAreGrayChart3[15] != 0) && (cellsThatAreGrayChart3[20] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
         
        if ((cellsThatAreGrayChart3[0+1] != 0) && (cellsThatAreGrayChart3[5+1] != 0) && (cellsThatAreGrayChart3[10+1] != 0) && (cellsThatAreGrayChart3[15+1] != 0) && (cellsThatAreGrayChart3[20+1] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart3[0+2] != 0) && (cellsThatAreGrayChart3[5+2] != 0) && (cellsThatAreGrayChart3[10+2] != 0) && (cellsThatAreGrayChart3[15+2] != 0) && (cellsThatAreGrayChart3[20+2] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart3[0+3] != 0) && (cellsThatAreGrayChart3[5+3] != 0) && (cellsThatAreGrayChart3[10+3] != 0) && (cellsThatAreGrayChart3[15+3] != 0) && (cellsThatAreGrayChart3[20+3] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart3[0+4] != 0) && (cellsThatAreGrayChart3[5+4] != 0) && (cellsThatAreGrayChart3[10+4] != 0) && (cellsThatAreGrayChart3[15+4] != 0) && (cellsThatAreGrayChart3[20+4] != 0)){
            print("vinnare")
            weHaveAWinner = true
        }
        
        // diagonalerna
        if ((cellsThatAreGrayChart1[0] != 0) && (cellsThatAreGrayChart1[5+1] != 0) && (cellsThatAreGrayChart1[10+2] != 0) && (cellsThatAreGrayChart1[15+3] != 0) && (cellsThatAreGrayChart1[20+4] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart1[0+4] != 0) && (cellsThatAreGrayChart1[5+3] != 0) && (cellsThatAreGrayChart1[10+2] != 0) && (cellsThatAreGrayChart1[15+1] != 0) && (cellsThatAreGrayChart1[20+0] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart2[0] != 0) && (cellsThatAreGrayChart2[5+1] != 0) && (cellsThatAreGrayChart2[10+2] != 0) && (cellsThatAreGrayChart2[15+3] != 0) && (cellsThatAreGrayChart2[20+4] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart2[0+4] != 0) && (cellsThatAreGrayChart2[5+3] != 0) && (cellsThatAreGrayChart2[10+2] != 0) && (cellsThatAreGrayChart2[15+1] != 0) && (cellsThatAreGrayChart2[20+0] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart3[0] != 0) && (cellsThatAreGrayChart3[5+1] != 0) && (cellsThatAreGrayChart3[10+2] != 0) && (cellsThatAreGrayChart3[15+3] != 0) && (cellsThatAreGrayChart3[20+4] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
        
        if ((cellsThatAreGrayChart3[0+4] != 0) && (cellsThatAreGrayChart3[5+3] != 0) && (cellsThatAreGrayChart3[10+2] != 0) && (cellsThatAreGrayChart3[15+1] != 0) && (cellsThatAreGrayChart3[20+0] != 0)){
                print("vinnare")
            weHaveAWinner = true
        }
        
        if (weHaveAWinner){
            writeWinner()
        }
    }
    
    func writeWinner()
    {
        print("you are ", youAreplayer)
        self.ref.child("BingoPlayerWinner").child(BingoName).child("TheWinner").setValue(String(youAreplayer))
        
        
  //      self.ref.child("BingoPlayerWinner").child(BingoName).child("TheWinner").setValue("Deltagare " + String(youAreplayer) + "har fått BINGO")
    }
    
    func clearGrayCells(){
        cellsThatAreGrayChart1 = Array(repeating: 0, count: 25)
        cellsThatAreGrayChart2 = Array(repeating: 0, count: 25)
        cellsThatAreGrayChart3 = Array(repeating: 0, count: 25)
        prevNumbersSmall = Array(repeating: 0, count: 36)
    }
    
    
    @IBAction func backToMapBtn(_ sender: Any) {
     //   if (questionnumberInt == 12){
        if (walkfiniched()){
            // open up if they want to use quiz
            takeAwayButtonToChooseRunda = false
            questUserBingo = ""
            BingoName = ""
            waitToTheLastToShowLooser = false
            WinnerIs = ""
            performSegue(withIdentifier: "bingoBackToStartSmall", sender: 1)
        }else{
            performSegue(withIdentifier: "bingoBackToMapSmall", sender: 1)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //   if (questionnumberInt == 12){
        if (walkfiniched()){
            let dest = segue.destination as! ViewController
        }else{
            let dest = segue.destination as! VCGPSMap
            questionnumberInt += 1
            dest.questionnumberInt = questionnumberInt
            dest.quizname = quizname
            dest.BlockRender = false
        }
    }
}
