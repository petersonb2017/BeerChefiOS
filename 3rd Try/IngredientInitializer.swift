//
//  File.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/21/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class IngredientInitializer{
    func addBaseIngredients(){
        var grainList: [Grains] = []
        var hopList: [Hops]
        var yeastList: [Yeasts]
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
        let initialGrainList = [Grains(name: "2-Row Pale Malt", ppg: 37, srm: 1.8, insertIntoManagedObjectContext: moc),Grains(name: "Munich Malt", ppg: 35, srm: 10, insertIntoManagedObjectContext: moc),
                                Grains(name: "6-Row Brewers Malt", ppg: 35, srm: 1.8, insertIntoManagedObjectContext: moc),
                                Grains(name: "Amber Malt", ppg: 32.5, srm: 1.5, insertIntoManagedObjectContext: moc),
                                Grains(name: "Biscuit Malt", ppg: 35, srm: 24.5, insertIntoManagedObjectContext: moc),
                                Grains(name: "Brown Malt", ppg: 32, srm: 60, insertIntoManagedObjectContext: moc),
                                Grains(name: "CaraPils Malt", ppg: 32, srm: 1.5, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 10", ppg: 35, srm: 10, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 20", ppg: 34, srm: 20, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 40", ppg: 34, srm: 40, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 60", ppg: 34, srm: 60, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 80", ppg: 34, srm: 80, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 100", ppg: 34, srm: 100, insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 120", ppg: 33, srm: 120, insertIntoManagedObjectContext: moc),
                                Grains(name: "Special B", ppg: 31, srm: 120, insertIntoManagedObjectContext: moc),
                                Grains(name: "Chocolate Malt", ppg: 31, srm: 350, insertIntoManagedObjectContext: moc),
                                Grains(name: "Roasted Barley", ppg: 31, srm: 300, insertIntoManagedObjectContext: moc),
                                Grains(name: "Black Patent Malt", ppg: 31, srm: 500, insertIntoManagedObjectContext: moc),
                                Grains(name: "Wheat Malt", ppg: 37, srm: 2.3, insertIntoManagedObjectContext: moc),
                                Grains(name: "Rye Malt", ppg: 29, srm: 3.7, insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Oats", ppg: 32, srm: 1, insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Corn", ppg: 39, srm: 1, insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Barley", ppg: 32, srm: 2, insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Wheat", ppg: 36, srm: 2, insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Rice", ppg: 38, srm: 1, insertIntoManagedObjectContext: moc)
        ]
        
        for grain in initialGrainList{
            if grainList.contains(grain){
            }else{
                
            }
        }
    }
}
