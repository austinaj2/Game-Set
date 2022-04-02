//
//  BalloonsController.swift
//  Game Set
//
//  Created by Yabby Yimer Wolle on 4/2/22.
//

import UIKit

class BalloonsController: UIViewController {

    var easy = Bool()
    var medium = Bool()
    var hard = Bool()
    let timeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 60))
    var timeCount = Int()
    var timer = Timer()
    
    override func viewDidLoad() {
        let bgImg = UIImage(named: "sky-background")
        let bgImageView = UIImageView(image: bgImg)
        print(bgImageView)
        bgImageView.frame = CGRect(x: 0, y: 70, width: self.view.bounds.width, height: self.view.bounds.height-70)
        bgImageView.addSubview(timeLabel)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        setTime()
        self.view.insertSubview(bgImageView, at: 0)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func timeFormatter(secs: Int) -> (Int, Int) {
        return ((secs%3600)/60, (secs%3600)%60)
    }
    func setTime() {
        timeLabel.text = "GO!"
        timeLabel.backgroundColor = .green
        timeLabel.textColor = .black
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.boldSystemFont(ofSize: 50)
    }
    func timeStringFormatter(formatted: (Int, Int)) -> String {
        let t = "\(formatted.0):\(String(format: "%02d", formatted.1))"
        return t
    }
    
    @objc func countdown() {
        let form = timeFormatter(secs: timeCount)
        let timeString = timeStringFormatter(formatted: form)
        if timeCount >= 0 {
            timeLabel.text = timeString
            timeCount += 1
        }
        else {
            timeLabel.text = timeString
            timer.invalidate()
            timeLabel.backgroundColor = .red
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
