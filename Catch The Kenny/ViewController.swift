//
//  ViewController.swift
//  Catch The Kenny
//
//  Created by Pinakpani Mukherjee on 2021/11/25.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny10: UIImageView!
    @IBOutlet weak var kenny11: UIImageView!
    @IBOutlet weak var kenny12: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check for highscore
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score:\(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score:\(highScore)"
        }
        
        scoreLabel.text = "Score:\(score)"
         
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        kenny10.isUserInteractionEnabled = true
        kenny11.isUserInteractionEnabled = true
        kenny12.isUserInteractionEnabled = true
        
        //Images
 
        let recognizer1 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer12  = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        kenny10.addGestureRecognizer(recognizer10)
        kenny11.addGestureRecognizer(recognizer11)
        kenny12.addGestureRecognizer(recognizer12)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9,kenny10,kenny11,kenny12]
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(hideImages), userInfo: nil, repeats: true)
    }
    @objc func hideImages(){
        let randomNum = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        for image in kennyArray{
            image.isHidden = true
        }
        kennyArray[randomNum].isHidden = false
    }

    @objc func increaseScore(){
        score = score + 1
        scoreLabel.text = "Score:\(score)"
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "High Score:\(self.highScore)"
                UserDefaults.standard.set(self.highScore,forKey: "highscore")
            }
            
            //Alert
            let alert = UIAlertController(title: "Times Up!!!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay func
                self.score = 0
                self.scoreLabel.text = "Score:\(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(self.hideImages), userInfo: nil, repeats: true)

                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert,animated: true, completion: nil)
        }
    }


}

