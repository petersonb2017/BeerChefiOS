//
//  AddNewIngredientViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/22/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData

class AddNewIngredientViewController: UIViewController{
    
    @IBOutlet weak var newGrainName: UITextField!
    @IBOutlet weak var newGrainPPG: UITextField!
    @IBOutlet weak var newGrainSRM: UITextField!
    @IBOutlet weak var newHopName: UITextField!
    @IBOutlet weak var newHopAA: UITextField!
    @IBOutlet weak var newHopForm: UISegmentedControl!
    @IBOutlet weak var newYeastName: UITextField!
    @IBOutlet weak var newYeastAttenLow: UITextField!
    @IBOutlet weak var newYeastAttenHigh: UITextField!
    @IBOutlet weak var newYeastFermLow: UITextField!
    @IBOutlet weak var newYeastFermHigh: UITextField!
    
    @IBAction func addGrain(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if newGrainName.text == "" || Double(newGrainPPG.text!) == nil || Double(newGrainSRM.text!) == nil{
            let alertController = UIAlertController(title: "Grain Added", message: "You entered an invalid Grain", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{ if let grain = NSEntityDescription.insertNewObject(forEntityName: "Grains", into: moc!) as? Grains{
            grain.name = newGrainName.text!
            grain.ppg = Double(newGrainPPG.text!)!
            grain.srm = Double(newGrainSRM.text!)!
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let alertController = UIAlertController(title: "Grain Added", message: "Name: \(newGrainName.text!) \r\nPPG: \(newGrainPPG.text!) \r\nSRM: \(newGrainSRM.text!)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        newGrainName.text = ""
        newGrainPPG.text = ""
        newGrainSRM.text = ""
    }
    
    @IBAction func addHop(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        if let hop = NSEntityDescription.insertNewObject(forEntityName: "Hops", into: moc!) as? Hops{
            hop.name = newHopName.text!
            hop.aa = Double(newHopAA.text!)!
            hop.pellet = newHopForm.isEnabledForSegment(at: 0)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        newHopName.text = ""
        newHopAA.text = ""
    }
    
    @IBAction func addYeast(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        if let yeast = NSEntityDescription.insertNewObject(forEntityName: "Yeasts", into: moc!) as? Yeasts{
            yeast.name = newYeastName.text!
            yeast.fermTempLow = Int16(Double(newYeastFermLow.text!)!)
            yeast.fermTempHigh = Int16(Double(newYeastFermHigh.text!)!)
            yeast.attenLow = Int16(Double(newYeastAttenLow.text!)!)
            yeast.attenHigh = Int16(Double(newYeastAttenHigh.text!)!)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        newYeastName.text = ""
        newYeastFermLow.text = ""
        newYeastAttenLow.text = ""
        newYeastFermHigh.text = ""
        newYeastAttenHigh.text = ""
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


