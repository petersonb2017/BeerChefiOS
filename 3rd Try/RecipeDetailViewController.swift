//
//  RecipeDetailViewController.swift
//  BeerChef
//
//  Created by Bailey Peterson on 4/4/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipes = Recipes()

    @IBOutlet weak var recipeDetailScrollView: UIScrollView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeInfoLabel: UILabel!
    @IBOutlet weak var recipeOGLabel: UILabel!
    @IBOutlet weak var recipeFGLabel: UILabel!
    @IBOutlet weak var recipeABVLabel: UILabel!
    @IBOutlet weak var recipeSRMLabel: UILabel!
    @IBOutlet weak var recipeBatchSizeLabel: UILabel!
    @IBOutlet weak var yeastNameLabel: UILabel!
    @IBOutlet weak var recipeEffLabel: UILabel!
    @IBOutlet weak var grainNameStack: UIStackView!
    @IBOutlet weak var grainWeightStack: UIStackView!
    @IBOutlet weak var hopNameStack: UIStackView!
    
    @IBOutlet weak var statStack: UIStackView!
    
    @IBOutlet weak var hopAAStack: UIStackView!
    @IBOutlet weak var hopWeightStack: UIStackView!
    
    @IBOutlet weak var hopTimeStack: UIStackView!
    
    var fontName:String = String()
    var containsPellet = false
    var containsExtract = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontName = recipeFGLabel.font.fontName
        
        configureAllLabels()
        recipeNameLabel.text = recipe.name
        recipeFGLabel.text = NSString(format: "%.3f", recipe.calcFG()) as String
        recipeSRMLabel.text = NSString(format: "%.1f", recipe.calcSRM()) as String
        recipeOGLabel.text = NSString(format: "%.3f", recipe.calcOG()) as String
        recipeABVLabel.text = NSString(format: "%.1f", recipe.calcABV()) as String
        recipeBatchSizeLabel.text = NSString(format: "%.1f", recipe.batchSize) as String
        recipeEffLabel.text = NSString(format: "%.1f", 100.0*recipe.efficiency) as String
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureAllLabels(){
        let frameWidth = recipeDetailScrollView.frame.width
        
        var grains = recipe.containsGrain?.allObjects as! [GrainWithWeight]
        grains.sort(by: {$0.weight > $1.weight})
        
        var hops = recipe.containsHop?.allObjects as! [HopWithWeight]
        hops.sort(by: {$0.time > $1.time})
        
        let yeast: Yeasts = (recipe.containsYeast?.allObjects as! [Yeasts]).first!
        
        let grainNameHeading = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth/2, height: 25))
        grainNameHeading.font = UIFont(name: fontName, size: 17)
        grainNameHeading.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        grainNameHeading.textAlignment = .left
        let grainNameHeadingText = NSMutableAttributedString(string: "Fermentables")
        grainNameHeadingText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, 12))
        grainNameHeading.attributedText = grainNameHeadingText
        grainNameStack.addArrangedSubview(grainNameHeading)
        
        let grainWeightHeading = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth/2, height: 25))
        grainWeightHeading.font = UIFont(name: fontName, size: 17)
        grainWeightHeading.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        grainWeightHeading.textAlignment = .center
        let grainHeadingText = NSMutableAttributedString(string: "lbs")
        grainHeadingText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, 3))
        grainWeightHeading.attributedText = grainHeadingText
        grainWeightStack.addArrangedSubview(grainWeightHeading)
        
        let hopNameHeading = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth/2, height: 25))
        hopNameHeading.font = UIFont(name: fontName, size: 17)
        hopNameHeading.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        hopNameHeading.textAlignment = .left
        let hopHeadingText = NSMutableAttributedString(string: "Hops")
        hopHeadingText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, 4))
        hopNameHeading.attributedText = hopHeadingText
        hopNameStack.addArrangedSubview(hopNameHeading)
        
        let hopAAHeading = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth*(1/6), height: 25))
        hopAAHeading.font = UIFont(name: fontName, size: 17)
        hopAAHeading.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        hopAAHeading.textAlignment = .center
        let hopAAHeadingText = NSMutableAttributedString(string: "AA")
        hopAAHeadingText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, 2))
        hopAAHeading.attributedText = hopAAHeadingText
        hopAAStack.addArrangedSubview(hopAAHeading)
        
        let hopTimeHeading = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth*(1/6), height: 25))
        hopTimeHeading.font = UIFont(name: fontName, size: 17)
        hopTimeHeading.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        hopTimeHeading.textAlignment = .center
        let hopTimeHeadingText = NSMutableAttributedString(string: "min")
        hopTimeHeadingText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, 3))
        hopTimeHeading.attributedText = hopTimeHeadingText
        hopTimeStack.addArrangedSubview(hopTimeHeading)
        
        let hopWeightHeading = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth*(1/6), height: 25))
        hopWeightHeading.font = UIFont(name: fontName, size: 17)
        hopWeightHeading.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        hopWeightHeading.textAlignment = .center
        let hopWeightHeadingText = NSMutableAttributedString(string: "oz")
        hopWeightHeadingText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, 2))
        hopWeightHeading.attributedText = hopWeightHeadingText
        hopWeightStack.addArrangedSubview(hopWeightHeading)
        
        for grain in grains{
            let name = grain.name
            let weight = String(grain.weight)
            
            let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth/2, height: 25))
            nameLabel.font = UIFont(name: fontName, size: 17)
            nameLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            nameLabel.textAlignment = .center
            if grain.isExtract{
                let attString:NSMutableAttributedString = NSMutableAttributedString(string: "\(grain.name!)e")
                attString.addAttribute(NSBaselineOffsetAttributeName, value: 10, range: NSRange(location: (name?.characters.count)!, length: 1))
                attString.addAttribute(NSFontAttributeName, value: UIFont(name: fontName, size: 10)!, range: NSRange(location: (name?.characters.count)!, length: 1))
                nameLabel.attributedText = attString;
                containsExtract = true
            }else{
            nameLabel.text = name
            }
            grainNameStack.addArrangedSubview(nameLabel)
            
            let weightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth/2, height: 25))
            weightLabel.font = UIFont(name: fontName, size: 17)
            weightLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            weightLabel.textAlignment = .center
            weightLabel.text = weight
            grainWeightStack.addArrangedSubview(weightLabel)
            
            
        }
        
        for hop in hops {
            let name = hop.name
            let aa = String(hop.aa)
            let time = String(hop.time)
            let weight = String(hop.weight)
            
            let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth/2, height: 25))
            nameLabel.font = UIFont(name: fontName, size: 17)
            nameLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            nameLabel.textAlignment = .center
            nameLabel.text = name
            if hop.pellet{
                let attString:NSMutableAttributedString = NSMutableAttributedString(string: "\(hop.name!)p")
                attString.addAttribute(NSBaselineOffsetAttributeName, value: 10, range: NSRange(location: (name?.characters.count)!, length: 1))
                attString.addAttribute(NSFontAttributeName, value: UIFont(name: fontName, size: 10)!, range: NSRange(location: (name?.characters.count)!, length: 1))
                nameLabel.attributedText = attString;
                containsPellet = true
            }else{
                nameLabel.text = name
            }
            hopNameStack.addArrangedSubview(nameLabel)
            
            let aaLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth*(1/6), height: 25))
            aaLabel.font = UIFont(name: fontName, size: 17)
            aaLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            aaLabel.textAlignment = .center
            aaLabel.text = aa
            hopAAStack.addArrangedSubview(aaLabel)
            
            let timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth*(1/6), height: 25))
            timeLabel.font = UIFont(name: fontName, size: 17)
            timeLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            timeLabel.textAlignment = .center
            timeLabel.text = time
            hopTimeStack.addArrangedSubview(timeLabel)
            
            let weightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth*(1/6), height: 25))
            weightLabel.font = UIFont(name: fontName, size: 17)
            weightLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            weightLabel.textAlignment = .center
            weightLabel.text = weight
            hopWeightStack.addArrangedSubview(weightLabel)
            
        }
        yeastNameLabel.text = yeast.name
        recipeInfoLabel.text = recipe.info
        if containsExtract && containsPellet{
            let extractAppenLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth-10, height: 25))
            extractAppenLabel.font = UIFont(name: fontName, size: 12)
            extractAppenLabel.numberOfLines = 2
            extractAppenLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            extractAppenLabel.textAlignment = .left
            extractAppenLabel.text = "   e: Is Extract or Sugar\n   p: Is Pellet Form"
            statStack.addArrangedSubview(extractAppenLabel)

        } else {
            
            if containsExtract{
                let extractAppenLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth-10, height: 20))
                extractAppenLabel.font = UIFont(name: fontName, size: 12)
                extractAppenLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
                extractAppenLabel.textAlignment = .left
                extractAppenLabel.text = "   e: Is Extract or Sugar"
                statStack.addArrangedSubview(extractAppenLabel)
            }
            if containsPellet{
                let extractAppenLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth-10, height: 20))
                extractAppenLabel.font = UIFont(name: fontName, size: 12)
                extractAppenLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
                extractAppenLabel.textAlignment = .left
                extractAppenLabel.text = "   p: Is Pellet Form"
                statStack.addArrangedSubview(extractAppenLabel)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
