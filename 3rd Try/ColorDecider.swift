//
//  File.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/6/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class ColorDecider{
    public func colorDecider(grain: Grains) -> UIImage{
        let srm = grain.srm
        
        if srm<3 {
            return #imageLiteral(resourceName: "Grain-Icon-1")
        }else if srm<4 {
            return #imageLiteral(resourceName: "Grain-Icon-2")
        }else if srm<6 {
            return #imageLiteral(resourceName: "Grain-Icon-3")
        }else if srm<9 {
            return #imageLiteral(resourceName: "Grain-Icon-4")
        }else if srm<12 {
            return #imageLiteral(resourceName: "Grain-Icon-5")
        }else if srm<15 {
            return #imageLiteral(resourceName: "Grain-Icon-6")
        }else if srm<18 {
            return #imageLiteral(resourceName: "Grain-Icon-7")
        }else if srm<20 {
            return #imageLiteral(resourceName: "Grain-Icon-8")
        }else if srm<24 {
            return #imageLiteral(resourceName: "Grain-Icon-9")
        }else if srm<30 {
            return #imageLiteral(resourceName: "Grain-Icon-10")
        }else/*srm<40*/ {
            return #imageLiteral(resourceName: "Grain-Icon-11")
        }
    }
    
    public func colorDecider(recipe: Recipes) -> UIImage{
        let srm = recipe.calcSRM()
        
        if srm<3 {
            return #imageLiteral(resourceName: "Recipe-Icon-1")
        }else if srm<4 {
            return #imageLiteral(resourceName: "Recipe-Icon-2")
        }else if srm<6 {
            return #imageLiteral(resourceName: "Recipe-Icon-3")
        }else if srm<9 {
            return #imageLiteral(resourceName: "Recipe-Icon-4")
        }else if srm<12 {
            return #imageLiteral(resourceName: "Recipe-Icon-5")
        }else if srm<15 {
            return #imageLiteral(resourceName: "Recipe-Icon-6")
        }else if srm<18 {
            return #imageLiteral(resourceName: "Recipe-Icon-7")
        }else if srm<20 {
            return #imageLiteral(resourceName: "Recipe-Icon-8")
        }else if srm<24 {
            return #imageLiteral(resourceName: "Recipe-Icon-9")
        }else if srm<30 {
            return #imageLiteral(resourceName: "Recipe-Icon-10")
        }else /*srm<40*/ {
            return #imageLiteral(resourceName: "Recipe-Icon-11")
        }
    }
    
    public func colorDeciderRecipe(color: Double) -> UIImage{
        let srm = color
        
        if srm<3 {
            return #imageLiteral(resourceName: "Recipe-Icon-1")
        }else if srm<4 {
            return #imageLiteral(resourceName: "Recipe-Icon-2")
        }else if srm<6 {
            return #imageLiteral(resourceName: "Recipe-Icon-3")
        }else if srm<9 {
            return #imageLiteral(resourceName: "Recipe-Icon-4")
        }else if srm<12 {
            return #imageLiteral(resourceName: "Recipe-Icon-5")
        }else if srm<15 {
            return #imageLiteral(resourceName: "Recipe-Icon-6")
        }else if srm<18 {
            return #imageLiteral(resourceName: "Recipe-Icon-7")
        }else if srm<20 {
            return #imageLiteral(resourceName: "Recipe-Icon-8")
        }else if srm<24 {
            return #imageLiteral(resourceName: "Recipe-Icon-9")
        }else if srm<30 {
            return #imageLiteral(resourceName: "Recipe-Icon-10")
        }else /*srm<40*/ {
            return #imageLiteral(resourceName: "Recipe-Icon-11")
        }
    }
    
    public func colorDecider(hop: HopWithWeight) -> UIImage{
        let aa: Double = hop.aa
        if(aa<5){
            return #imageLiteral(resourceName: "Hop-Icon-1")
        }else if(aa<7){
            return #imageLiteral(resourceName: "Hop-Icon-2")
        }else if(aa<9){
            return #imageLiteral(resourceName: "Hop-Icon-3")
        }else if(aa<11){
            return #imageLiteral(resourceName: "Hop-Icon-4")
        }else if(aa<13){
            return #imageLiteral(resourceName: "Hop-Icon-5")
        }else if(aa<15){
            return #imageLiteral(resourceName: "Hop-Icon-6")
        }else/* aa>15 */{
            return #imageLiteral(resourceName: "Hop-Icon-7")
        }

    }
    
    public func colorDecider(hop: Hops) -> UIImage{
        let aa: Double = hop.aa
        if(aa<5){
            return #imageLiteral(resourceName: "Hop-Icon-1")
        }else if(aa<7){
            return #imageLiteral(resourceName: "Hop-Icon-2")
        }else if(aa<9){
            return #imageLiteral(resourceName: "Hop-Icon-3")
        }else if(aa<11){
            return #imageLiteral(resourceName: "Hop-Icon-4")
        }else if(aa<13){
            return #imageLiteral(resourceName: "Hop-Icon-5")
        }else if(aa<15){
            return #imageLiteral(resourceName: "Hop-Icon-6")
        }else/* aa>15 */{
            return #imageLiteral(resourceName: "Hop-Icon-7")
        }
    }
    
    public func colorDecider(color: Double) -> UIImage{
        let srm = color
        
        if srm<3 {
            return #imageLiteral(resourceName: "Grain-Icon-1")
        }else if srm<4 {
            return #imageLiteral(resourceName: "Grain-Icon-2")
        }else if srm<6 {
            return #imageLiteral(resourceName: "Grain-Icon-3")
        }else if srm<9 {
            return #imageLiteral(resourceName: "Grain-Icon-4")
        }else if srm<12 {
            return #imageLiteral(resourceName: "Grain-Icon-5")
        }else if srm<15 {
            return #imageLiteral(resourceName: "Grain-Icon-6")
        }else if srm<18 {
            return #imageLiteral(resourceName: "Grain-Icon-7")
        }else if srm<20 {
            return #imageLiteral(resourceName: "Grain-Icon-8")
        }else if srm<24 {
            return #imageLiteral(resourceName: "Grain-Icon-9")
        }else if srm<30 {
            return #imageLiteral(resourceName: "Grain-Icon-10")
        }else if srm<40 {
            return #imageLiteral(resourceName: "Grain-Icon-11")
        }
        return #imageLiteral(resourceName: "Grain-Icon-12")
    }
    
}
