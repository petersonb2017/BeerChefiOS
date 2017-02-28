//
//  ArchivedRecipesViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/22/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

class RecipeCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var recipeIBULabel: UILabel!
    @IBOutlet weak var recipeYeastNameLabel: UILabel!
    @IBOutlet weak var recipeOGLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeThumbNail: UIImageView!
    
    @IBOutlet weak var grainsInRecipeTableView: UITableView!
    @IBOutlet weak var grainTableViewHeight: NSLayoutConstraint!

    @IBOutlet weak var hopsInRecipeTableView: UITableView!
    @IBOutlet weak var hopTableViewHeight: NSLayoutConstraint!

    

    
    @IBOutlet weak var ingredientView: UIView!
    @IBOutlet weak var ingredientViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIView!
    
    var isExpanded:Bool = false
        {
        didSet
        {
            if !isExpanded {
                self.ingredientViewHeight.constant = 0.0
                self.hopsInRecipeTableView.isHidden = true
                self.hopTableViewHeight.constant = 0.0
                self.grainTableViewHeight.constant = 0.0
                self.grainsInRecipeTableView.isHidden = true
                
            } else {
                self.ingredientViewHeight.constant = 200.0
                self.hopTableViewHeight.constant = 200.0
                self.grainsInRecipeTableView.isHidden = false
                self.grainTableViewHeight.constant = 200.0
                self.hopsInRecipeTableView.isHidden = false
            }
        }
    }
    
    
    var grains: [GrainWithWeight] = []
    //var grain: GrainWithWeight? = nil
    var hops: [HopWithWeight] = []
    //var hop: HopWithWeight? = nil
    
    func configureCell(recipe: Recipes){
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
        
        grains = recipe.containsGrain?.allObjects as! [GrainWithWeight]
        for grain in grains{
            print(grain.name as Any)
        }
        
        hops = recipe.containsHop?.allObjects as! [HopWithWeight]
        for hop in hops{
            print(hop.name as Any)
        }
        grainsInRecipeTableView.dataSource = self
        hopsInRecipeTableView.dataSource = self
        grainsInRecipeTableView.delegate = self
        hopsInRecipeTableView.delegate = self
        
        
        let yeast = (recipe.containsYeast?.allObjects as! [Yeasts]).first
        let cd = ColorDecider()
        
        recipeThumbNail.backgroundColor = cd.colorDecider(recipe: recipe)
        recipeTitleLabel?.text = recipe.name
        recipeYeastNameLabel.text = yeast?.name
        recipeOGLabel?.text = NSString(format: "%.3f", recipe.calcOG()) as String
        recipeIBULabel?.text = NSString(format: "%.1f", recipe.calcIBU()) as String
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == grainsInRecipeTableView{
            return grains.count
        }
        if tableView == hopsInRecipeTableView{
            return hops.count
        }
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == grainsInRecipeTableView{
            let cell = grainsInRecipeTableView!.dequeueReusableCell(withIdentifier: "Grain in Recipe Cell", for: indexPath) as! GrainsInRecipeCell
            let grain = grains[indexPath.row]
            print(indexPath.row)
            print("Grain Name: \(grain.name!)")
            cell.configureCell(grain: grain)
            return cell
        }
        if tableView == hopsInRecipeTableView {
            let cell = hopsInRecipeTableView!.dequeueReusableCell(withIdentifier: "Hop in Recipe Cell", for: indexPath) as! HopsInRecipeCell
            let hop = hops[indexPath.row]
            print(indexPath.row)
            print("Hop Name: \(hop.name!)")
            cell.configureCell(hop: hop)
            return cell
        }
        return UITableViewCell()
    }
    
}

class GrainsInRecipeCell: UITableViewCell{
    @IBOutlet weak var grainNameLabel: UILabel!
    @IBOutlet weak var grainWeightLabel: UILabel!
    @IBOutlet weak var grainThumbNail: UIImageView!

    
    func configureCell(grain: GrainWithWeight){
        grainNameLabel.text = grain.name
        grainWeightLabel.text = NSString(format: "%.2f", grain.weight) as String
        grainThumbNail.backgroundColor = ColorDecider().colorDecider(color: grain.srm)
    }
    
}

class HopsInRecipeCell: UITableViewCell{
    @IBOutlet weak var hopNameLabel: UILabel!
    @IBOutlet weak var hopWeightLabel: UILabel!
    @IBOutlet weak var hopTimeLabel: UILabel!

    func configureCell(hop: HopWithWeight){
        hopNameLabel.text = hop.name
        hopWeightLabel.text = NSString(format: "%.2f", hop.weight) as String
        hopTimeLabel.text = NSString(format: "%d", hop.time) as String

    }
    
}


class ArchivedRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeTableView: UITableView!
    var expandedRows = Set<Int>()

    
    var recipeList: [Recipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        
        recipeTableView!.dataSource = self
        recipeTableView!.delegate = self
        recipeTableView!.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        recipeTableView!.dataSource = self
        recipeTableView!.delegate = self
        
        recipeTableView?.reloadData()
        
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getData(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recipeList = try moc.fetch(Recipes.fetchRequest())
        } catch {}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipeList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "Recipe Cell", for: indexPath) as! RecipeCell
        let recipe = recipeList[indexPath.row]
        cell.configureCell(recipe: recipe)
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        guard let cell = recipeTableView.cellForRow(at: indexPath) as? RecipeCell
            
            else { return }
        self.expandedRows.removeAll()

        switch cell.isExpanded
            
        {
        case true:
            self.expandedRows.remove(indexPath.row)

        case false:
            self.expandedRows.insert(indexPath.row)
        }
        self.expandedRows.removeAll()
        cell.isExpanded = !cell.isExpanded
        recipeTableView.beginUpdates()
        recipeTableView.endUpdates()
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let recipe = recipeList[indexPath.row]
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            moc.delete(recipe)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            recipeList.remove(at: recipeList.index(of: recipe)!)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            recipeTableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath){
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(recipeTableView.indexPathForSelectedRow?.row == indexPath.row){
            return 250;
        }else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "Edit Recipe" {
                let recipe = recipeList[(recipeTableView.indexPathForSelectedRow?.row)!]
                let editRecipeVc: EditRecipeViewController = segue.destination as! EditRecipeViewController
                print(recipe.batchSize)
                editRecipeVc.initialRecipeBatchSize = recipe.batchSize
                editRecipeVc.initialRecipeName = recipe.name!
                editRecipeVc.initialRecipeInfo = recipe.info!
                editRecipeVc.initialSelectedHops = recipe.containsHop?.allObjects as! [HopWithWeight]
                editRecipeVc.initialSelectedGrains = recipe.containsGrain?.allObjects as! [GrainWithWeight]
            
            }
    }
}












