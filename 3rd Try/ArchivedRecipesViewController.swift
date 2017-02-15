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

class RecipeCell: UITableViewCell{

    @IBOutlet weak var recipeIBULabel: UILabel!
    @IBOutlet weak var recipeYeastNameLabel: UILabel!
    @IBOutlet weak var recipeOGLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeThumbNail: UIImageView!
    
    func configureCell(recipe: Recipes){
        let grains = recipe.containsGrain as! [GrainWithWeight]
        let hops = recipe.containsHop as! [HopWithWeight]
        let yeast = (recipe.containsYeast as! [Yeasts]).first
        
    }


}

class GrainsInRecipeCell: UITableViewCell{
    @IBOutlet weak var grainNameLabel: UILabel!
    @IBOutlet weak var grainWeightLabel: UILabel!
    @IBOutlet weak var hopThumbNail: UIImageView!
    
}

class HopsInRecipeCell: UITableViewCell{
    @IBOutlet weak var hopNameLabel: UILabel!
    @IBOutlet weak var hopWeightLabel: UILabel!
    @IBOutlet weak var hopTimeLabel: UILabel!
    @IBOutlet weak var hopThumbNail: UIImageView!
    
}


class ArchivedRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var grainsInRecipeTableView: UITableView!
    @IBOutlet weak var hopsInRecipeTableView: UITableView!

    
    var recipeList: [Recipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        
        recipeTableView!.dataSource = self
        recipeTableView!.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        

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
        
        let cd = ColorDecider()
        cell.recipeThumbNail.backgroundColor = cd.colorDecider(recipe: recipe)
        cell.recipeTitleLabel?.text = recipe.name
        cell.recipeOGLabel?.text = NSString(format: "%.3f", recipe.calcOG()) as String
        cell.recipeFGLabel?.text = NSString(format: "%.3f", recipe.calcFG()) as String
        cell.recipeIBULabel?.text = NSString(format: "%.1f", recipe.calcIBU()) as String
        cell.recipeABVLabel?.text = NSString(format: "%.2f", recipe.calcABV()) as String
        return cell

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
    
    
}

