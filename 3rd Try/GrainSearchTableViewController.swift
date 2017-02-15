//
//  GrainSearchTableViewController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/10/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData

class GrainSearchCell: UITableViewCell{
    @IBOutlet weak var grainNameLabel: UILabel!
    @IBOutlet weak var grainPPGLabel: UILabel!
    @IBOutlet weak var grainSRMLabel: UILabel!
    @IBOutlet weak var grainIconImage: UIImageView!
    
    public func configureCell(grain: Grains){
        let cd = ColorDecider()
        self.grainIconImage.backgroundColor = cd.colorDecider(grain: grain)
        self.grainNameLabel.text = grain.name
        self.grainPPGLabel.text = NSString(format: "%.1f", grain.ppg) as String
        self.grainSRMLabel.text = NSString(format: "%.1f", grain.srm) as String
    }
}
class GrainSearchTableViewController: UITableViewController{
    
    
    var grainList: [Grains] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.tableView.delegate = self
        self.tableView.dataSource = self


        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return grainList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView!.dequeueReusableCell(withIdentifier: "Grain Search Cell", for: indexPath) as! GrainSearchCell
        let grain = grainList[indexPath.row]
        cell.configureCell(grain: grain)
        return cell
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

    
    //Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
 

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
            grainList = try moc.fetch(Grains.fetchRequest())
        } catch {}

    }

}
