//
//  GrainIngredientCell.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/3/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import UIKit

class IngredientGrainCell: UITableViewCell{
    @IBOutlet weak var srmLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    @IBOutlet weak var grainIcon: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    public func configureCell(grain: Grains){
        let cd = ColorDecider()
        let image: UIImage = cd.colorDecider(grain: grain)
        if grain.isExtract{
            typeLabel.text = "Extract/Sugar"
        }else{typeLabel.text = "Grain"}
        self.grainIcon.contentMode = UIViewContentMode.scaleToFill
        self.grainIcon.image = image
        self.nameLabel.text = grain.name
        self.ppgLabel.text = NSString(format: "%.1f", grain.ppg) as String
        self.srmLabel.text = NSString(format: "%.1f", grain.srm) as String
    }
}
