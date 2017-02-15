//
//  AddNewIngredientViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/22/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

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
        let textFields: [UITextField] = [newGrainName, newGrainSRM, newGrainPPG]
        textFieldErrorAnimation(textField: newGrainName, isValid: newGrainName.text == "")
        textFieldErrorAnimation(textField: newGrainPPG, isValid: Double(newGrainPPG.text!) == nil)
        textFieldErrorAnimation(textField: newGrainSRM, isValid: Double(newGrainSRM.text!) == nil)
        if checkGrainValidity() == false{
            displayErrorMessage()
        }else{
            addGrainToCoreData()
            resetTextFields(textFields: textFields)
        }
    }
    
    @IBAction func addHop(){
        let textFields: [UITextField] = [newHopName, newHopAA]
        textFieldErrorAnimation(textField: newHopName, isValid: newHopName.text == "")
        textFieldErrorAnimation(textField: newHopAA, isValid: Double(newHopAA.text!) == nil)
        if checkHopValidity() == false{
            displayErrorMessage()
        }else{
            addHopToCoreData()
            resetTextFields(textFields: textFields)
        }
    }
    
    @IBAction func addYeast(){
        let textFields: [UITextField] = [newYeastAttenHigh, newYeastName, newYeastFermHigh, newYeastFermLow, newYeastAttenLow]
        textFieldErrorAnimation(textField: newYeastFermHigh, isValid: Int16(newYeastFermHigh.text!) == nil)
        textFieldErrorAnimation(textField: newYeastFermLow, isValid: Int16(newYeastFermLow.text!) == nil)
        textFieldErrorAnimation(textField: newYeastAttenHigh, isValid: Int16(newYeastAttenHigh.text!) == nil)
        textFieldErrorAnimation(textField: newYeastAttenLow, isValid: Int16(newYeastAttenLow.text!) == nil)
        textFieldErrorAnimation(textField: newYeastName, isValid: newYeastName.text == "")
        if checkYeastValidity() == false{
            displayErrorMessage()
        }else{
            addYeastToCoreData()
            resetTextFields(textFields: textFields)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldErrorAnimation(textField: UITextField, isValid: Bool){
        if isValid == true{
            textField.shake()
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
        } else{
            textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func resetTextFields(textFields: [UITextField]){
        for textField in textFields{
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.clear.cgColor
            textField.text = ""
        }
    }
    
    func checkGrainValidity() -> Bool{
        if newGrainName.text == "" || Double(newGrainPPG.text!) == nil || Double(newGrainSRM.text!) == nil{
            return false
        }
        return true
    }
    
    func checkHopValidity() -> Bool{
        if newHopName.text == "" || Double(newHopAA.text!) == nil{
            return false
        }
        return true
    }
    
    func checkYeastValidity() -> Bool{
        if newYeastName.text == "" || Int16(newYeastFermLow.text!) == nil || Int16(newYeastFermHigh.text!) == nil || Int16(newYeastAttenLow.text!) == nil || Int16(newYeastAttenHigh.text!) == nil{
            return false
        }
        return true
    }
    
    func addGrainToCoreData(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if let grain = NSEntityDescription.insertNewObject(forEntityName: "Grains", into: moc!) as? Grains{
            grain.name = newGrainName.text!
            grain.ppg = Double(newGrainPPG.text!)!
            grain.srm = Double(newGrainSRM.text!)!
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        displayGrainAddedMessage()
    }
    
    func addHopToCoreData(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if let hop = NSEntityDescription.insertNewObject(forEntityName: "Hops", into: moc!) as? Hops{
            hop.name = newHopName.text!
            hop.aa = Double(newHopAA.text!)!
            hop.pellet = newHopForm.isEnabledForSegment(at: 0)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        displayHopAddedMessage()
    }
    
    func addYeastToCoreData(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if let yeast = NSEntityDescription.insertNewObject(forEntityName: "Yeasts", into: moc!) as? Yeasts{
            yeast.name = newYeastName.text!
            yeast.fermTempLow = Int16(Double(newYeastFermLow.text!)!)
            yeast.fermTempHigh = Int16(Double(newYeastFermHigh.text!)!)
            yeast.attenLow = Int16(Double(newYeastAttenLow.text!)!)
            yeast.attenHigh = Int16(Double(newYeastAttenHigh.text!)!)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        displayYeastAddedMessage()
    }
    
    func displayErrorMessage(){
        let alertController = UIAlertController(title: "Could Not Add Ingredient", message: "You entered an invalid Ingredient", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayGrainAddedMessage(){
        let alertController = UIAlertController(title: "Grain Added", message: "Name: \(newGrainName.text!) \r\nPPG: \(newGrainPPG.text!) \r\nSRM: \(newGrainSRM.text!)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayHopAddedMessage(){
        let alertController = UIAlertController(title: "Hop Added", message: "Name: \(newHopName.text!) \r\nAA: \(newHopAA.text!)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayYeastAddedMessage(){
        let alertController = UIAlertController(title: "Yeast Added", message: "Name: \(newYeastName.text!)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}



