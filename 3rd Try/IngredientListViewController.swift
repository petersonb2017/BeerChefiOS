//
//  IngredientListViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/17/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData

class IngredientListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ingredientListTableView: UITableView!
    
    
    let sections = ["Grains", "Hops", "Yeast"]
    var grainList: [Grains] = []
    var hopList: [Hops] = []
    var yeastList: [Yeasts] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.hideKeyboardWhenTappedAround()
        ingredientListTableView.dataSource = self
        ingredientListTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        ingredientListTableView.dataSource = self
        ingredientListTableView.delegate = self
        ingredientListTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{ return grainList.count
        }else if section == 1{ return hopList.count
        }else {return yeastList.count}
    }
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return sections[0]
        }else if section == 1
        {
            return sections[1]
        }else {
            return sections[2]
        }
    }*/
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        if indexPath.section == 0{
            let cell = ingredientListTableView!.dequeueReusableCell(withIdentifier: "Ingredient Grain Cell", for: indexPath) as! IngredientGrainCell
            let grain = grainList[indexPath.row]
            cell.configureCell(grain: grain)
            return cell
        }else if indexPath.section == 1{
            let cell = ingredientListTableView!.dequeueReusableCell(withIdentifier: "Ingredient Hop Cell", for: indexPath as IndexPath) as! IngredientHopCell
            cell.configureCell(hop: hopList[indexPath.row])
            return cell
        }else{
            let cell = ingredientListTableView!.dequeueReusableCell(withIdentifier: "Ingredient Yeast Cell", for: indexPath as IndexPath) as! IngredientYeastCell
            cell.configureCell(yeast: yeastList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete{
                let grain = grainList[indexPath.row]
                let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                moc.delete(grain)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                grainList.remove(at: grainList.index(of: grain)!)
                ingredientListTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                ingredientListTableView.reloadData()
            }
        } else if indexPath.section == 1{
            if editingStyle == .delete{
                let hop = hopList[indexPath.row]
                let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                moc.delete(hop)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                hopList.remove(at: hopList.index(of: hop)!)
                ingredientListTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                ingredientListTableView.reloadData()
            }
        } else{
            if editingStyle == .delete{
                let yeast = yeastList[indexPath.row]
                let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                moc.delete(yeast)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                yeastList.remove(at: yeastList.index(of: yeast)!)
                ingredientListTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                ingredientListTableView.reloadData()
            }
        }
    }
    

    
    func getData(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grains")
            let sectionSortDescriptor = NSSortDescriptor(key: "srm", ascending: true)
            let sectionSortDescriptor0 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sectionSortDescriptor, sectionSortDescriptor0]
            fetchRequest.sortDescriptors = sortDescriptors
            grainList = try moc.fetch(fetchRequest) as! [Grains]
        } catch {}
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hops")
            let sectionSortDescriptor = NSSortDescriptor(key: "aa", ascending: true)
            let sectionSortDescriptor0 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sectionSortDescriptor, sectionSortDescriptor0]
            fetchRequest.sortDescriptors = sortDescriptors
            hopList = try moc.fetch(fetchRequest) as! [Hops]
        } catch {}
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Yeasts")
            let sectionSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sectionSortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            yeastList = try moc.fetch(fetchRequest) as! [Yeasts]
        } catch {}
        
    }
    

}
