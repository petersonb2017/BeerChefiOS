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

class AddNewIngredientViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var newGrainName: UITextField!
    @IBOutlet weak var newGrainPPG: UITextField!
    @IBOutlet weak var newGrainSRM: UITextField!
    @IBOutlet weak var newGrainForm: UISegmentedControl!
    
    @IBOutlet weak var newHopName: UITextField!
    @IBOutlet weak var newHopAA: UITextField!
    @IBOutlet weak var newHopForm: UISegmentedControl!
    
    @IBOutlet weak var newYeastName: UITextField!
    @IBOutlet weak var newYeastAttenLow: UITextField!
    @IBOutlet weak var newYeastAttenHigh: UITextField!
    @IBOutlet weak var newYeastFermLow: UITextField!
    @IBOutlet weak var newYeastFermHigh: UITextField!
    
    @IBOutlet weak var newIngredientScrollView: UIScrollView!
    struct TextFieldWithBool{
        var textField: UITextField? = nil
        var isValid = false
    }
    
    
    @IBAction func addGrain(){
        let grainTextFields: [TextFieldWithBool] = [
            TextFieldWithBool(textField: newGrainName, isValid: newGrainName.text == ""),
            TextFieldWithBool(textField: newGrainPPG, isValid: Double(newGrainPPG.text!) == nil),
            TextFieldWithBool(textField: newGrainSRM, isValid: Double(newGrainSRM.text!) == nil)]
        
        textFieldErrorAnimation(textFields: grainTextFields)
        if checkGrainValidity() == false{
            displayErrorMessage()
        }else{
            addGrainToCoreData()
            resetTextFields(textFields: grainTextFields)
        }
    }
    
    @IBAction func addHop(){
        let hopTextFields: [TextFieldWithBool] = [TextFieldWithBool(textField: newHopName, isValid: newHopName.text == ""), TextFieldWithBool(textField: newHopAA, isValid: Double(newHopAA.text!) == nil)]
        textFieldErrorAnimation(textFields: hopTextFields)

        if checkHopValidity() == false{
            displayErrorMessage()
        }else{
            addHopToCoreData()
            resetTextFields(textFields: hopTextFields)
        }
    }
    
    @IBAction func addYeast(){
        let yeastTextFields: [TextFieldWithBool] =
            [
                TextFieldWithBool(textField: newYeastFermHigh, isValid: Int16(newYeastFermHigh.text!) == nil),
                TextFieldWithBool(textField: newYeastFermLow, isValid: Int16(newYeastFermLow.text!) == nil),
                TextFieldWithBool(textField: newYeastAttenHigh, isValid: Int16(newYeastAttenHigh.text!) == nil),
                TextFieldWithBool(textField: newYeastAttenLow, isValid: Int16(newYeastAttenLow.text!) == nil),
                TextFieldWithBool(textField: newYeastName, isValid: newYeastName.text == "")
            ]
        textFieldErrorAnimation(textFields: yeastTextFields)
        if checkYeastValidity() == false{
            displayErrorMessage()
        }else{
            addYeastToCoreData()
            resetTextFields(textFields: yeastTextFields)
        }
    }
    
    
    
    override func viewDidLoad() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.hideKeyboardWhenTappedAround()
        
        super.viewDidLoad()

    }
    
    func textFieldErrorAnimation(textFields: [TextFieldWithBool]){
        for txts in textFields{
            if txts.isValid == true{
                txts.textField?.shake()
                txts.textField?.layer.borderWidth = 1
                txts.textField?.layer.borderColor = UIColor.red.cgColor
            } else{
                txts.textField?.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    func resetTextFields(textFields: [TextFieldWithBool]){
        for txts in textFields{
            txts.textField?.layer.borderWidth = 1
            txts.textField?.layer.borderColor = UIColor.clear.cgColor
            txts.textField?.text = ""
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
        if newYeastName.text! == "" || Int16(newYeastFermLow.text!) == nil || Int16(newYeastFermHigh.text!) == nil || Int16(newYeastAttenLow.text!) == nil || Int16(newYeastAttenHigh.text!) == nil || Int16(newYeastAttenHigh.text!)! <= Int16(newYeastAttenLow.text!)! || Int16(newYeastFermLow.text!)! >= Int16(newYeastFermHigh.text!)!{
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
            if newGrainForm.selectedSegmentIndex == 0 {
                grain.isExtract = false
            }else{ grain.isExtract = true}
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        displayGrainAddedMessage()
    }
    
    func addHopToCoreData(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if let hop = NSEntityDescription.insertNewObject(forEntityName: "Hops", into: moc!) as? Hops{
            hop.name = newHopName.text!
            hop.aa = Double(newHopAA.text!)!
            if newHopForm.selectedSegmentIndex == 0{
            hop.pellet = true
            }else{hop.pellet = false}
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
    
    func keyboardWillShow(_ notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.newIngredientScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.newIngredientScrollView.contentInset = contentInset
        self.viewDidLayoutSubviews()
    }
    
    func keyboardWillHide(_ notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.newIngredientScrollView.contentInset = contentInset
        self.viewDidLayoutSubviews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func displayErrorMessage(){
        let alertController = UIAlertController(title: "Could Not Add Ingredient", message: "", preferredStyle: UIAlertControllerStyle.alert)
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
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


