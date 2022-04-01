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
    var easy = Bool()
    var medium = Bool()
    var hard = Bool()
    
    override func viewDidLoad() {
        let bgImg = UIImage(named: "background")
        let bgImageView = UIImageView(image: bgImg)
        bgImageView.frame = CGRect(x: 0, y: 70, width: self.view.bounds.width, height: self.view.bounds.height-70)
        outView.bounds.origin = CGPoint(x: bgImageView.bounds.origin.x, y: bgImageView.bounds.origin.y)
//        outView.backgroundColor = UIColor.red
        self.view.insertSubview(bgImageView, at: 0)
        super.viewDidLoad()
        self.view.addSubview(outView)
        if(easy == true) {
            stackedGrid(rows: 4, columns: 3, start: 70, size: 175)
        }
        if(medium == true) {
            stackedGrid(rows: 4, columns: 4, start: 100, size: 150)
        }
        if(hard == true) {
            stackedGrid(rows: 5, columns: 4, start: 40, size: 150)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func stackedGrid(rows: Int, columns: Int, start: Double, size: Double){
        var newY = 0.0
        var newX = start
        for i in 0..<columns {
            let btn = UIButton(frame: CGRect(x: newX, y: newY, width: size, height: size))
            btn.setBackgroundImage(UIImage(named: "question"), for: .normal)
            questions.append(btn)
//            btn.tag = questions.count
            print(questions.count)
            
            for l in 0..<rows-1 {
                newX += size
                let btn = UIButton(frame: CGRect(x: newX, y: newY, width: size, height: size))
                btn.setBackgroundImage(UIImage(named: "question"), for: .normal)
//                btn.tag = questions.count
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
        secondImageView()
        for i in 0..<questions.count {
            questions[i].tag = count
            questions[i].addTarget(self, action: #selector(questionClicked), for: .touchUpInside)
            count+=1
        }
    }
    @objc func questionClicked(sender: UIButton) {
        print("Clicked \(sender.tag)")
        print(questions[sender.tag-1])
        questions[sender.tag-1].subviews[0].alpha = 1.0        
    }
    
    func secondImageView() {
        for i in questions {
            let imgBtn = UIButton(frame: i.frame)
            imgBtn.setBackgroundImage(UIImage(named: "1"), for: .normal)
            imgBtn.alpha = 0.0
            i.addSubview(imgBtn)
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
