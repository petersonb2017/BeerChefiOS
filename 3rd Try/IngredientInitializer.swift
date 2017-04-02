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
        let initialGrainList = [
                                Grains(name: "2-Row Pale Malt", ppg: 37, srm: 1.8, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "Munich Malt", ppg: 35, srm: 10, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "6-Row Brewers Malt", ppg: 35, srm: 1.8, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "Amber Malt", ppg: 32.5, srm: 1.5, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "Biscuit Malt", ppg: 35, srm: 24.5, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Brown Malt", ppg: 32, srm: 60, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "CaraPils Malt", ppg: 32, srm: 1.5, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 10", ppg: 35, srm: 10, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 20", ppg: 34, srm: 20, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 40", ppg: 34, srm: 40, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 60", ppg: 34, srm: 60, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 80", ppg: 34, srm: 80, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 100", ppg: 34, srm: 100, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Crystal 120", ppg: 33, srm: 120, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Special B", ppg: 31, srm: 120, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Chocolate Malt", ppg: 31, srm: 350, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Roasted Barley", ppg: 31, srm: 300, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Black Patent Malt", ppg: 31, srm: 500, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Wheat Malt", ppg: 37, srm: 2.3, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Rye Malt", ppg: 29, srm: 3.7, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Oats", ppg: 32, srm: 1, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Corn", ppg: 39, srm: 1, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Barley", ppg: 32, srm: 2, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Wheat", ppg: 36, srm: 2, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Flaked Rice", ppg: 38, srm: 1, isExtract: false,insertIntoManagedObjectContext: moc)
        ]
        
        let initialHopList = [
            Hops(name: "East Kent Goldings", aa: 5.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Fuggles", aa: 4, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Crystal", aa: 3, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Hallertauer", aa: 3.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Liberty", aa: 3.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Mt. Hood", aa: 5.6, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Saaz", aa: 3.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Willamette", aa: 6.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Brewers Gold", aa: 9.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Chinook", aa: 13.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Magnum", aa: 13.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Nugget", aa: 12.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Perle", aa: 8.25, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Simcoe", aa: 13.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Warrior", aa: 16.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Amarillo", aa: 9.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Centennial", aa: 10.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Challenger", aa: 7.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Cluster", aa: 7.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Columbus", aa: 14.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Horizon", aa: 12.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Northern Brewer", aa: 5.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Santiam", aa: 6.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Sterling", aa: 7.5, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Target", aa: 9.0, pellet: true, insertIntoManagedObjectContext: moc)
        ]
        
        let initialYeastList = [
            Yeasts(name: "Coopers Ale", attenLow: 75, attenHigh: 85, fermTempLow: 65, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 1056 American Ale", attenLow: 73, attenHigh: 77, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 1272 American Ale II", attenLow: 72, attenHigh: 76, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "American Ale WLP060", attenLow: 72, attenHigh: 82, fermTempLow: 68, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "California Ale WLP051", attenLow: 73, attenHigh: 80, fermTempLow: 68, fermTempHigh: 73, insertIntoManagedObjectContext: moc),
            Yeasts(name: "US-05 Fermentis", attenLow: 77, attenHigh: 81, fermTempLow: 59, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Muntons Standard", attenLow: 75, attenHigh: 85, fermTempLow: 57, fermTempHigh: 77, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 2035 American Lager", attenLow: 75, attenHigh: 85, fermTempLow: 65, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Cream Ale WLP80", attenLow: 75, attenHigh: 80, fermTempLow: 65, fermTempHigh: 70, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 2112 California Lager", attenLow: 67, attenHigh: 71, fermTempLow: 58, fermTempHigh: 68, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 3711 French Saison", attenLow: 77, attenHigh: 85, fermTempLow: 65, fermTempHigh: 77, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 1098 British Ale", attenLow: 73, attenHigh: 75, fermTempLow: 64, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Nottingham", attenLow: 77, attenHigh: 85, fermTempLow: 57, fermTempHigh: 70, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Safale S-04", attenLow: 78, attenHigh: 80, fermTempLow: 59, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 3638 Bavarian Wheat", attenLow: 70, attenHigh: 76, fermTempLow: 64, fermTempHigh: 75, insertIntoManagedObjectContext: moc)
        ]
    }
}
