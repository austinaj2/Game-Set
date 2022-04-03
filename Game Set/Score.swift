//
//  Score.swift
//  Game Set
//
//  Created by Yabby Yimer Wolle on 4/2/22.
//

import Foundation

class Score: NSObject, NSCoding {
    
    var date: Date
    var label: String
    
    init(date: Date, score: Int, label: String) {
        self.date = date
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        let dateString = formatter.string(from: date)
        let s = "Score: \(score) --- \(dateString)"
        self.label = s
    }
    
    func encode(with coder: NSCoder)
    {
        coder.encode(date, forKey: "date")
        coder.encode(label, forKey: "label")
    }
    
    // used when read (decoded) from user defaults
    required init?(coder: NSCoder)
    {
        date = coder.decodeObject(forKey: "date") as! Date
        label = coder.decodeObject(forKey: "label") as! String
        
    }
}
