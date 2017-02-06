//
//  ArchivedRecipesViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/22/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData

class ArchivedRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeTableView: UITableView!
    
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
        let cell = UITableViewCell()
        let recipe = recipeList[indexPath.row]
        cell.textLabel?.text = "Name: \(recipe.name!) Info: \(recipe.info!)"
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

