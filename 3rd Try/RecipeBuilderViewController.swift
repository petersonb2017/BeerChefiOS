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
            
            var grain = Grains()
            if grainSearchBar.text != "" {
                grain = filteredGrain[(allGrainsTableView?.indexPathForSelectedRow?.row)!]
            } else {
                grain = grainList[(allGrainsTableView?.indexPathForSelectedRow?.row)!]
            }
            if grainSelected.contains(grain){
                grainWeights[grainSelected.index(of: grain)!] += Double((grainWeightTextField?.text)!)!
                grainAdditionsTableView?.reloadData()
            }else{
                grainSelected.append(grain)
                grainWeights.append(Double((grainWeightTextField?.text)!)!)
                grainAdditionsTableView?.reloadData()
            }
            
            resetGrainSearchBar()
            
            //reset text fields
            grainWeightTextField?.text = ""
            grainWeightTextField?.layer.borderColor = UIColor.clear.cgColor
            showOrHideSelectedTableView(type: "grain")
        } else {
            textFieldErrorAnimation(textFields: [grainWeightTextField!], isValid: true)
            grainWeightTextField?.text = ""
        }
        updatePreview()
    }
    
    @IBAction func addHopButton(){
        
        //check to see if hop entered is valid
        
        let validHopEntered: Bool = (Int((hopTimeTextField?.text!)!) != nil && Double((hopWeightTextField?.text!)!) != nil && allHopsTableView?.indexPathForSelectedRow?.row != nil)
        var time: Int
        var weight: Double

        
        
        if validHopEntered{
            
            //if hop is valid add it to selected hops, or if the same hop at the same time has been
            //added previously, add to the weight of that hop.
            
            var addedToExisting: Bool = false
            var hop = Hops()
            weight = Double((hopWeightTextField?.text)!)!
            time = Int((hopTimeTextField?.text)!)!
            if time > 90 {time = 90}
            if time < 0 {time = 0}
            
            if hopSearchBar.text != "" {
                hop = filteredHop[(allHopsTableView?.indexPathForSelectedRow?.row)!]
            }else {hop = hopList[(allHopsTableView?.indexPathForSelectedRow?.row)!]}
            for hop1 in hopSelected{
                
                //check to see if same hop at same time exists
                
                if hop.name == hop1.name && hopTimes[hopSelected.index(of: hop1)!] == time{
                    hopWeights[hopSelected.index(of: hop1)!] += weight
                    addedToExisting = true
                    clearHop()
                }
            }
            if addedToExisting == false{
                hopSelected.append(hop)
                hopWeights.append(weight)
                hopTimes.append(time)
                clearHop()
            }
        } else {
            textFieldErrorAnimation(textFields: [hopTimeTextField!, hopWeightTextField!], isValid: true)
            hopTimeTextField?.text = ""
            hopWeightTextField?.text = ""
        }
        
        showOrHideSelectedTableView(type: "hop")
        resetHopSearchBar()
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
        }
        updatePreview()
    }
    
    @IBAction func addRecipeButton(){
        
        //check to see if a valid recipe is entered
        
        if recipeNameTextField.text != "" || recipeInfoTextField.text != "" || Double(recipeBatchSize.text!) != nil{
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            var efficiency: Double = Double(recipeEfficiency.text!)!
            if efficiency > 1{efficiency = efficiency*0.01}
            
            let recipe = Recipes(batchSize: Double(recipeBatchSize.text!)!,
                                 info: recipeInfoTextField.text!,
                                 name: recipeNameTextField.text!,
                                 efficiency: Double(recipeEfficiency.text!)!,
                                 grains: changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: grainSelected, grainWeights: grainWeights),
                                 hops: changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: hopSelected, hopWeights: hopWeights, hopTimes: hopTimes),
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
            
            //error animation is displayed for the text fields with invalid inputs
            
            textFieldErrorAnimation(textFields: [recipeNameTextField, recipeInfoTextField, recipeBatchSize, recipeEfficiency], isValid: recipeNameTextField.text == "")
        }
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        super.viewDidLoad()
        
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
            return "Select Grain and Adjuncts for Recipe"
            
        case grainAdditionsTableView!:
            return "Selected Grains and Adjuncts"
            
        case allHopsTableView!:
            return "Select Hops for Recipe"
            
        case hopAdditionsTableView!:
            return "Selected Hops"
            
        case allYeastTableView!:
            return "Select Yeast for Recipe"
            
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
            cell.configureCell(grain: grain, weight: grainWeights[grainSelected.index(of: grain)!])
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
            cell.configureCell(hop: hop, weight: hopWeights[hopSelected.index(of: hop)!], time: hopTimes[hopSelected.index(of: hop)!])
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
                let grain = grainSelected[indexPath.row]
                grainSelected.remove(at: grainSelected.index(of: grain)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                showOrHideSelectedTableView(type: "grain")
                grainAdditionsTableView?.reloadData()
            }
        } else if tableView == hopAdditionsTableView{
            if editingStyle == .delete{
                let grain = hopSelected[indexPath.row]
                hopSelected.remove(at: hopSelected.index(of: grain)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                showOrHideSelectedTableView(type: "hop")
                hopAdditionsTableView?.reloadData()
            }
        } else
            if editingStyle == .delete{
                let yeast = yeastSelected[indexPath.row]
                yeastSelected.remove(at: yeastSelected.index(of: yeast)!)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                showOrHideSelectedTableView(type: "yeast")
                yeastAdditionsTableView?.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    func changeGrainsToGrainsWithWeightAndAddToCoreData(grainSelected: [Grains], grainWeights: [Double]) -> NSSet{
        
        var grains: [GrainWithWeight] = []

        for grain in grainSelected{
            
            //for each grain in grain selected, create new object with weight and add to CoreData
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            grains.append(GrainWithWeight(name: grain.name!, ppg: grain.ppg, srm: grain.srm, weight: grainWeights[grainSelected.index(of: grain)!], isExtract: grain.isExtract, insertIntoManagedObjectContext: moc))
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
        return NSSet(array: grains)
    }
    
    
    func changeHopsToHopsWithWeightAndAddToCoreData(hopsSelected: [Hops], hopWeights: [Double], hopTimes: [Int]) -> NSSet{
        
        var hops: [HopWithWeight] = []
        
        for hop in hopsSelected{
            
            //for each hop in hop selected, create new object with weight and time and add to CoreData

            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            hops.append(HopWithWeight(name: hop.name!, aa: hop.aa, time: Int16(hopTimes[hopsSelected.index(of: hop)!]), weight: hopWeights[hopsSelected.index(of: hop)!], pellet: hop.pellet, insertIntoManagedObjectContext: moc))
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        return NSSet(array: hops)
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
        iconPreview.contentMode = UIViewContentMode.scaleToFill
        iconPreview.image = ColorDecider().colorDeciderRecipe(color: srm)
    }
    
    func displayErrorMessage(){
        let alertController = UIAlertController(title: "Could Not Add Ingredient", message: "You entered an invalid Ingredient", preferredStyle: UIAlertControllerStyle.alert)
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
        grainWeights.removeAll()
        hopSelected.removeAll()
        hopWeights.removeAll()
        hopTimes.removeAll()
        yeastSelected.removeAll()
        getData()
        hopAdditionsTableView?.reloadData()
        grainAdditionsTableView?.reloadData()
        yeastAdditionsTableView?.reloadData()
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
                    self.selectedGrainsTableViewHeight.constant = 120.0
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
                    self.selectedHopsTableViewHeight.constant = 120.0
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




















