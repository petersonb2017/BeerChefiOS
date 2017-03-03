//
//  IngredientHopCell.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/3/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import UIKit

class IngredientHopCell: UITableViewCell{
    @IBOutlet weak var aaLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    public func configureCell(hop: Hops){
        self.nameLabel.text = hop.name
        self.aaLabel.text = NSString(format: "%.1f", hop.aa) as String
    }
    
}
