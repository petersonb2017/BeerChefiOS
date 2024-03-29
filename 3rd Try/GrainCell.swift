//
//  File.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/3/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

class GrainCell: UITableViewCell{
    @IBOutlet weak var srmLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    @IBOutlet weak var grainIcon: UIImageView!
    
    public func configureCell(grain: Grains, weight: Double){
        let cd = ColorDecider()
        let image: UIImage = cd.colorDecider(grain: grain)
        self.grainIcon.contentMode = UIViewContentMode.scaleToFill
        self.grainIcon.image = image
        self.nameLabel.text = grain.name
        self.ppgLabel.text = NSString(format: "%.1f", grain.ppg) as String
        self.srmLabel.text = NSString(format: "%.1f", grain.srm) as String
        self.weightLabel.text = NSString(format: "%.2f", weight) as String

    }
    
    public func configureCell(grain: TempGrain){
        let cd = ColorDecider()
        let image: UIImage = cd.colorDecider(grain: grain.grain)
        self.grainIcon.contentMode = UIViewContentMode.scaleToFill
        self.grainIcon.image = image
        self.nameLabel.text = grain.grain.name
        self.ppgLabel.text = NSString(format: "%.1f", grain.grain.ppg) as String
        self.srmLabel.text = NSString(format: "%.1f", grain.grain.srm) as String
        self.weightLabel.text = NSString(format: "%.2f", grain.weight) as String
        
    }
}
