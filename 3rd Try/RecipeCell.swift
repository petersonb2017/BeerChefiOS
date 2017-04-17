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

class RecipeCell: UITableViewCell{
    
    @IBOutlet weak var recipeIBULabel: UILabel!
    @IBOutlet weak var recipeYeastNameLabel: UILabel!
    @IBOutlet weak var recipeOGLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeThumbNail: UIImageView!
    @IBOutlet weak var recipeSRMLabel: UILabel!
    
    func configureCell(recipe: Recipes){
        
        let yeast = (recipe.containsYeast?.allObjects as! [Yeasts]).first
        let cd = ColorDecider()
 
        recipeThumbNail.contentMode = UIViewContentMode.scaleToFill
        recipeThumbNail.image = cd.colorDecider(recipe: recipe)
        recipeTitleLabel?.text = recipe.name
        recipeYeastNameLabel.text = yeast?.name
        recipeOGLabel?.text = NSString(format: "%.3f", recipe.calcOG()) as String
        recipeIBULabel?.text = NSString(format: "%.1f", recipe.calcIBU()) as String
        recipeSRMLabel?.text = NSString(format: "%.1f", recipe.calcSRM()) as String
        self.backgroundColor = UIColor.clear

    }
}

