//
//  IngregientTableViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/13/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData

class IngredientGrainCell: UITableViewCell{
    @IBOutlet weak var srmLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    @IBOutlet weak var grainIcon: UIImageView!
    
    public func configureCell(grain: Grains){
        let cd = ColorDecider()
        self.grainIcon.backgroundColor = cd.colorDecider(grain: grain)
        self.nameLabel.text = grain.name
        self.ppgLabel.text = NSString(format: "%.1f", grain.ppg) as String
        self.srmLabel.text = NSString(format: "%.1f", grain.srm) as String
    }
}

class IngredientHopCell: UITableViewCell{
    @IBOutlet weak var aaLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    public func configureCell(hop: Hops){
        self.nameLabel.text = hop.name
        self.aaLabel.text = NSString(format: "%.1f", hop.aa) as String
    }
    
}

class IngredientYeastCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    public func configureCell(yeast: Yeasts){
        self.nameLabel.text = yeast.name
    }
}

class IngregientTableViewController: UITableViewController {
    let sections = ["Grains", "Hops", "Yeast"]
    var grainList: [Grains] = []
    var hopList: [Hops] = []
    var yeastList: [Yeasts] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getData()
        self.tableView.dataSource = self
        self.tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{ return grainList.count
        }else if section == 1{ return hopList.count
        }else {return yeastList.count}
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{ return sections[0]
        }else if section == 1{ return sections[1]
        }else {return sections[2]}
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        if indexPath.section == 0{
            let cell = self.tableView!.dequeueReusableCell(withIdentifier: "Ingredient Grain Cell", for: indexPath) as! IngredientGrainCell
            let grain = grainList[indexPath.row]
            cell.configureCell(grain: grain)
            return cell
        }else if indexPath.section == 1{
            let cell = self.tableView!.dequeueReusableCell(withIdentifier: "Ingredient Hop Cell", for: indexPath as IndexPath) as! IngredientHopCell
            cell.configureCell(hop: hopList[indexPath.row])
            return cell
        }else{
            let cell = self.tableView!.dequeueReusableCell(withIdentifier: "Ingredient Yeast Cell", for: indexPath as IndexPath) as! IngredientYeastCell
            cell.configureCell(yeast: yeastList[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete{
                let grain = grainList[indexPath.row]
                let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                moc.delete(grain)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                grainList.remove(at: grainList.index(of: grain)!)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.tableView?.reloadData()
            }
        } else if indexPath.section == 1{
            if editingStyle == .delete{
                let hop = hopList[indexPath.row]
                let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                moc.delete(hop)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                hopList.remove(at: hopList.index(of: hop)!)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.tableView?.reloadData()
            }
        } else{
            if editingStyle == .delete{
                let yeast = yeastList[indexPath.row]
                let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                moc.delete(yeast)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                yeastList.remove(at: yeastList.index(of: yeast)!)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.tableView?.reloadData()
            }
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getData(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grains")
            let sectionSortDescriptor = NSSortDescriptor(key: "srm", ascending: true)
            let sortDescriptors = [sectionSortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            grainList = try moc.fetch(fetchRequest) as! [Grains]
        } catch {}
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hops")
            let sectionSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sectionSortDescriptor]
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
