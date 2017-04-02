//
//  File4.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/3/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//
import Foundation
import UIKit

class IngredientYeastCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    public func configureCell(yeast: Yeasts){
        tempLabel.text = "\(yeast.fermTempLow)-\(yeast.fermTempHigh)"
        self.nameLabel.text = yeast.name
    }
}
