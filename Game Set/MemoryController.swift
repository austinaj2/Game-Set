//
//  MemoryController.swift
//  Game Set
//
//  Created by Yabby Yimer Wolle on 3/31/22.
//

import UIKit

class MemoryController: UIViewController {
    
    let outView = UIView(frame: CGRect(x: 100, y: 100, width: 825, height: 600))
    let v = UIImageView(image: UIImage(named: "question"))
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outView.backgroundColor = UIColor.red
        self.view.addSubview(outView)
        
        var newY = 0
        var newX = 0
        v.frame = CGRect(x: newX, y: newY, width: 100, height: 100)
        for i in 0...3 {
            v.frame = CGRect(x: newX, y: newY, width: 100, height: 100)
            images.append(v)
            newY += 100
        }
        for j in 0..<images.count {
            outView.addSubview(images[j])
        }
//        for i in 0...3 {
//            images.append(v)
//            newY += 100
//        }
//        for i in 0...3 {
//            self.view.insertSubview(images[i], aboveSubview: self.view)
//        }
        // Do any additional setup after loading the view.
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
