//
//  ViewController.swift
//  3rd Try
//
//  Created by Bailey Peterson on 1/1/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

class GrainCell: UITableViewCell{
    @IBOutlet weak var srmLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    @IBOutlet weak var grainIcon: UIImageView!
    
    public func configureCell(grain: Grains, weight: Double){
        let cd = ColorDecider()
        self.grainIcon.backgroundColor = cd.colorDecider(grain: grain)
        self.nameLabel.text = grain.name
        self.ppgLabel.text = NSString(format: "%.1f", grain.ppg) as String
        self.srmLabel.text = NSString(format: "%.1f", grain.srm) as String
        self.weightLabel.text = NSString(format: "%.2f", weight) as String
    }
}

class HopCell: UITableViewCell{
    @IBOutlet weak var aaLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    public func configureCell(hop: Hops, weight: Double, time: Int){
        self.nameLabel.text = hop.name
        self.aaLabel.text = NSString(format: "%.1f", hop.aa) as String
        self.timeLabel.text = NSString(format: "%d", time) as String
        self.weightLabel.text = NSString(format: "%.2f", weight) as String
    }
    
}

class YeastCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    public func configureCell(yeast: Yeasts){
        self.nameLabel.text = yeast.name
    }
}

class RecipeBuilderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var grainPickerView: UIPickerView?
    @IBOutlet weak var grainWeightTextField: UITextField?
    @IBOutlet weak var grainAdditionsTableView: UITableView?
    var grainList: [Grains] = []
    var grainSelected: [Grains] = []
    var grainWeights: [Double] = []
    
    @IBOutlet weak var hopPickerView: UIPickerView?
    @IBOutlet weak var hopWeightTextField: UITextField?
    @IBOutlet weak var hopTimeTextField: UITextField?
    @IBOutlet weak var hopAdditionsTableView: UITableView?
    var hopList: [Hops] = []
    var hopSelected: [Hops] = []
    var hopWeights: [Double] = []
    var hopTimes: [Int] = []
    
    @IBOutlet weak var yeastPickerView: UIPickerView?
    @IBOutlet weak var yeastAdditionsTableView: UITableView?
    var yeastList: [Yeasts] = []
    var yeastSelected: [Yeasts] = []
    
    @IBOutlet weak var recipeInfoTextField: UITextField!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeBatchSize: UITextField!
    @IBOutlet weak var recipeAllGrainSegmented: UISegmentedControl!
    
    @IBOutlet weak var ogPreviewLabel: UILabel!
    @IBOutlet weak var fgPreviewLabel: UILabel!
    @IBOutlet weak var abvPreviewLabel: UILabel!
    @IBOutlet weak var ibuPreviewLabel: UILabel!
    @IBOutlet weak var iconPreview: UIImageView!
    
    var og: Double = 1.0
    var batchSize = 5.0
    var srm = 0.0
    var ibu = 0.0
    var hopsAlreadyUsed: [Hops] = []
    var grainsAlreadyUsed: [Grains] = []
    
    
    
    
    @IBAction func addGrainButton(){
        if Double((grainWeightTextField!.text)!) != nil {
            let grain: Grains = grainList[(grainPickerView?.selectedRow(inComponent: 0))!]
            if grainSelected.contains(grain){
                grainWeights[grainSelected.index(of: grain)!] += Double((grainWeightTextField?.text)!)!
                grainAdditionsTableView?.reloadData()
            }else{
                grainSelected.append(grain)
                grainWeights.append(Double((grainWeightTextField?.text)!)!)
                grainAdditionsTableView?.reloadData()
            }
            grainWeightTextField?.text = ""
            grainWeightTextField?.layer.borderColor = UIColor.clear.cgColor
        } else {
            textFieldErrorAnimation(textField: grainWeightTextField!, isValid: true)
            grainWeightTextField?.text = ""
        }
        updatePreview()
    }
    
    @IBAction func addHopButton(){
        if Int((hopTimeTextField?.text!)!) != nil && Double((hopWeightTextField?.text!)!) != nil{
            let hop: Hops = hopList[(hopPickerView?.selectedRow(inComponent: 0))!]
            hopSelected.append(hop)
            print(hop)
            hopWeights.append(Double((hopWeightTextField?.text)!)!)
            hopTimes.append(Int((hopTimeTextField?.text)!)!)
            hopAdditionsTableView?.reloadData()
            hopTimeTextField?.text = ""
            hopWeightTextField?.text = ""
            hopTimeTextField?.layer.borderColor = UIColor.clear.cgColor
            hopWeightTextField?.layer.borderColor = UIColor.clear.cgColor
        } else {
            textFieldErrorAnimation(textField: hopTimeTextField!, isValid: true)
            textFieldErrorAnimation(textField: hopWeightTextField!, isValid: true)
            hopTimeTextField?.text = ""
            hopWeightTextField?.text = ""
        }
        updatePreview()
    }
    
    @IBAction func addYeastButton(){
        if yeastSelected.count == 0 {
            let yeast: Yeasts = yeastList[(yeastPickerView?.selectedRow(inComponent: 0))!]
            yeastSelected.append(yeast)
            print(yeast)
            yeastAdditionsTableView?.reloadData()
        }
        else {
            let yeast: Yeasts = yeastList[(yeastPickerView?.selectedRow(inComponent: 0))!]
            replaceYeast(yeast: yeast)
        }
        updatePreview()
    }
    
    @IBAction func addRecipeButton(){
        if recipeNameTextField.text != "" || recipeInfoTextField.text != "" || Double(recipeBatchSize.text!) != nil{
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            var recipe: Recipes
            var yeast = yeastSelected.first
            var recipeOG: Double = 0
            var recipeFG: Double = 0
            var recipeABV: Double = 0
            var recipeIBU: Double = 0
            
            if let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipes", into: moc!) as? Recipes{
                recipe.name = recipeNameTextField.text!
                recipe.info = recipeInfoTextField.text!
                recipe.batchSize = Double(recipeBatchSize.text!)!
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
            let name =  recipeNameTextField.text!
            let info = recipeInfoTextField.text!
            fetch.predicate = NSPredicate(format: "name == %@", name)
            fetch.predicate = NSPredicate(format: "info == %@", info)
            do {
                let recipes = try moc!.fetch(fetch) as! [Recipes]
                recipe = recipes.first!
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
            
            
            let fetchYeast = NSFetchRequest<NSFetchRequestResult>(entityName: "Yeasts")
            let yeastName = yeast?.name!
            fetchYeast.predicate = NSPredicate(format: "name == %@", yeastName!)
            do {
                let yeasts = try moc!.fetch(fetchYeast) as! [Yeasts]
                yeast = yeasts.first!
                yeast?.addToPartOfRecipe(recipe)
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
            
            
            changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: grainSelected, grainWeights: grainWeights, recipe: recipe)
            changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: hopSelected, hopWeights: hopWeights, hopTimes: hopTimes, recipe: recipe)
            
            recipeBatchSize.layer.borderColor = UIColor.clear.cgColor
            recipeNameTextField.layer.borderColor = UIColor.clear.cgColor
            recipeInfoTextField.layer.borderColor = UIColor.clear.cgColor
            
            recipeOG = recipe.calcOG()
            recipeFG = recipe.calcFG()
            recipeABV = recipe.calcABV()
            recipeIBU = recipe.calcIBU()
            let alertController = UIAlertController(title: "Recipe Added", message: "Name: \(recipe.name!) \r\nOG: \(recipeOG) \r\nFG: \(recipeFG) \r\nABV: \(recipeABV) \r\nIBU: \(recipeIBU)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            textFieldErrorAnimation(textField: recipeNameTextField, isValid: recipeNameTextField.text == "")
            textFieldErrorAnimation(textField: recipeInfoTextField, isValid: recipeInfoTextField.text == "")
            textFieldErrorAnimation(textField: recipeBatchSize, isValid: Double(recipeBatchSize.text!) == nil)
        }
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
        updatePreview()
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
        
        if tableView == grainAdditionsTableView{
            let cell = grainAdditionsTableView!.dequeueReusableCell(withIdentifier: "Grain Cell", for: indexPath) as! GrainCell
            let grain = grainSelected[indexPath.row]
            cell.configureCell(grain: grain, weight: grainWeights[grainSelected.index(of: grain)!])
            return cell
        }else if tableView == hopAdditionsTableView{
            let cell = hopAdditionsTableView!.dequeueReusableCell(withIdentifier: "Hop Cell", for: indexPath) as! HopCell
            let hop = hopSelected[indexPath.row]
            cell.configureCell(hop: hop, weight: hopWeights[hopSelected.index(of: hop)!], time: hopTimes[hopSelected.index(of: hop)!])
            return cell
        }else {
            let cell = yeastAdditionsTableView!.dequeueReusableCell(withIdentifier: "Yeast Cell", for: indexPath) as! YeastCell
            let yeast = yeastSelected[indexPath.row]
            cell.configureCell(yeast: yeast)
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
    

    func replaceYeast(yeast: Yeasts){
        yeastSelected.removeAll()
        yeastSelected.append(yeast)
        yeastAdditionsTableView?.reloadData()
    }
    
    func changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: [Grains], grainWeights: [Double], recipe: Recipes){

        for _ in grainSelected{
            var i = 0
            
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            if let grainW = NSEntityDescription.insertNewObject(forEntityName: "GrainWithWeight", into: moc!) as? GrainWithWeight{
                grainW.name = grainSelected[i].name
                grainW.ppg = grainSelected[i].ppg
                grainW.srm = grainSelected[i].srm
                grainW.weight = grainWeights[i]
                grainW.partOfRecipe = recipe
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            print("counter \(i)")
            i += 1
        }
        print("test 2")

    }
    
    
    func changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: [Hops], hopWeights: [Double], hopTimes: [Int], recipe: Recipes){
        for _ in hopsSelected{
            var i = 0
            
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            if let hopW = NSEntityDescription.insertNewObject(forEntityName: "HopWithWeight", into: moc!) as? HopWithWeight{
                hopW.name = hopsSelected[i].name
                hopW.aa = hopsSelected[i].aa
                hopW.time = Int16(hopTimes[i])
                hopW.weight = hopWeights[i]
                hopW.partOfRecipe = recipe
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            print("counter \(i)")
            i += 1
        }
        print("test 2")
    }
    
    func updatePreview(){

        if(Double(recipeBatchSize.text!) != nil){
            batchSize = Double(recipeBatchSize.text!)!
        }
        var i = 0
        print("\(i) time: \(og)")
        i = i + 1
        if(grainSelected.isEmpty == false){
            for grain in grainSelected{
                if grainsAlreadyUsed.contains(grain) == false{
                    og = og + 0.001*(grain.ppg*grainWeights[grainSelected.index(of: grain)!])/batchSize
                    srm = srm + (grain.srm*grainWeights[grainSelected.index(of: grain)!])/batchSize
                    grainsAlreadyUsed.append(grain)
                }
            }
            print(grainsAlreadyUsed)
        }
        if(hopSelected.isEmpty == false && grainSelected.isEmpty == false){
            for hop in hopSelected{
                if hopsAlreadyUsed.contains(hop) == false{
                    let hopTimesWeight = hop.aa*hopWeights[hopSelected.index(of: hop)!]
                    let firstPowThing = pow(0.000125, (og-1)*(5.5/6.5))
                    let eToTheX = (1-pow(M_E,(-0.04*Double(hopTimes[hopSelected.index(of: hop)!]))))
                    ibu = ibu + ((hopTimesWeight*74.89*firstPowThing*eToTheX/4.15)/batchSize)
                    hopsAlreadyUsed.append(hop)
                }
            }
        }
        let fg = (og-1)*0.25+1
        ogPreviewLabel.text = NSString(format: "%.3f", og) as String
        fgPreviewLabel.text = NSString(format: "%.3f", fg) as String
        abvPreviewLabel.text = NSString(format: "%2.1f", (og-fg)*131) as String
        ibuPreviewLabel.text = NSString(format: "%2.1f", ibu) as String
        iconPreview.backgroundColor = ColorDecider().colorDecider(color: srm)
    }
    
    func displayErrorMessage(){
        let alertController = UIAlertController(title: "Could Not Add Ingredient", message: "You entered an invalid Ingredient", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
}






















