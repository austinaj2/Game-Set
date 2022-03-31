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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        }
        else {
            errorLabel.text = "Please select a game AND level of difficulty to continue!"
        }
    }
}

