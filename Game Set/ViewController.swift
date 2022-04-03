//
//  ViewController.swift
//  Game Set
//
//  Created by Yabby Yimer Wolle on 3/31/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var balloonsBtn: UIButton!
    @IBOutlet weak var memoryBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    var sortTF = false
    var memoryTF = false
    var balloonsTF = false
    var easyTF = false
    var mediumTF = false
    var hardTF = false
    var count = 0
    var allScores = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = UserDefaults.standard.integer(forKey: "count")
        if let scoreData = UserDefaults.standard.object(forKey: "scoreData") as? Data {
            allScores = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(scoreData) as! [Score]
            updateList()
        }
        // Do any additional setup after loading the view.
    }
    
    func updateList() {
        updateDatabase()
    }
    
    func updateDatabase(){
        
        //first convert to Data then save
        if let dataToSave = try? NSKeyedArchiver.archivedData(withRootObject: allScores, requiringSecureCoding: false)
        {
            UserDefaults.standard.set(dataToSave, forKey: "scoreData")
        }
        
    }
    
    @IBAction func sortClicked(_ sender: Any) {
        print("Sort")
        sortTF = true
        memoryTF = false
        balloonsTF = false
    }
    @IBAction func balloonsClicked(_ sender: Any) {
        print("Balloons")
        sortTF = false
        memoryTF = false
        balloonsTF = true
    }
    @IBAction func memoryClicked(_ sender: Any) {
        print("Memory")
        sortTF = false
        memoryTF = true
        balloonsTF = false
    }
    @IBAction func easyClicked(_ sender: Any) {
        print("Easy")
        easyTF = true
        mediumTF = false
        hardTF = false

    }
    @IBAction func mediumClicked(_ sender: Any) {
        print("Medium")
        easyTF = false
        mediumTF = true
        hardTF = false
    }
    @IBAction func hardClicked(_ sender: Any) {
        print("Hard")
        easyTF = false
        mediumTF = false
        hardTF = true
    }
    @IBAction func playClicked(_ sender: Any) {
        if((easyTF == true || mediumTF == true || hardTF == true) && (sortTF == true || memoryTF == true || balloonsTF == true)) {
            errorLabel.text = "Nice."
            if(memoryTF == true && easyTF == true || memoryTF == true && hardTF == true || memoryTF == true && mediumTF == true) {
                self.performSegue(withIdentifier: "toMemory", sender: self)
            }
            if(balloonsTF == true && easyTF == true || balloonsTF == true && hardTF == true || balloonsTF == true && mediumTF == true) {
                self.performSegue(withIdentifier: "toBalloons", sender: self)
            }
            easyTF = false
            mediumTF = false
            hardTF = false
            sortTF = false
            memoryTF = false
            balloonsTF = false
        }
        else {
            errorLabel.text = "Please select a game AND level of difficulty to continue!"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemory" {
            if let nextVC = segue.destination as? MemoryController {
                nextVC.easy = easyTF
                nextVC.medium = mediumTF
                nextVC.hard = hardTF
            }
        }
        if segue.identifier == "toBalloons" {
            if let nextVC = segue.destination as? BalloonsController {
                nextVC.easy = easyTF
                nextVC.medium = mediumTF
                nextVC.hard = hardTF
                
            }
        }
        if segue.identifier == "toBalloons" {
            if let nextVC = segue.destination as? BalloonsController {
                nextVC.easy = easyTF
                nextVC.medium = mediumTF
                nextVC.hard = hardTF
            }
        }
    }
}

