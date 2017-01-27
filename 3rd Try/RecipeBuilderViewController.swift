//
//  ViewController.swift
//  3rd Try
//
//  Created by Bailey Peterson on 1/1/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData


class RecipeBuilderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var grainPickerView: UIPickerView?
    @IBOutlet weak var grainWeightTextField: UITextField?
    @IBOutlet weak var grainAdditionsTableView: UITableView?
    var grainList: [Grains] = []
    var grainsAndWeights: [Grains:Double] = [Grains:Double]()
    var grainWeights: [Double] = []
    
    @IBOutlet weak var hopPickerView: UIPickerView?
    @IBOutlet weak var hopWeightTextField: UITextField?
    @IBOutlet weak var hopTimeTextField: UITextField?
    @IBOutlet weak var hopAdditionsTableView: UITableView?
    var hopList: [Hops] = []
    var hopSelected: [Hops] = []
    var hopTimes: [Int] = []
    
    @IBOutlet weak var yeastPickerView: UIPickerView?
    @IBOutlet weak var yeastAdditionsTableView: UITableView?
    var yeastList: [Yeasts] = []
    var yeastSelected: [Yeasts] = []
    
    @IBOutlet weak var recipeInfoTextField: UITextField!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeBatchSize: UITextField!
    @IBOutlet weak var recipeAllGrainSegmented: UISegmentedControl!
    
    @IBAction func addGrainButton(){
        
        let grain: Grains = grainList[(grainPickerView?.selectedRow(inComponent: 0))!]
        grainSelected.append(grain)
        print(grain)
        grainWeights.append(Double((grainWeightTextField?.text)!)!)
        grainAdditionsTableView?.reloadData()
        
    }
    
    @IBAction func addHopButton(){
        if Int((hopTimeTextField?.text!)!) != nil{
            let hop: Hops = hopList[(hopPickerView?.selectedRow(inComponent: 0))!]
            hopSelected.append(hop)
            print(hop)
            hopTimes.append(Int((hopTimeTextField?.text)!)!)
            hopAdditionsTableView?.reloadData()
        } else {
            hopTimeTextField?.text = ""
        }
    }
    
    @IBAction func addYeastButton(){
        let yeast: Yeasts = yeastList[(yeastPickerView?.selectedRow(inComponent: 0))!]
        yeastSelected.append(yeast)
        print(yeast)
        yeastAdditionsTableView?.reloadData()
    }
    
    @IBAction func addRecipeButton(){
        let yeast = yeastSelected.first
        let grains = grainSelected
        let weights = grainWeights
        let hops = hopSelected
        let hopTimes = self.hopTimes
        
        let recipeOG = calcOG(grains: grains, weights: weights, batchSize: Double(recipeBatchSize.text!)!)
        let recipeFG = calcFG(recipeOG: recipeOG, yeast: yeast!)
        let recipeABV = calcABV()
        let recipeIBU = calcIBU()
        
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        if let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipes", into: moc!) as? Recipes{
            //add text Fields and create a display Recipe message pop up. Like some sort of recipe viewer.
            
            
            
            //recipe.name = recipeNameTextField.text!
            //recipe.info = reciceInfoTextField.text!
            recipe.grainsUsed = grains as NSObject?
            recipe.hopsUsed = hops as NSObject?
            recipe.yeastUsed = yeast
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        grainPickerView!.delegate = self
        grainPickerView!.dataSource=self
        hopPickerView!.delegate = self
        hopPickerView!.dataSource = self
        yeastPickerView!.delegate = self
        yeastPickerView!.dataSource = self
        grainAdditionsTableView!.dataSource = self
        grainAdditionsTableView!.delegate = self
        hopAdditionsTableView!.dataSource = self
        hopAdditionsTableView!.delegate = self
        yeastAdditionsTableView!.dataSource = self
        yeastAdditionsTableView!.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        grainPickerView!.delegate = self
        grainPickerView!.dataSource=self
        hopPickerView!.delegate = self
        hopPickerView!.dataSource = self
        yeastPickerView!.delegate = self
        yeastPickerView!.dataSource = self
        grainAdditionsTableView!.dataSource = self
        grainAdditionsTableView!.delegate = self
        hopAdditionsTableView!.dataSource = self
        hopAdditionsTableView!.delegate = self
        yeastAdditionsTableView!.dataSource = self
        yeastAdditionsTableView!.delegate = self
        
        grainAdditionsTableView?.reloadData()
        hopAdditionsTableView?.reloadData()
        yeastAdditionsTableView?.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == grainPickerView {
            return grainList.count
        } else if pickerView == hopPickerView{
            return hopList.count
        }else if pickerView == yeastPickerView{
            return yeastList.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == grainPickerView {
            return grainList[row].name
        } else if pickerView == hopPickerView{
            return hopList[row].name
        }else if pickerView == yeastPickerView{
            return yeastList[row].name
        }
        return ""
    }
    
    func getData(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            grainList = try moc.fetch(Grains.fetchRequest())
        } catch {}
        do{
            hopList = try moc.fetch(Hops.fetchRequest())
        } catch {}
        do{
            yeastList = try moc.fetch(Yeasts.fetchRequest())
        } catch {}
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == grainAdditionsTableView{
            return grainSelected.count
        }else if tableView == hopAdditionsTableView{
            return hopSelected.count
        }else {
            return yeastSelected.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == grainAdditionsTableView{
            let grain = grainSelected[indexPath.row]
            cell.textLabel?.text = "Name: \(grain.name!) Weight: \(grainWeights[grainSelected.index(of: grain)!])"
            return cell
        }else if tableView == hopAdditionsTableView{
            let hop = hopSelected[indexPath.row]
            cell.textLabel?.text = "Name: \(hop.name!) AA: \(hop.aa) Time: \(hopTimes[hopSelected.index(of: hop)!])"
            return cell
        }else {
            let yeast = yeastSelected[indexPath.row]
            cell.textLabel?.text = "Name: \(yeast.name!)"
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == grainAdditionsTableView{
            if editingStyle == .delete{
                let grain = grainSelected[indexPath.row]
                grainSelected.remove(at: grainSelected.index(of: grain)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                grainAdditionsTableView?.reloadData()
            }
        } else if tableView == hopAdditionsTableView{
            if editingStyle == .delete{
                let grain = hopSelected[indexPath.row]
                hopSelected.remove(at: hopSelected.index(of: grain)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                hopAdditionsTableView?.reloadData()
            }
        } else
            if editingStyle == .delete{
                let yeast = yeastSelected[indexPath.row]
                yeastSelected.remove(at: yeastSelected.index(of: yeast)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                yeastAdditionsTableView?.reloadData()
        }
    }
    
    func calcOG(grains: [Grains], weights: [Double] , batchSize: Double) -> Double{
        var recipeOG = 0.0
        for i in 0 ... grains.count{
            let grain = grains[i]
            let weight = weights[i]
            recipeOG += 0.001*((grain.ppg*weight)/batchSize)
        }
        return (1 + (recipeOG - 1)*0.8)
        
    }
    
    func calcFG(recipeOG: Double, yeast: Yeasts) -> Double{
        let attenLow = Double(yeast.attenLow)
        let attenHigh = Double(yeast.attenHigh)
        let avgAtten = (1-attenLow*attenHigh/200)
        let recipeFG = (1+(recipeOG-1)*avgAtten)
        return recipeFG
        
    }
    
    func calcIBU() -> Double{
        return 1.5
    }
    
    func calcABV() -> Double{
        return 1.5
    }
}

