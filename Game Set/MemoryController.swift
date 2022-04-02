//
//  MemoryController.swift
//  Game Set
//
//  Created by Yabby Yimer Wolle on 3/31/22.
//

import UIKit

class MemoryController: UIViewController {
    
    let outView = UIView(frame: CGRect(x: 100, y: 150, width: 825, height: 600))
    let v = UIImageView(image: UIImage(named: "question"))
    var questions = [UIButton]()
    let timeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 60))
    var easy = Bool()
    var medium = Bool()
    var hard = Bool()
    var tapCount = 0
    var taps = [UIView(), UIView()]
    var tags = [0, 0]
    var timer = Timer()
    var timeCount = Int()
    
    override func viewDidLoad() {
        let bgImg = UIImage(named: "background")
        let bgImageView = UIImageView(image: bgImg)
        bgImageView.frame = CGRect(x: 0, y: 70, width: self.view.bounds.width, height: self.view.bounds.height-70)
        outView.bounds.origin = CGPoint(x: bgImageView.bounds.origin.x, y: bgImageView.bounds.origin.y)
//        outView.backgroundColor = UIColor.red
        bgImageView.addSubview(timeLabel)
        bgImageView.alpha = 0.5
        setTime()
        self.view.insertSubview(bgImageView, at: 0)
        super.viewDidLoad()
        self.view.addSubview(outView)
        if(easy == true) {
            timeCount = 120
            stackedGrid(rows: 4, columns: 3, start: 70, size: 175, pairs: 6)
        }
        if(medium == true) {
            timeCount = 105
            stackedGrid(rows: 4, columns: 4, start: 100, size: 150, pairs: 8)
        }
        if(hard == true) {
            timeCount = 90
            stackedGrid(rows: 5, columns: 4, start: 40, size: 150, pairs: 10)
        }
    
        
        // Do any additional setup after loading the view.
    }
    
    func timeFormatter(secs: Int) -> (Int, Int) {
        return ((secs%3600)/60, (secs%3600)%60)
    }
    func setTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
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
        if timeCount > 0 {
            timeLabel.text = timeString
            timeLabel.backgroundColor = .green
            timeCount -= 1
        }
        else {
            timeLabel.text = timeString
//            timer.invalidate()
            timeLabel.backgroundColor = .red
            let alert = UIAlertController(title: "GAME OVER!", message: "Sorry, time's up! Would you like to try again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                self.timer.invalidate()
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                if self.easy == true {
                    self.timeCount = 120
                }
                if self.medium == true {
                    self.timeCount = 105
                }
                if self.hard == true {
                    self.timeCount = 90
                }
                for k in self.questions {
                    k.subviews[1].alpha = 1.0
                }
            }))
            present(alert, animated: true)
            if timeCount > 0 {
                setTime()
            }
        }
    }
    
    func stackedGrid(rows: Int, columns: Int, start: Double, size: Double, pairs: Int){
        var newY = 0.0
        var newX = start
        var rands = [Int]()
        while(rands.count<pairs) {
            let r = Int.random(in: 1...10)
            if(rands.contains(r)==false) {
                rands.append(r)
            }
        }
        var mock = rands
        var randEl = Int()
        while(rands.count<pairs*2) {
            if mock.count>0 {
                randEl = mock.randomElement()!
                rands.append(randEl)
            }
            mock.remove(at: mock.firstIndex(of: randEl)!)
        }
        print(rands)
        var r = Int()
        var btn = UIButton()
        for i in 0..<columns {
            btn = UIButton(frame: CGRect(x: newX, y: newY, width: size, height: size))
            if rands.count>0 {
                r = rands.randomElement()!
                btn.setBackgroundImage(UIImage(named: "\(r)"), for: .normal)
            }
            rands.remove(at: rands.firstIndex(of: r)!)
            questions.append(btn)
            print(questions.count)
            
            for l in 0..<rows-1 {
                newX += size
                btn = UIButton(frame: CGRect(x: newX, y: newY, width: size, height: size))
                if rands.count>0 {
                    r = rands.randomElement()!
                    btn.setBackgroundImage(UIImage(named: "\(r)"), for: .normal)
                }
                rands.remove(at: rands.firstIndex(of: r)!)
                print(questions.count)
                questions.append(btn)
            }
            newY += size
            newX = start
        }
        for j in 0..<questions.count {
            outView.addSubview(questions[j])
            
        }
        var count = 1
        for i in 0..<questions.count {
            questions[i].tag = count
//            questions[i].addTarget(self, action: #selector(itemClicked), for: .touchUpInside)
            secondImageView(t: count)
            count+=1
        }
    }
    @objc func questionClicked(sender: UIButton) {
        print("QQQClicked \(sender.tag)")
        print(questions[sender.tag-1])
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            self.questions[sender.tag-1].subviews[1].alpha = 0.0
        }, completion: { _ in
            //self.img.image = secondImage.image
            //secondImage.removeFromSuperview()
        })
        tapCount+=1
        if tapCount == 1 {
            taps[tapCount-1] = questions[sender.tag-1].subviews[0]
            tags[tapCount-1] = questions[sender.tag-1].tag
        }
        if tapCount == 2 {
            taps[tapCount-1] = questions[sender.tag-1].subviews[0]
            tags[tapCount-1] = questions[sender.tag-1].tag
            if !(tags[0]==0) && !(tags[1]==0) {
                print("Just looking...")
                print("Before: \(tags), \(taps)")
                if taps[0].largeContentImage==taps[1].largeContentImage {
                    print("MATCH!!")
                }
                else {
                    print("No match :(")
                    UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
                        for s in self.questions {
                            print("Fading out: \(self.tags)")
                            if s.tag == self.tags[0] {
                                s.subviews[1].alpha = 1.0
                            }
                            if s.tag == self.tags[1] {
                                s.subviews[1].alpha = 1.0
                            }
                        }
                    }, completion: { _ in
                        //self.img.image = secondImage.image
                        //secondImage.removeFromSuperview()
                    })
                }
            }
            tapCount = 0
            taps[0] = UIView()
            taps[1] = UIView()
            tags[0] = 0
            tags[1] = 0
            print("After: \(tags), \(taps)")

        }
        var all = true
        for k in questions {
            if k.subviews[1].alpha != 0.0 {
                all = false
            }
        }
        if all == true {
            print("DONE!")
            let alert = UIAlertController(title: "Congratulations!", message: "You won! Do you want to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                print("Purchase cancelled.")
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.timeCount = 120
                for k in self.questions {
                    k.subviews[1].alpha = 1.0
                    all = false
                }
            }))
            present(alert, animated: true)
        }
    }
//    @objc func itemClicked(sender: UIButton) {
//        print("IIIIClicked \(sender.tag)")
//        print(questions[sender.tag-1])
//        print(questions[sender.tag-1].subviews[0].largeContentImage)
//        UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: {
//            self.questions[sender.tag-1].subviews[1].alpha = 1.0
//        }, completion: { _ in
//            //self.img.image = secondImage.image
//            //secondImage.removeFromSuperview()
//        })
//    }
    
    func secondImageView(t: Int) {
            let imgBtn = UIButton(frame: CGRect(origin: questions[t-1].bounds.origin, size: CGSize(width: questions[t-1].frame.width, height: questions[t-1].frame.height)))
            imgBtn.setBackgroundImage(UIImage(named: "question"), for: .normal)
            imgBtn.isHidden = false
            imgBtn.tag = t
            imgBtn.addTarget(self, action: #selector(questionClicked), for: .touchUpInside)
            questions[t-1].addSubview(imgBtn)
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
