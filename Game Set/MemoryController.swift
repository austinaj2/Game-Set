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
    var images = [UIImageView]()
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
            stackedGrid(rows: 5, columns: 4, start: 50, size: 150)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func stackedGrid(rows: Int, columns: Int, start: Double, size: Double){
        var newY = 0.0
        var newX = start
        for i in 0..<columns {
            let v = UIImageView(image: UIImage(named: "question"))
            v.frame = CGRect(x: newX, y: newY, width: size, height: size)
            let button = UIButton(frame: CGRect(origin: v.bounds.origin, size: CGSize(width: v.frame.width, height: v.frame.height)))
            button.tag = images.count
            print(images.count)
            button.addTarget(self, action: #selector(questionClicked), for: .touchUpInside)
            v.insertSubview(button, aboveSubview: v)
            button.backgroundColor = UIColor.red
            images.append(v)
            for l in 0..<rows {
                let v = UIImageView(image: UIImage(named: "question"))
                v.frame = CGRect(x: newX, y: newY, width: size, height: size)
                let button = UIButton(frame: CGRect(origin: v.bounds.origin, size: CGSize(width: v.frame.width, height: v.frame.height)))
                button.tag = images.count
                button.addTarget(self, action: #selector(questionClicked), for: .touchUpInside)
                print(images.count)
                v.insertSubview(button, aboveSubview: v)
                images.append(v)
                newX += size
            }
            newY += size
            newX = start
        }
        for j in 0..<images.count {
            outView.addSubview(images[j])
        }
        for i in images {
            print(i.subviews[0])
        }
    }
    @objc func questionClicked(sender: UIButton) {
        print("Clicked \(sender.tag)")
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
