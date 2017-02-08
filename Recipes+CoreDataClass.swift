//
//  Recipes+CoreDataClass.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(Recipes)
public class Recipes: NSManagedObject {
    
    func calcOG() -> Double{
        var recipeOG = 1.0
        let grains = self.containsGrain?.allObjects as! [GrainWithWeight]
        
        for i in 0 ... (grains.count - 1){
            let grain = grains[i]
            recipeOG += 0.001*((grain.ppg*grain.weight)/self.batchSize)
        }
        return (1 + (recipeOG - 1)*0.8)
        
    }
    
    func calcFG() -> Double{
        let yeasts = self.containsYeast?.allObjects as! [Yeasts]
        let yeast = yeasts.first
        let attenLow = Double((yeast?.attenLow)!)
        let attenHigh = Double((yeast?.attenHigh)!)
        let avgAtten = (1-attenLow*attenHigh/200)
        let recipeFG = (1+(self.calcOG()-1)*avgAtten)
        return recipeFG
        
    }
    
    func calcIBU() -> Double{
        var recipeIBU = 0.0
        let hops = self.containsHop?.allObjects as! [HopWithWeight]
        
        for i in 0 ... (hops.count - 1){
            let hopTimesWeight = hops[i].aa*Double(hops[i].weight)
            let firstPowThing = pow(0.000125, (self.calcOG()-1)*(5.5/6.5))
            let eToTheX = (1-pow(M_E,(-0.04*Double(hops[i].time))))
            recipeIBU += ((hopTimesWeight*74.89*firstPowThing*eToTheX/4.15)/self.batchSize)
        }
        
        return recipeIBU
    }
    
    func calcABV() -> Double{
        let abv = (self.calcOG() - self.calcFG())*131.25
        //double ABV = (OG - FG)*131.25
        return abv
    }
    
    func calcSRM() -> Double{
        var srm = 0.0
        let grains = self.containsGrain?.allObjects as! [GrainWithWeight]
        
        for i in 0 ... (grains.count - 1){
            let grain = grains[i]
            srm += (grain.srm*grain.weight)/self.batchSize
        }
        return srm
    }
 
}
