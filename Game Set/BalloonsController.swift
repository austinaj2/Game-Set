//
//  BalloonsController.swift
//  Game Set
//
//  Created by Yabby Yimer Wolle on 4/2/22.
//

import UIKit
import QuartzCore

class BalloonsController: UIViewController {

    var easy = Bool()
    var medium = Bool()
    var hard = Bool()
    var timeCount = Int()
    var points = [Int]()
    var balloons = [UIButton]()
    var balImages = [UIImage()]
    var timeLabel = UILabel()
    var timer = Timer()
    var randTen = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var randPos = [25, 125, 225, 325, 425, 525, 625, 725, 825, 925]
    var btn = UIButton()
    var newX = 25.0
    var count = 1
    var newY = 0
    let bgImageView = UIImageView(image: UIImage(named: "sky-background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel = UILabel(frame: CGRect(x: self.view.center.x-100, y: 10, width: 200, height: 60))
        newY = (Int(self.view.frame.maxY)-100)
        var count = 1
        while balImages.count<=10 {
            let i = UIImage(named: "color\(count)")
            points.append(count)
            print(i!)
            if !(i==UIImage()) {
                balImages.append(i!)
            }
            count+=1
        }
        bgImageView.tag = 11
        balImages.remove(at: 0)
        // Do any additional setup after loading the view.
        bgImageView.frame = CGRect(x: 0, y: 70, width: self.view.bounds.width, height: self.view.bounds.height-70)
        bgImageView.addSubview(timeLabel)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        setTime()
        self.view.insertSubview(bgImageView, at: 0)
    }
    
    func timeFormatter(secs: Int) -> (Int, Int) {
        return ((secs%3600)/60, (secs%3600)%60)
    }
    func setTime() {
        timeLabel.text = "GO!"
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
            if easy == true {
                for i in 0...1 {
                    makeBalloons()
                    animate()
                    count+=1
                }
            }
            if medium == true {
                for i in 0...2 {
                    makeBalloons()
                    animate()
                    count+=1
                }            }
            if hard == true {
                for i in 0...3 {
                    makeBalloons()
                    animate()
                    count+=1
                }            }
        }
        else {
            timeLabel.text = timeString
            timer.invalidate()
            timeLabel.backgroundColor = .red
        }
    }
    
    func makeBalloons() {
//        balImages.remove(at: 0)
//        while balloons.count<10 {
        let rImg = balImages.randomElement()
        let rNum = points.randomElement()
        let rPos = randPos.randomElement()
        btn = UIButton(frame: CGRect(x: rPos!, y: (Int(self.view.frame.maxY)), width: 75, height: 75))
        btn.setBackgroundImage(rImg, for: .normal)
        btn.setTitle("\(rNum!)", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 25)
        btn.addTarget(self, action: #selector(touchesBegan), for: .touchUpInside)
        btn.tag = count
        manageButtons()
        self.view.addSubview(btn)

//            balloons.append(btn)
//            balImages.remove(at: balImages.firstIndex(of: rImg!)!)
//            points.remove(at: points.firstIndex(of: rNum!)!)
//            newX += 100
//        }
//        for i in balloons {
//            // checking for balloons made
//            self.view.addSubview(i)
//            print("\(balloons.firstIndex(of: i)): \(i)")
//        }
    }
    
    func manageButtons() {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches)
        let touch = touches.first
        let touchLoc = touch?.location(in: self.view)
        print(touchLoc)
        if self.view.layer.presentation()?.hitTest(touchLoc!) != nil {
            print("touched!!")
        }
        else {
            
        }
    }
    
    func animate() {
        let rand = self.view.subviews.randomElement()
        if rand?.tag != 11  {
            UIView.animate(withDuration: 3, delay: 1, options: [UIView.AnimationOptions.curveEaseIn], animations: {
                rand?.frame = CGRect(x: (rand?.frame.origin.x)!, y: self.view.frame.minY+70, width: rand?.frame.width ?? 0, height: rand?.frame.height ?? 0)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {                    rand?.frame = CGRect(x: (rand?.frame.origin.x)!, y: self.view.frame.minY-75, width: rand?.frame.width ?? 0, height: rand?.frame.height ?? 0)
                    rand?.alpha = 0.0
                })
            })
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
