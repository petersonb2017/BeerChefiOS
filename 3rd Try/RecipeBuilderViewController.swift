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
    
    @IBOutlet weak var yeastPickerView: UIPickerView?
    @IBOutlet weak var yeastAdditionsTableView: UITableView?
    var yeastList: [Yeasts] = []
    
    @IBAction func addGrainButton(){

        let grain: Grains = grainList[(grainPickerView?.selectedRow(inComponent: 0))!]
        grainSelected.append(grain)
        print(grain)
        grainWeights.append(Double((grainWeightTextField?.text)!)!)
        grainAdditionsTableView?.reloadData()
        
    }
    
    @IBAction func addHopButton(){
        
    }
    
    @IBAction func addYeastButton(){
        
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
    
        grainAdditionsTableView?.reloadData()
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
        return grainSelected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let grain = grainSelected[indexPath.row]
        cell.textLabel?.text = "Name: \(grain.name!) Weight: \(grainWeights[grainSelected.index(of: grain)!])"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let grain = grainSelected[indexPath.row]
            grainSelected.remove(at: grainSelected.index(of: grain)!)
            grainAdditionsTableView?.reloadData()
        }
    }
}

