//
//  ViewController.swift
//  3rd Try
//
//  Created by Bailey Peterson on 1/1/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!



    
    
    var myPickerData:[String] = [String]()
    let neHopFormData = ["Pellet", "Whole Leaf"]
    //var tester: String

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        myPickerData = ["A","B","C","D","E","F"]
        //print(tester)
        print("Yeah")

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myLabel.text = myString.text
        myLabel.text = myPickerData[row]
    }
    

}

var grFile: String?
var hpFile: String?
var ytFile: String?
var grN: String?
var grPPG: String?
var grSRM: String?
var x: String?
var text: String?
var path: URL?

class AddNewIngredient: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    //public var hpN: String =
    //public var hpAA: Double =
    //public var hpFRM: Bool =
    
    @IBOutlet weak var newGrainName: UITextField!
    @IBOutlet weak var newGrainPPG: UITextField!
    @IBOutlet weak var newGrainSRM: UITextField!
    @IBOutlet weak var newHopName: UITextField!
    @IBOutlet weak var newHopAA: UITextField!
    @IBOutlet weak var newHopForm: UIPickerView!
    @IBOutlet weak var newYeastName: UITextField!
    @IBOutlet weak var newYeastAttenLow: UITextField!
    @IBOutlet weak var newYeastAttenHigh: UITextField!
    @IBOutlet weak var newYeastFermLow: UITextField!
    @IBOutlet weak var newYeastFermHigh: UITextField!
    
    
    @IBAction func addGrain(){
        grFile = "Grain.txt" //this is the file. we will write to and read from it
        grN = newGrainName.text!
        grPPG = newGrainPPG.text!
        grSRM = newGrainSRM.text!
        x = ";"
        text = "/(grN) /(x) /(grPPG) /(x) /(grSRM) /(x)"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(grFile!)
            
            //writing
            do {
                try text?.write(to: path, atomically: false, encoding: String.Encoding.utf8)

            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                print(text2)
            }
            catch {/* error handling here */}
        }
    }
    
    @IBAction func addHop(){
        
    }
    
    @IBAction func addYeast(){
        
    }
    
    
    var newHopFormData:[String] = [String]()
    //var tester: String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newHopForm.dataSource = self
        self.newHopForm.dataSource = self
        newHopFormData = ["Pellet", "Whole Leaf"]
        //print(tester)
        print("Yeah")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newHopFormData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return newHopFormData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myLabel.text = myString.text
        //myLabel.text = newHopForm[row]
    }
    
    
}


