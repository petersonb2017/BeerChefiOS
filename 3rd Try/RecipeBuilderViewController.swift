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


class RecipeBuilderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var allGrainsTableView: UITableView?
    @IBOutlet weak var grainWeightTextField: UITextField?
    @IBOutlet weak var grainAdditionsTableView: UITableView?
    var grainList: [Grains] = []
    var grainSelected: [Grains] = []
    var grainWeights: [Double] = []
    
    @IBOutlet weak var allHopsTableView: UITableView?
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
    
    @IBOutlet weak var ogPreviewLabel: UILabel!
    @IBOutlet weak var fgPreviewLabel: UILabel!
    @IBOutlet weak var abvPreviewLabel: UILabel!
    @IBOutlet weak var ibuPreviewLabel: UILabel!
    @IBOutlet weak var iconPreview: UIImageView!
    
    var og: Double = 1.0
    var batchSize: Double = 0.0
    var srm = 0.0
    var ibu = 0.0
    var hopsAlreadyUsed: [Hops] = []
    var grainsAlreadyUsed: [Grains] = []
    
    
    
    
    @IBAction func addGrainButton(){
        
        //check to see if grain is valid
        
        let validGrainEntered:Bool = (Double((grainWeightTextField!.text)!) != nil && allGrainsTableView?.indexPathForSelectedRow?.row != nil)
        
        
        if validGrainEntered{
            
            //if grain is valid add it to selected grains, or if the same grain has been added previously,
            //add to the weight of that grain.
            
            let grain: Grains = grainList[(allGrainsTableView?.indexPathForSelectedRow?.row)!]
            if grainSelected.contains(grain){
                grainWeights[grainSelected.index(of: grain)!] += Double((grainWeightTextField?.text)!)!
                grainAdditionsTableView?.reloadData()
            }else{
                grainSelected.append(grain)
                grainWeights.append(Double((grainWeightTextField?.text)!)!)
                grainAdditionsTableView?.reloadData()
            }
            
            //reset text fields
            grainWeightTextField?.text = ""
            grainWeightTextField?.layer.borderColor = UIColor.clear.cgColor
        } else {
            textFieldErrorAnimation(textField: grainWeightTextField!, isValid: true)
            grainWeightTextField?.text = ""
        }
        updatePreview()
    }
    
    
    //
    @IBAction func addHopButton(){
        
        //check to see if hop entered is valid
        
        let validHopEntered: Bool = (Int((hopTimeTextField?.text!)!) != nil && Double((hopWeightTextField?.text!)!) != nil && allHopsTableView?.indexPathForSelectedRow?.row != nil)
        
        if validHopEntered{
            
            //if hop is valid add it to selected hops, or if the same hop at the same time has been
            //added previously, add to the weight of that hop.
            
            var addedToExisting: Bool = false
            let hop: Hops = hopList[(allHopsTableView?.indexPathForSelectedRow?.row)!]
            for hop1 in hopSelected{
                
                //check to see if same hop at same time exists
                
                if hop.name == hop1.name && hopTimes[hopSelected.index(of: hop1)!] == Int((hopTimeTextField?.text)!){
                    hopWeights[hopSelected.index(of: hop1)!] += Double((hopWeightTextField?.text)!)!
                    addedToExisting = true
                    hopTimeTextField?.text = ""
                    hopWeightTextField?.text = ""
                    hopTimeTextField?.layer.borderColor = UIColor.clear.cgColor
                    hopWeightTextField?.layer.borderColor = UIColor.clear.cgColor
                    hopAdditionsTableView?.reloadData()
                }
            }
            if addedToExisting == false{
                hopSelected.append(hop)
                print(hop)
                hopWeights.append(Double((hopWeightTextField?.text)!)!)
                hopTimes.append(Int((hopTimeTextField?.text)!)!)
                hopAdditionsTableView?.reloadData()
                hopTimeTextField?.text = ""
                hopWeightTextField?.text = ""
                hopTimeTextField?.layer.borderColor = UIColor.clear.cgColor
                hopWeightTextField?.layer.borderColor = UIColor.clear.cgColor
            }
        } else {
            textFieldErrorAnimation(textField: hopTimeTextField!, isValid: true)
            textFieldErrorAnimation(textField: hopWeightTextField!, isValid: true)
            hopTimeTextField?.text = ""
            hopWeightTextField?.text = ""
        }
        updatePreview()
    }
    
    @IBAction func addYeastButton(){
        //only one yeast can be added at a time, so this func just adds the yeast or replaces the previous
        //one
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
        
        //check to see if a valid hop is entered
        
        if recipeNameTextField.text != "" || recipeInfoTextField.text != "" || Double(recipeBatchSize.text!) != nil{
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            var recipe: Recipes
            var yeast = yeastSelected.first

            
            //add recipe to CoreData
            if let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipes", into: moc!) as? Recipes{
                recipe.name = recipeNameTextField.text!
                recipe.info = recipeInfoTextField.text!
                recipe.batchSize = Double(recipeBatchSize.text!)!
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //fetch the recipe so that we can access the func in the Recipes class
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
            
            //set relationship between yeast and recipe
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
            
            //set relationship between grains and recipe
            changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: grainSelected, grainWeights: grainWeights, recipe: recipe)
            
            //set relationship between hops and recipe
            changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: hopSelected, hopWeights: hopWeights, hopTimes: hopTimes, recipe: recipe)
            
            
            //reset textfield error indicators
            recipeBatchSize.layer.borderColor = UIColor.clear.cgColor
            recipeNameTextField.layer.borderColor = UIColor.clear.cgColor
            recipeInfoTextField.layer.borderColor = UIColor.clear.cgColor
            
            let recipeOG = recipe.calcOG()
            let recipeFG = recipe.calcFG()
            let recipeABV = recipe.calcABV()
            let recipeIBU = recipe.calcIBU()
            
            //present message confirming the recipe that was added
            let alertController = UIAlertController(title: "Recipe Added", message: "Name: \(recipe.name!) \r\nOG: \(recipeOG) \r\nFG: \(recipeFG) \r\nABV: \(recipeABV) \r\nIBU: \(recipeIBU)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            clearRecipe()
            
        }else{
            
            //error animation is displayed for the text fields with invalid inputs
            
            textFieldErrorAnimation(textField: recipeNameTextField, isValid: recipeNameTextField.text == "")
            textFieldErrorAnimation(textField: recipeInfoTextField, isValid: recipeInfoTextField.text == "")
            textFieldErrorAnimation(textField: recipeBatchSize, isValid: Double(recipeBatchSize.text!) == nil)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        

        allGrainsTableView!.delegate = self
        allGrainsTableView!.dataSource = self
        allHopsTableView!.delegate = self
        allHopsTableView!.delegate = self
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
        
        allGrainsTableView!.delegate = self
        allGrainsTableView!.dataSource = self
        allHopsTableView!.delegate = self
        allHopsTableView!.delegate = self
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
    
    
    //get grain, hop, and yeast lists from coredata
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yeastList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yeastList[row].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == grainAdditionsTableView{
            return grainSelected.count
        }else if tableView == hopAdditionsTableView{
            return hopSelected.count
        }else if tableView == yeastAdditionsTableView{
            return yeastSelected.count
        }else if tableView == allGrainsTableView{
            return grainList.count
        }else{ return hopList.count }
    }
    
    //configure section headings
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == allGrainsTableView {
            return "Select Grain and Adjuncts for Recipe"
        }else if tableView == grainAdditionsTableView {
            return "Selected Grains and Adjuncts"
        }else if tableView == allHopsTableView {
            return "Select Hops for Recipe"
        }else if tableView == hopAdditionsTableView {
            return "Selected Hops"
        }else{return ""}
    }
    
    //configure cells
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
        }else if tableView == yeastAdditionsTableView{
            let cell = yeastAdditionsTableView!.dequeueReusableCell(withIdentifier: "Yeast Cell", for: indexPath) as! YeastCell
            let yeast = yeastSelected[indexPath.row]
            cell.configureCell(yeast: yeast)
            return cell
        }else if tableView == allHopsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredient Hop Cell", for: indexPath as IndexPath) as! IngredientHopCell
            cell.configureCell(hop: hopList[indexPath.row])
            return cell
        }else/* if tableView == allGrainsTableView */{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredient Grain Cell", for: indexPath) as! IngredientGrainCell
            let grain = grainList[indexPath.row]
            cell.configureCell(grain: grain)
            return cell
        }
        
    }
    
    //configure delete settings
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

        for grain in grainSelected{
            
            //for each grain in grain selected, create new object with weight and add to CoreData
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            if let grainW = NSEntityDescription.insertNewObject(forEntityName: "GrainWithWeight", into: moc!) as? GrainWithWeight{
                grainW.name = grain.name
                grainW.ppg = grain.ppg
                grainW.srm = grain.srm
                grainW.weight = grainWeights[grainSelected.index(of: grain)!]
                grainW.partOfRecipe = recipe
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }

    }
    
    
    func changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: [Hops], hopWeights: [Double], hopTimes: [Int], recipe: Recipes){
        for hop in hopsSelected{
            
            //for each hop in hop selected, create new object with weight and time and add to CoreData

            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            if let hopW = NSEntityDescription.insertNewObject(forEntityName: "HopWithWeight", into: moc!) as? HopWithWeight{
                hopW.name = hop.name
                hopW.aa = hop.aa
                hopW.time = Int16(hopTimes[hopSelected.index(of: hop)!])
                hopW.weight = hopWeights[hopSelected.index(of: hop)!]
                hopW.partOfRecipe = recipe
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
    }
    
    func updatePreview(){

        //check to see if batch size is set, if not default to 5 gals
        if(Double(recipeBatchSize.text!) != nil){
            batchSize = Double(recipeBatchSize.text!)!
        }else{
            batchSize = 5.0
        }
        if(grainSelected.isEmpty == false){
            for grain in grainSelected{
                
                //check to see if that grain has already been acounted for in the preview OG
                
                if grainsAlreadyUsed.contains(grain) == false{
                    og = og + 0.75*(0.001*(grain.ppg*grainWeights[grainSelected.index(of: grain)!])/batchSize)
                    srm = srm + (grain.srm*grainWeights[grainSelected.index(of: grain)!])/batchSize
                    grainsAlreadyUsed.append(grain)
                }
            }
        }
        
        if(hopSelected.isEmpty == false && grainSelected.isEmpty == false){
            for hop in hopSelected{
                
                //check to see if that hop has already been acounted for in the preview IBU

                
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
        
        //configure preview section labels
        
        
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
    
    func clearRecipe(){
        recipeBatchSize.text = ""
        recipeInfoTextField.text = ""
        recipeNameTextField.text = ""
        grainSelected.removeAll()
        grainWeights.removeAll()
        hopSelected.removeAll()
        hopWeights.removeAll()
        hopTimes.removeAll()
        yeastSelected.removeAll()
        getData()
    }
}






















