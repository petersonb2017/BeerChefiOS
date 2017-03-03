//
//  File1.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/3/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore


class HopCell: UITableViewCell{
    @IBOutlet weak var aaLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    public func configureCell(hop: Hops, weight: Double, time: Int){
        self.nameLabel.text = hop.name
        self.aaLabel.text = NSString(format: "%.1f", hop.aa) as String
        self.timeLabel.text = NSString(format: "%d", time) as String
        self.weightLabel.text = NSString(format: "%.2f", weight) as String
    }
    
}
