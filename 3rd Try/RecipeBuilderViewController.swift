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


class RecipeBuilderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var allGrainsTableView: UITableView?
    @IBOutlet weak var grainWeightTextField: UITextField?
    @IBOutlet weak var grainAdditionsTableView: UITableView?
    var grainList: [Grains] = []
    var grainSelected: [TempGrain] = []
    
    @IBOutlet weak var allHopsTableView: UITableView?
    @IBOutlet weak var hopWeightTextField: UITextField?
    @IBOutlet weak var hopTimeTextField: UITextField?
    @IBOutlet weak var hopAdditionsTableView: UITableView?
    var hopList: [Hops] = []
    var hopSelected: [TempHop] = []
    
    @IBOutlet weak var allYeastTableView: UITableView?
    @IBOutlet weak var yeastAdditionsTableView: UITableView?
    var yeastList: [Yeasts] = []
    var yeastSelected: [Yeasts] = []
    
    @IBOutlet weak var recipeInfoTextField: UITextField!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeBatchSize: UITextField!
    @IBOutlet weak var recipeEfficiency: UITextField!
    
    @IBOutlet weak var ogPreviewLabel: UILabel!
    @IBOutlet weak var fgPreviewLabel: UILabel!
    @IBOutlet weak var abvPreviewLabel: UILabel!
    @IBOutlet weak var ibuPreviewLabel: UILabel!
    @IBOutlet weak var iconPreview: UIImageView!
    
    @IBOutlet weak var newRecipeScrollView: UIScrollView!
    
    @IBOutlet weak var selectedGrainsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectedHopsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectedYeastTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var grainSearchBar: UISearchBar!
    @IBOutlet weak var yeastSearchBar: UISearchBar!
    @IBOutlet weak var hopSearchBar: UISearchBar!

    var filteredGrain = [Grains]()
    var filteredHop = [Hops]()
    var filteredYeast = [Yeasts]()
    
    var og: Double = 1.0
    var batchSize: Double = 5.0
    var didChangeEff = false
    var srm = 0.0
    var ibu = 0.0
    var hopsAlreadyUsed: [Hops] = []
    var grainsAlreadyUsed: [Grains] = []
    
    @IBAction func addGrainButton(){
        if checkGrainTextFields(){
            
            //if the same grain has been added previously,
            //add to the weight of that grain.
            var addedToExisting = false
            var grain = Grains()
            if grainSearchBar.text != "" {
                grain = filteredGrain[(allGrainsTableView?.indexPathForSelectedRow?.row)!]
            } else {
                grain = grainList[(allGrainsTableView?.indexPathForSelectedRow?.row)!]
            }
            for grain1 in grainSelected{
                if grain1.grain.name == grain.name{
                    grain1.weight += Double((grainWeightTextField?.text)!)!
                    addedToExisting = true
                }
            }
            if addedToExisting == false{
                grainSelected.append(TempGrain(tempGrain: grain, tempWeight: Double((grainWeightTextField?.text)!)!))
                grainAdditionsTableView?.reloadData()
            }
            
            resetGrainSearchBar()
            
            //reset text fields
            grainWeightTextField?.text = ""
            grainWeightTextField?.layer.borderColor = UIColor.clear.cgColor

            showOrHideSelectedTableView(type: "grain")
        } else {
            grainWeightTextField?.text = ""
        }
        grainAdditionsTableView?.reloadData()
        updatePreview()
    }
    
    @IBAction func addHopButton(){
        var time: Int = 0
        var weight: Double = 0
        
        if checkHopTextFields(){
            
            //if the same hop at the same time has been
            //added previously, add to the weight of that hop.
            
            
            var addedToExisting: Bool = false
            var hop = Hops()
            weight = Double((hopWeightTextField?.text)!)!
            time = Int((hopTimeTextField?.text)!)!
            if time > 90 {time = 90}//not longer that 90 minute boils
            if time < 0 {time = 0}
            
            if hopSearchBar.text != "" {
                hop = filteredHop[(allHopsTableView?.indexPathForSelectedRow?.row)!]
            }else {hop = hopList[(allHopsTableView?.indexPathForSelectedRow?.row)!]}
            for hop1 in hopSelected{
                
                //check to see if same hop at same time exists, if it does set value of bool addedToExisting
                
                if hop.name == hop1.hop.name && hop1.time == time{
                    hop1.weight = hop1.weight + weight
                    addedToExisting = true
                    print("Added to Existing")
                    print("Time is \(time)")
                    clearHop()
                }
            }
            if addedToExisting == false{
                print("Did Not Add to Existing")
                print("Time is \(time)")
                hopSelected.append(TempHop(tempHop: hop, tempTime: time, tempWeight: weight))
                //hopWeights.append(weight)
                //hopTimes.append(time)
                clearHop()
            }
        }
        
        showOrHideSelectedTableView(type: "hop")
        resetHopSearchBar()
        hopAdditionsTableView?.reloadData()
        updatePreview()
    }
    
    @IBAction func addYeastButton(){
        //only one yeast can be added at a time, so this func just adds the yeast or replaces the previous
        //one
        if allYeastTableView?.indexPathForSelectedRow?.row != nil{
            var yeast = Yeasts()
            if yeastSearchBar.text != "" {
                yeast = filteredYeast[(allYeastTableView?.indexPathForSelectedRow?.row)!]
            }else {yeast = yeastList[(allYeastTableView?.indexPathForSelectedRow?.row)!]}
            
            if yeastSelected.count == 0 {
                yeastSelected.append(yeast)
                yeastAdditionsTableView?.reloadData()
            }
            else {
                replaceYeast(yeast: yeast)
            }
            resetYeastSearchBar()
            showOrHideSelectedTableView(type: "yeast")
        }else {displayErrorMessage(message: "No Yeast Selected", type: "Yeast")}
        updatePreview()
    }
    
    @IBAction func addRecipeButton(){
        
        //check to see if a valid recipe is entered
        var efficiency: Double = 1.1
        if(Double(recipeEfficiency.text!) != nil){
            efficiency = Double(recipeEfficiency.text!)!
            if(efficiency > 1){efficiency = efficiency*0.01}
        }
        print(efficiency)
        
        if checkRecipeTextFields(){
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

            
            let recipe = Recipes(batchSize: Double(recipeBatchSize.text!)!,
                                 info: recipeInfoTextField.text!,
                                 name: recipeNameTextField.text!,
                                 efficiency: efficiency,
                                 grains: changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: grainSelected),
                                 hops: changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: hopSelected),
                                 yeast: NSSet(array: yeastSelected),
                                 insertIntoManagedObjectContext: moc)

            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //reset textfield error indicators
            recipeBatchSize.layer.borderColor = UIColor.clear.cgColor
            recipeNameTextField.layer.borderColor = UIColor.clear.cgColor
            recipeInfoTextField.layer.borderColor = UIColor.clear.cgColor
            recipeEfficiency.layer.borderColor = UIColor.clear.cgColor

            //present message confirming the recipe that was added
            let alertController = UIAlertController(title: "Recipe Added", message: "Name: \(recipe.name!)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            clearRecipe()
            
        }else{
            
            textFieldErrorAnimation(textFields: [recipeNameTextField, recipeInfoTextField, recipeBatchSize, recipeEfficiency], isValid: true)
        }
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        showOrHideSelectedTableView(type: "grain")
        showOrHideSelectedTableView(type: "hop")
        showOrHideSelectedTableView(type: "yeast")

        self.allGrainsTableView?.contentOffset = CGPoint(x: 0.0, y: grainSearchBar.frame.height)
        self.allHopsTableView?.contentOffset = CGPoint(x: 0.0, y: hopSearchBar.frame.height)
        self.allYeastTableView?.contentOffset = CGPoint(x: 0.0, y: yeastSearchBar.frame.height)
        
        getData()
        allGrainsTableView!.delegate = self
        allGrainsTableView!.dataSource = self
        allHopsTableView!.delegate = self
        allHopsTableView!.dataSource = self
        allYeastTableView!.dataSource = self
        allYeastTableView!.delegate = self
        grainAdditionsTableView!.dataSource = self
        grainAdditionsTableView!.delegate = self
        hopAdditionsTableView!.dataSource = self
        hopAdditionsTableView!.delegate = self
        yeastAdditionsTableView!.dataSource = self
        yeastAdditionsTableView!.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        allYeastTableView?.reloadData()
        allHopsTableView?.reloadData()
        allGrainsTableView?.reloadData()
        grainAdditionsTableView?.reloadData()
        hopAdditionsTableView?.reloadData()
        yeastAdditionsTableView?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        switch searchBar{
        case grainSearchBar:
            filteredGrain = grainList.filter{ grain in
                return (grain.name?.lowercased().contains((searchBar.text?.lowercased())!))!
            }
            allGrainsTableView?.reloadData()
        case hopSearchBar:
            filteredHop = hopList.filter{ hop in
                return (hop.name?.lowercased().contains((searchBar.text?.lowercased())!))!
            }
            allHopsTableView?.reloadData()
        
        case yeastSearchBar:
            filteredYeast = yeastList.filter{ yeast in
                return (yeast.name?.lowercased().contains((searchBar.text?.lowercased())!))!
            }
            allYeastTableView?.reloadData()
            
        default: break
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        allGrainsTableView?.reloadData()
        allHopsTableView?.reloadData()
        allYeastTableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        allGrainsTableView?.reloadData()
        allHopsTableView?.reloadData()
        allYeastTableView?.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        allGrainsTableView?.reloadData()
        allHopsTableView?.reloadData()
        allYeastTableView?.reloadData()
    }

    func resetGrainSearchBar(){
        filteredGrain = grainList
        grainSearchBar.text = ""
        allGrainsTableView?.reloadData()
    }
    
    func resetHopSearchBar(){
        filteredHop = hopList
        hopSearchBar.text = ""
        allHopsTableView?.reloadData()
    }
    
    func resetYeastSearchBar(){
        filteredYeast = yeastList
        yeastSearchBar.text = ""
        allYeastTableView?.reloadData()
    }
    
    //get grain, hop, and yeast lists from coredata
    func getData(){
        updatePreview()
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let grainFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Grains")
            grainFetch.sortDescriptors = [NSSortDescriptor(key: "srm", ascending: true)]
            grainList = try moc.fetch(grainFetch) as! [Grains]
            
            let hopFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Hops")
            hopFetch.sortDescriptors = [NSSortDescriptor(key: "aa", ascending: true)]
            hopList = try moc.fetch(hopFetch) as! [Hops]
            
            yeastList = try moc.fetch(Yeasts.fetchRequest())
        } catch {}
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case grainAdditionsTableView!:
            return grainSelected.count
            
        case allGrainsTableView!:
            if grainSearchBar.text != ""{
                return filteredGrain.count
            }else{return grainList.count}
            
        case allHopsTableView!:
            if hopSearchBar.text != ""{
                return filteredHop.count
            }else{return hopList.count}
            
        case hopAdditionsTableView!:
            return hopSelected.count
            
        case allYeastTableView!:
            if yeastSearchBar.text != ""{
                return filteredYeast.count
            }else{return yeastList.count}
            
        case yeastAdditionsTableView!:
            return yeastSelected.count
            
        default: return 0
        }
        
    }
    
    //configure section headings
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case allGrainsTableView!:
            return "Select Fermentables"
            
        case grainAdditionsTableView!:
            return "Selected Fermentables"
            
        case allHopsTableView!:
            return "Select Hops"
            
        case hopAdditionsTableView!:
            return "Selected Hops"
            
        case allYeastTableView!:
            return "Select Yeast"
            
        case yeastAdditionsTableView!:
            return "Selected Yeast"
            
        default:
            return ""
        }
    }
    
    //configure cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch tableView {
            
        case allGrainsTableView!:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredient Grain Cell", for: indexPath) as! IngredientGrainCell
            var grain = Grains()
            if grainSearchBar.text != "" {
                grain = filteredGrain[indexPath.row]
            } else {grain = grainList[indexPath.row]}
            cell.configureCell(grain: grain)
            cell.backgroundColor = UIColor.clear
            return cell
            
        case grainAdditionsTableView!:
            let cell = grainAdditionsTableView!.dequeueReusableCell(withIdentifier: "Grain Cell", for: indexPath) as! GrainCell
            let grain = grainSelected[indexPath.row]
            cell.configureCell(grain: grain)
            cell.backgroundColor = UIColor.clear
            return cell
            
        case allHopsTableView!:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredient Hop Cell", for: indexPath as IndexPath) as! IngredientHopCell
            var hop = Hops()
            if hopSearchBar.text != "" {
                hop = filteredHop[indexPath.row]
            } else {hop = hopList[indexPath.row]}
            cell.configureCell(hop: hop)
            cell.backgroundColor = UIColor.clear
            return cell
            
        case hopAdditionsTableView!:
            let cell = hopAdditionsTableView!.dequeueReusableCell(withIdentifier: "Hop Cell", for: indexPath) as! HopCell
            let hop = hopSelected[indexPath.row]
            cell.configureCell(hop: hop)
            cell.backgroundColor = UIColor.clear
            return cell
            
        case allYeastTableView!:
            let cell = allYeastTableView!.dequeueReusableCell(withIdentifier: "All Yeast Cell", for: indexPath) as! YeastCell
            var yeast = Yeasts()
            if yeastSearchBar.text != "" {
                yeast = filteredYeast[indexPath.row]
            }else {yeast = yeastList[indexPath.row]}
            cell.configureCell(yeast: yeast)
            cell.backgroundColor = UIColor.clear
            return cell
            
        case yeastAdditionsTableView!:
            let cell = yeastAdditionsTableView!.dequeueReusableCell(withIdentifier: "Yeast Cell", for: indexPath) as! YeastCell
            let yeast = yeastSelected[indexPath.row]
            cell.configureCell(yeast: yeast)
            cell.backgroundColor = UIColor.clear
            return cell
            
        default: return UITableViewCell()
    
        }
    }
    
    //configure delete settings
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == grainAdditionsTableView{
            if editingStyle == .delete{
                grainSelected.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                showOrHideSelectedTableView(type: "grain")
                grainAdditionsTableView?.reloadData()
                updatePreview()
            }
        } else if tableView == hopAdditionsTableView{
            if editingStyle == .delete{
                hopSelected.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                showOrHideSelectedTableView(type: "hop")
                hopAdditionsTableView?.reloadData()
                updatePreview()
            }
        } else
            if editingStyle == .delete{
                let yeast = yeastSelected[indexPath.row]
                yeastSelected.remove(at: yeastSelected.index(of: yeast)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                showOrHideSelectedTableView(type: "yeast")
                yeastAdditionsTableView?.reloadData()
                updatePreview()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case recipeBatchSize:
            print("ended editing")
            if (Double(recipeBatchSize.text!) != nil) {
                updatePreview()
            }
        case recipeEfficiency:
            print("ended editing")
            if (Double(recipeEfficiency.text!) != nil) {
                didChangeEff = true
                updatePreview()
            }
        default: break
        }
    }
    
    
    func keyboardWillShow(_ notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.newRecipeScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.newRecipeScrollView.contentInset = contentInset
        self.viewDidLayoutSubviews()
    }
    
    func keyboardWillHide(_ notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.newRecipeScrollView.contentInset = contentInset
        self.viewDidLayoutSubviews()
    }

    func replaceYeast(yeast: Yeasts){
        yeastSelected.removeAll()
        yeastSelected.append(yeast)
        yeastAdditionsTableView?.reloadData()
    }
    
    func changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: [TempGrain]) -> NSSet{
        
        var grains: [GrainWithWeight] = []

        for grain in grainSelected{
            
            //for each grain in grain selected, create new object with weight and add to CoreData
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            grains.append(GrainWithWeight(name: grain.grain.name!, ppg: grain.grain.ppg, srm: grain.grain.srm, isExtract: grain.grain.isExtract, weight: grain.weight, insertIntoManagedObjectContext: moc))
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
        return NSSet(array: grains)
    }
    
    
    func changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: [TempHop]) -> NSSet{
        
        var hops: [HopWithWeight] = []
        
        for hop in hopsSelected{
            
            //for each hop in hop selected, create new object with weight and time and add to CoreData

            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            hops.append(HopWithWeight(name: hop.hop.name!, aa: hop.hop.aa, pellet: hop.hop.pellet, time: Int16(hop.time), weight: hop.weight, insertIntoManagedObjectContext: moc))
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        return NSSet(array: hops)
    }
    
    func updatePreview(){
        og = 1.0
        batchSize = 5.0
        srm = 0.0
        ibu = 0.0

        //check to see if batch size is set, if not default to 5 gals
        if(Double(recipeBatchSize.text!) != nil){
            batchSize = Double(recipeBatchSize.text!)!
        }else{
            batchSize = 5.0
        }
        
        for grain in grainSelected{
            
            //check to see if that grain has already been acounted for in the preview OG
            if didChangeEff == true {grainsAlreadyUsed.removeAll()}
            var extraction = 0.75
            if Double(recipeEfficiency.text!) != nil{
                var eff = Double(recipeEfficiency.text!)!
                if (eff < 1.0){
                    extraction = eff
                }else{
                    repeat{
                        eff = eff*0.01
                    }while(eff>1.0)
                    extraction = eff
                }
            }
            if grain.grain.isExtract == true{
                extraction = 1.0
            }
            og = og + extraction*(0.001*(grain.grain.ppg*grain.weight)/batchSize)
            srm = srm + (grain.grain.srm*grain.weight)/batchSize
            grainsAlreadyUsed.append(grain.grain)
        }
        
        
        didChangeEff = false
        
        if(hopSelected.isEmpty == false && grainSelected.isEmpty == false){
            for hop in hopSelected{
                
                //check to see if that hop has already been acounted for in the preview IBU

                    let hopTimesWeight = hop.hop.aa*hop.weight
                    let firstPowThing = pow(0.000125, (og-1)*(5.5/6.5))
                    let eToTheX = (1-pow(M_E,(-0.04*Double(hop.time))))
                    ibu = ibu + ((hopTimesWeight*74.89*firstPowThing*eToTheX/4.15)/batchSize)
                
            }
        }
        var fg: Double
        if yeastSelected.isEmpty == true{
            fg = (og-1.0)*0.25+1.0
        }else{
            let attenLow = Double((yeastSelected.first?.attenHigh)!)*0.01
            let attenHigh = Double((yeastSelected.first?.attenLow)!)*0.01
            fg = (og-1.0)*(1.0-(attenLow+attenHigh)/2.0)+1.0
        }
        //configure preview section labels
        
        ogPreviewLabel.text = NSString(format: "%.3f", og) as String
        fgPreviewLabel.text = NSString(format: "%.3f", fg) as String
        abvPreviewLabel.text = NSString(format: "%2.1f", ((og-fg)*131)) as String
        ibuPreviewLabel.text = NSString(format: "%2.1f", ibu) as String
        iconPreview.contentMode = UIViewContentMode.scaleToFill
        iconPreview.image = ColorDecider().colorDeciderRecipe(color: srm)
    }
    
    func displayErrorMessage(){
        let alertController = UIAlertController(title: "Could Not Add Ingredient", message: "You entered an invalid Ingredient", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayErrorMessage(message: String, type: String){
        let alertController = UIAlertController(title: "Could Not Add \(type)", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldErrorAnimation(textFields: [UITextField], isValid: Bool){
        for textField in textFields{
            if isValid == true{
                textField.shake()
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
            } else{
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    func clearRecipe(){
        recipeBatchSize.text = ""
        recipeInfoTextField.text = ""
        recipeNameTextField.text = ""
        recipeEfficiency.text = ""
        recipeBatchSize.layer.borderColor = UIColor.clear.cgColor
        recipeNameTextField.layer.borderColor = UIColor.clear.cgColor
        recipeInfoTextField.layer.borderColor = UIColor.clear.cgColor
        recipeEfficiency.layer.borderColor = UIColor.clear.cgColor
        grainSelected.removeAll()
        hopSelected.removeAll()
        yeastSelected.removeAll()
        getData()
        hopAdditionsTableView?.reloadData()
        grainAdditionsTableView?.reloadData()
        yeastAdditionsTableView?.reloadData()
        og = 1.0
        batchSize = 0.0
        srm = 0.0
        ibu = 0.0
        showOrHideSelectedTableView(type: "grain")
        showOrHideSelectedTableView(type: "hop")
        showOrHideSelectedTableView(type: "yeast")
    }
    
    func clearHop(){
        hopTimeTextField?.text = ""
        hopWeightTextField?.text = ""
        hopTimeTextField?.layer.borderColor = UIColor.clear.cgColor
        hopWeightTextField?.layer.borderColor = UIColor.clear.cgColor
        hopAdditionsTableView?.reloadData()
    }
    
    func checkHopTextFields() -> Bool{
        var outcome: Bool = true
        var errorMessage: String = ""
        var animatedFields: [UITextField] = []
        
        if allHopsTableView?.indexPathForSelectedRow?.row == nil {
            outcome = false
            errorMessage = "No Hop Selected"
        }
        
        if (hopTimeTextField?.text)! == ""{
            outcome = false
            animatedFields.append(hopTimeTextField!)
            if errorMessage == ""{
                errorMessage = errorMessage + "No Time Entered"
            }else{errorMessage = errorMessage + "\nNo Time Entered"}
        }else if Int((hopTimeTextField?.text)!) == nil{
            outcome = false
            animatedFields.append(hopTimeTextField!)
            if errorMessage == ""{
                errorMessage = errorMessage + "Incorrect Time Entry"
            }else{errorMessage = errorMessage + "\nIncorrect Time Entry"}
            
        }
        
        if (hopWeightTextField?.text)! == ""{
            outcome = false
            animatedFields.append(hopWeightTextField!)
            if errorMessage == ""{
                errorMessage = errorMessage + "No Weight Entered"
            }else{errorMessage = errorMessage + "\nNo Weight Entered"}
        }else if Double((hopWeightTextField?.text)!) == nil{
            outcome = false
            animatedFields.append(hopWeightTextField!)
            if errorMessage == ""{
                errorMessage = errorMessage + "Incorrect Weight Entry"
            }else{errorMessage = errorMessage + "\nIncorrect Weight Entry"}
        }
        
        textFieldErrorAnimation(textFields: animatedFields, isValid: true)
        if outcome == false{displayErrorMessage(message: errorMessage, type: "Hop")}
        return outcome
    }
    
    func checkGrainTextFields() -> Bool{
        var outcome: Bool = true
        var errorMessage: String = ""
        var animatedFields: [UITextField] = []
        
        if allGrainsTableView?.indexPathForSelectedRow?.row == nil {
            outcome = false
            errorMessage = "No Grain Selected"
        }
        
        if (grainWeightTextField?.text)! == ""{
            outcome = false
            animatedFields.append(grainWeightTextField!)
            if errorMessage == ""{
                errorMessage = errorMessage + "No Weight Entered"
            }else{errorMessage = errorMessage + "\nNo Weight Entered"}
        }else if Double((grainWeightTextField?.text)!) == nil{
            outcome = false
            animatedFields.append(grainWeightTextField!)
            if errorMessage == ""{
                errorMessage = errorMessage + "Incorrect Weight Entry"
            }else{errorMessage = errorMessage + "\nIncorrect Weight Entry"}
        }
        
        textFieldErrorAnimation(textFields: animatedFields, isValid: true)
        if outcome == false{displayErrorMessage(message: errorMessage, type: "Grain")}
        return outcome
    }
    
    func checkRecipeTextFields() -> Bool{
        var outcome: Bool = true
        var errorMessage: String = ""
        var animatedFields: [UITextField] = []
        
        if (recipeNameTextField?.text)! == ""{
            outcome = false
            animatedFields.append(recipeNameTextField!)
            errorMessage = errorMessage + "No Name Entered"
        }

        if (recipeBatchSize?.text)! == ""{
            outcome = false
            animatedFields.append(recipeBatchSize!)
            if errorMessage == ""{
                errorMessage = errorMessage + "No Batch Size Entered"
            }else{errorMessage = errorMessage + "\nNo Batch Size Entered"}
        }else if Double((recipeBatchSize?.text)!) == nil{
            outcome = false
            animatedFields.append(recipeBatchSize!)
            if errorMessage == ""{
                errorMessage = errorMessage + "Invalid Batch Size Entered"
            }else{errorMessage = errorMessage + "\nInvalid Batch Size Entered"}
        }
        
        if (recipeEfficiency?.text)! == ""{
            outcome = false
            animatedFields.append(recipeEfficiency!)
            if errorMessage == ""{
                errorMessage = errorMessage + "No Efficiency Entered"
            }else{errorMessage = errorMessage + "\nNo Efficiency Entered"}
        }else if Double((recipeEfficiency?.text)!) == nil{
            outcome = false
            animatedFields.append(recipeEfficiency!)
            if errorMessage == ""{
                errorMessage = errorMessage + "Invalid Efficiency Entered"
            }else{errorMessage = errorMessage + "\nInvalid Efficiency Entered"}
        }
        textFieldErrorAnimation(textFields: animatedFields, isValid: true)
        if outcome == false{
            newRecipeScrollView.scrollRectToVisible(recipeBatchSize.frame, animated: true)
            displayErrorMessage(message: errorMessage, type: "Recipe")
        }
        return outcome
    }
    
    func showOrHideSelectedTableView(type: String){
        switch type{
        case "grain":
            if(grainSelected.isEmpty){
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectedGrainsTableViewHeight.constant = 0.0
                    self.view.layoutIfNeeded()
                })
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectedGrainsTableViewHeight.constant = CGFloat(28 + 44*self.grainSelected.count)
                    self.view.layoutIfNeeded()
                })
            }
        case "hop":
            if(hopSelected.isEmpty){
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectedHopsTableViewHeight.constant = 0.0
                    self.view.layoutIfNeeded()
                })
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectedHopsTableViewHeight.constant = CGFloat(28 + 44*self.hopSelected.count)
                    self.view.layoutIfNeeded()
                })
            }
        case "yeast":
            if(yeastSelected.isEmpty){
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectedYeastTableViewHeight.constant = 0.0
                    self.view.layoutIfNeeded()
                })
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.selectedYeastTableViewHeight.constant = 73.0
                    self.view.layoutIfNeeded()
                })
            }
            
        default: break
            
        }
        
    }
    
}




















