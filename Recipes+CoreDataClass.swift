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
        var recipeOG = 0.0
        let grains = self.containsGrain?.allObjects as! [GrainWithWeight]
        if(grains.isEmpty == true) {return 1.0}
        for i in 0 ... (grains.count - 1){
            let grain = grains[i]
            var extraction = self.efficiency
            if grain.isExtract == true{
                extraction = 1.0
            }
            recipeOG += 0.001*((grain.ppg*grain.weight*extraction)/self.batchSize)
        }
        return (1 + (recipeOG))
        
    }
    
    func calcFG() -> Double{
        let yeasts = self.containsYeast?.allObjects as! [Yeasts]
        if(yeasts.isEmpty == true) {return 1.0}
        let yeast = yeasts.first
        let attenLow = Double((yeast?.attenLow)!)
        let attenHigh = Double((yeast?.attenHigh)!)
        let avgAtten = (attenLow+attenHigh)/2
        //print("average atten for yeast: \(avgAtten)")
        let recipeFG = (1+(self.calcOG()-1)*(1 - avgAtten/100))
        //print("Recipe FG: \(recipeFG)")
        return recipeFG
        
    }
    
    func calcIBU() -> Double{
        var recipeIBU = 0.0
        let hops = self.containsHop?.allObjects as! [HopWithWeight]
        if(hops.isEmpty == true) {return 0.0}
        for hop in hops{
            var aa = hop.aa
            let weight = hop.weight
            let time = hop.time
            let bc = self.batchSize
            if hop.pellet{aa = aa*1.10}
            let hopTimesWeight = aa*weight
            let firstPowThing = pow(0.000125, (self.calcOG()-1)*(bc)/(bc+1))
            let eToTheX = (1-pow(M_E,(-0.04*Double(time))))
            recipeIBU += ((hopTimesWeight*74.89*firstPowThing*eToTheX/4.15)/bc)
        }
        
        return recipeIBU
    }
    
    func calcABV() -> Double{
        let abv = (self.calcOG() - self.calcFG())*131.25
        return abv
    }
    
    func calcSRM() -> Double{
        var srm = 0.0
        let grains = self.containsGrain?.allObjects as! [GrainWithWeight]
        if(grains.isEmpty == true) {return 0.0}
        for i in 0 ... (grains.count - 1){
            let grain = grains[i]
            srm += (grain.srm*grain.weight)/self.batchSize
        }
        return srm
    }
 
}
