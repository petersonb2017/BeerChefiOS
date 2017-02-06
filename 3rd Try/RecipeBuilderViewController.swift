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
    
    @IBAction func addGrainButton(){
        if Double((grainWeightTextField!.text)!) != nil{
            let grain: Grains = grainList[(grainPickerView?.selectedRow(inComponent: 0))!]
            grainSelected.append(grain)
            print(grain)
            grainWeights.append(Double((grainWeightTextField?.text)!)!)
            grainAdditionsTableView?.reloadData()
            grainWeightTextField?.text = ""
            
        } else {
            grainWeightTextField?.text = ""
        }
    }
    
    @IBAction func addHopButton(){
        if Int((hopTimeTextField?.text!)!) != nil || Double((hopWeightTextField?.text!)!) != nil{
            let hop: Hops = hopList[(hopPickerView?.selectedRow(inComponent: 0))!]
            hopSelected.append(hop)
            print(hop)
            hopWeights.append(Double((hopWeightTextField?.text)!)!)
            hopTimes.append(Int((hopTimeTextField?.text)!)!)
            hopAdditionsTableView?.reloadData()
            hopTimeTextField?.text = ""
            hopWeightTextField?.text = ""
        } else {
            hopTimeTextField?.text = ""
            hopWeightTextField?.text = ""
        }
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
    }
    
    @IBAction func addRecipeButton(){
        let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        var recipe: Recipes
        var yeast = yeastSelected.first
        var recipeOG: Double = 0
        var recipeFG: Double = 0
        var recipeABV: Double = 0
        var recipeIBU: Double = 0
        print("test 1")
        
        
        
        
        
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
        print("test 3")
        changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: hopSelected, hopWeights: hopWeights, hopTimes: hopTimes, recipe: recipe)
        
        
        recipeOG = recipe.calcOG()
        recipeFG = recipe.calcFG()
        recipeABV = recipe.calcABV()
        recipeIBU = recipe.calcIBU()
        let alertController = UIAlertController(title: "Recipe Added", message: "Name: \(recipe.name!) \r\nOG: \(recipeOG) \r\nFG: \(recipeFG) \r\nABV: \(recipeABV) \r\nIBU: \(recipeIBU)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
}
