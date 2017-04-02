//
//  BeerTabBarController.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/21/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import UIKit
import CoreData

class BeerTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var grainList = [Grains]()
        var hopList = [Hops]()
        var yeastList = [Yeasts]()
        do{
            let fetchGrain = NSFetchRequest<NSFetchRequestResult>(entityName: "Grains")
            let fetchHop = NSFetchRequest<NSFetchRequestResult>(entityName: "Hops")
            let fetchYeast = NSFetchRequest<NSFetchRequestResult>(entityName: "Yeasts")
            
            grainList = try moc.fetch(fetchGrain) as! [Grains]
            hopList = try moc.fetch(fetchHop) as! [Hops]
            yeastList = try moc.fetch(fetchYeast) as! [Yeasts]
        } catch {}
        if grainList.isEmpty && hopList.isEmpty && yeastList.isEmpty{
            IngredientInitializer().addBaseIngredients()
        }

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
