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
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        _ =  [Grains(name: "2 Row Pale Malt", ppg: 37, srm: 1.8, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "Munich Malt", ppg: 35, srm: 10, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "6 Row Brewers Malt", ppg: 35, srm: 1.8, isExtract: false, insertIntoManagedObjectContext: moc),
                                Grains(name: "Amber Malt", ppg: 32.5, srm: 22.0, isExtract: false, insertIntoManagedObjectContext: moc),
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
                                Grains(name: "Flaked Rice", ppg: 38, srm: 1, isExtract: false,insertIntoManagedObjectContext: moc),
                                Grains(name: "Sugar", ppg: 46, srm: 0.0, isExtract: true,insertIntoManagedObjectContext: moc),
                                Grains(name: "Light LME", ppg: 36, srm: 4, isExtract: true,insertIntoManagedObjectContext: moc),
                                Grains(name: "Light DME", ppg: 44, srm: 4, isExtract: true,insertIntoManagedObjectContext: moc),
                                Grains(name: "Amber LME", ppg: 36, srm: 10, isExtract: true,insertIntoManagedObjectContext: moc),
                                Grains(name: "Amber DME", ppg: 44, srm: 10, isExtract: true,insertIntoManagedObjectContext: moc),
                                Grains(name: "Dark LME", ppg: 36, srm: 30, isExtract: true,insertIntoManagedObjectContext: moc),
                                Grains(name: "Dark DME", ppg: 44, srm: 30, isExtract: true,insertIntoManagedObjectContext: moc)
        ]
        
        _  = [Hops(name: "East Kent Goldings", aa: 5.0, pellet: true, insertIntoManagedObjectContext: moc),
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
            Hops(name: "Target", aa: 9.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Mosiac", aa: 12.0, pellet: true, insertIntoManagedObjectContext: moc),
            Hops(name: "Cascade", aa: 5.0, pellet: true, insertIntoManagedObjectContext: moc)
        ]
        
        _ =  [Yeasts(name: "Coopers Ale", attenLow: 75, attenHigh: 85, fermTempLow: 65, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            //Yeasts(name: "Wyeast 1056 American Ale", attenLow: 73, attenHigh: 77, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            //Yeasts(name: "Wyeast 1272 American Ale II", attenLow: 72, attenHigh: 76, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "American Ale WLP060", attenLow: 72, attenHigh: 82, fermTempLow: 68, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "California Ale WLP051", attenLow: 73, attenHigh: 80, fermTempLow: 68, fermTempHigh: 73, insertIntoManagedObjectContext: moc),
            Yeasts(name: "US-05 Fermentis", attenLow: 77, attenHigh: 81, fermTempLow: 59, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Muntons Standard", attenLow: 75, attenHigh: 85, fermTempLow: 57, fermTempHigh: 77, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 2035 American Lager", attenLow: 75, attenHigh: 85, fermTempLow: 48, fermTempHigh: 58, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Cream Ale WLP80", attenLow: 75, attenHigh: 80, fermTempLow: 65, fermTempHigh: 70, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 2112 California Lager", attenLow: 67, attenHigh: 71, fermTempLow: 58, fermTempHigh: 68, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Wyeast 3711 French Saison", attenLow: 77, attenHigh: 85, fermTempLow: 65, fermTempHigh: 77, insertIntoManagedObjectContext: moc),
            //Yeasts(name: "Wyeast 1098 British Ale", attenLow: 73, attenHigh: 75, fermTempLow: 64, fermTempHigh: 72, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Nottingham", attenLow: 77, attenHigh: 85, fermTempLow: 57, fermTempHigh: 70, insertIntoManagedObjectContext: moc),
            Yeasts(name: "Safale S-04", attenLow: 78, attenHigh: 80, fermTempLow: 59, fermTempHigh: 75, insertIntoManagedObjectContext: moc),
            //Yeasts(name: "Wyeast 3638 Bavarian Wheat", attenLow: 70, attenHigh: 76, fermTempLow: 64, fermTempHigh: 75, insertIntoManagedObjectContext: moc)
        ]
        
        let recipe1Info = "This is a single hop IPA that is does it's best to accentuate the complexities of the Mosiac hop. This is a hop first beer that should have plenty of both bitterness and aroma hop additions."
        let recipe1Name = "Mosaic IPA"
        let recipe1Grains: Set<GrainWithWeight> = [
            GrainWithWeight(name: "Light LME", ppg: 36, srm: 4, isExtract: true, weight: 6.0, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "Crystal 40", ppg: 34, srm: 40, isExtract: false, weight: 1.0, insertIntoManagedObjectContext: moc)
        ]
        let recipe1Hops: Set<HopWithWeight> = [
            HopWithWeight(name: "Mosaic", aa: 12, pellet: true, time: 60, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Mosaic", aa: 12, pellet: true, time: 45, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Mosaic", aa: 12, pellet: true, time: 30, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Mosaic", aa: 12, pellet: true, time: 10, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Mosaic", aa: 12, pellet: true, time: 0, weight: 1, insertIntoManagedObjectContext: moc)
        ]
        let recipe1Yeast: Set<Yeasts> = [Yeasts(name: "Wyeast 1272 American Ale II", attenLow: 72, attenHigh: 76, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc)]
        
        
        let recipe2Info = "This is a prototypical wheat beer. Lots of banana and clove from the yeast. This should be a light crisp beer."
        let recipe2Name = "Bauhaus Bavarian Wheat"
        let recipe2Grains: Set<GrainWithWeight> = [
            GrainWithWeight(name: "Wheat Malt", ppg: 37, srm: 2.3, isExtract: false, weight: 6.0, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "2 Row Pale Malt", ppg: 37, srm: 1.8, isExtract: false, weight: 6.0, insertIntoManagedObjectContext: moc)
        ]
        let recipe2Hops: Set<HopWithWeight> = [
            HopWithWeight(name: "Hallertauer", aa: 3.5, pellet: true, time: 60, weight: 2, insertIntoManagedObjectContext: moc)
        ]
        let recipe2Yeast: Set<Yeasts> = [Yeasts(name: "Wyeast 3638 Bavarian Wheat", attenLow: 70, attenHigh: 76, fermTempLow: 64, fermTempHigh: 75, insertIntoManagedObjectContext: moc)]
        
        let recipe3Info = "A hoppy red ale. A little bit of roastiness on the back end."
        let recipe3Name = "Big Red"
        let recipe3Grains: Set<GrainWithWeight> = [
            GrainWithWeight(name: "Crystal 80", ppg: 34, srm: 80, isExtract: false, weight: 1.0, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "Biscuit Malt", ppg: 35, srm: 24.5, isExtract: false, weight: 1.0, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "2 Row Pale Malt", ppg: 37, srm: 1.8, isExtract: false, weight: 12.0, insertIntoManagedObjectContext: moc)
        ]
        let recipe3Hops: Set<HopWithWeight> = [
            HopWithWeight(name: "Mosaic", aa: 12, pellet: true, time: 60, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Cascade", aa: 5, pellet: true, time: 45, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Centennial", aa: 10.0, pellet: true, time: 30, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Centennial", aa: 10.0, pellet: true, time: 10, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Mt. Hood", aa: 5.6, pellet: true, time: 0, weight: 1, insertIntoManagedObjectContext: moc)
        ]
        let recipe3Yeast: Set<Yeasts> = [Yeasts(name: "Wyeast 1056 American Ale", attenLow: 73, attenHigh: 77, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc)]
        
        let recipe4Info = "A classic american pale ale. Hop forward but not bitter, with some malt and a little color. Refreshing and delicious!"
        let recipe4Name = "Beyone the Pale"
        let recipe4Grains: Set<GrainWithWeight> = [
            GrainWithWeight(name: "Crystal 20", ppg: 34, srm: 20, isExtract: false, weight: 0.5, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "Biscuit Malt", ppg: 35, srm: 24.5, isExtract: false, weight: 0.25, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "2 Row Pale Malt", ppg: 37, srm: 1.8, isExtract: false, weight: 10.0, insertIntoManagedObjectContext: moc)
        ]
        let recipe4Hops: Set<HopWithWeight> = [
            HopWithWeight(name: "Northern Brewer", aa: 5.0, pellet: true, time: 60, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Simcoe", aa: 13.0, pellet: true, time: 30, weight: 1, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "Cluster", aa: 7.5, pellet: true, time: 0, weight: 1, insertIntoManagedObjectContext: moc)
        ]
        let recipe4Yeast: Set<Yeasts> = [Yeasts(name: "Wyeast 1056 American Ale", attenLow: 73, attenHigh: 77, fermTempLow: 60, fermTempHigh: 72, insertIntoManagedObjectContext: moc)]
        
        let recipe5Info = "A classic stout. Roasty and sweet."
        let recipe5Name = "Little Tea Pot Stout"
        let recipe5Grains: Set<GrainWithWeight> = [
            GrainWithWeight(name: "Black Patent Malt", ppg: 31, srm: 500, isExtract: false, weight: 0.5, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "Munich Malt", ppg: 35, srm: 10, isExtract: false, weight: 1.5, insertIntoManagedObjectContext: moc),
            GrainWithWeight(name: "2 Row Pale Malt", ppg: 37, srm: 1.8, isExtract: false, weight: 10.0, insertIntoManagedObjectContext: moc)
        ]
        let recipe5Hops: Set<HopWithWeight> = [
            HopWithWeight(name: "East Kent Goldings", aa: 5.0, pellet: true, time: 60, weight: 2, insertIntoManagedObjectContext: moc),
            HopWithWeight(name: "East Kent Goldings", aa: 5.0, pellet: true, time: 0, weight: 1, insertIntoManagedObjectContext: moc)
        ]
        let recipe5Yeast: Set<Yeasts> = [Yeasts(name: "Wyeast 1098 British Ale", attenLow: 73, attenHigh: 75, fermTempLow: 64, fermTempHigh: 72, insertIntoManagedObjectContext: moc)]
        
        
        _ = [Recipes(batchSize: 5, info: recipe1Info, name: recipe1Name, efficiency: 0.73, grains: recipe1Grains as NSSet, hops: recipe1Hops as NSSet, yeast: recipe1Yeast as NSSet, insertIntoManagedObjectContext: moc),
             Recipes(batchSize: 5, info: recipe2Info, name: recipe2Name, efficiency: 0.75, grains: recipe2Grains as NSSet, hops: recipe2Hops as NSSet, yeast: recipe2Yeast as NSSet, insertIntoManagedObjectContext: moc),
             Recipes(batchSize: 5, info: recipe3Info, name: recipe3Name, efficiency: 0.75, grains: recipe3Grains as NSSet, hops: recipe3Hops as NSSet, yeast: recipe3Yeast as NSSet, insertIntoManagedObjectContext: moc),
             Recipes(batchSize: 5, info: recipe4Info, name: recipe4Name, efficiency: 0.75, grains: recipe4Grains as NSSet, hops: recipe4Hops as NSSet, yeast: recipe4Yeast as NSSet, insertIntoManagedObjectContext: moc),
             Recipes(batchSize: 5, info: recipe5Info, name: recipe5Name, efficiency: 0.75, grains: recipe5Grains as NSSet, hops: recipe5Hops as NSSet, yeast: recipe5Yeast as NSSet, insertIntoManagedObjectContext: moc)
        ]
    }
}
