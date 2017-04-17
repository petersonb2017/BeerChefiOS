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

class ArchivedRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeTableView: UITableView!
    var emptyLabel: UILabel = UILabel()
    var recipeList: [Recipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        recipeTableView!.dataSource = self
        recipeTableView!.delegate = self
        recipeTableView!.rowHeight = UITableViewAutomaticDimension
        emptyLabel.text = ""
        checkEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        self.navigationController?.isNavigationBarHidden = true
        recipeTableView!.dataSource = self
        recipeTableView!.delegate = self
        emptyLabel.text = ""
        checkEmpty()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getData(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{recipeList = try moc.fetch(Recipes.fetchRequest())} catch {}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipeList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "Recipe Cell", for: indexPath) as! RecipeCell
            let recipe = recipeList[indexPath.row]
            cell.configureCell(recipe: recipe)
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
            checkEmpty()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 65
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func setEmptyTableLabel(){
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*(2.0/3.0), height: self.view.frame.height/3))
        emptyLabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        emptyLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
        emptyLabel.textColor = UIColor(red: 84.0/255.0, green: 61.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        emptyLabel.adjustsFontSizeToFitWidth = true
        emptyLabel.numberOfLines = 2
        emptyLabel.textAlignment = .center
        emptyLabel.text = "No Recipes Added \nGet Brewing!"
        self.view.addSubview(emptyLabel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Select Recipe"{
            let destVC: RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            destVC.recipe = recipeList[(recipeTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func checkEmpty(){
        if(recipeList.isEmpty){
            setEmptyTableLabel()
        }else{
            emptyLabel.text = ""
            recipeTableView?.reloadData()
        }
    }
}












