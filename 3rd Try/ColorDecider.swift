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
    
    public func colorDecider(grain: Grains) -> UIColor{
        let srm = grain.srm
        
        if srm<3 {
            return UIColor(
                red: CGFloat((0xf40000) >> 16) / 255.0,
                green: CGFloat((0x00D300) >> 8) / 255.0,
                blue: CGFloat(0x000080) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<4 {
            return UIColor(
                red: CGFloat((0xE50000) >> 16) / 255.0,
                green: CGFloat((0x00A200) >> 8) / 255.0,
                blue: CGFloat(0x000031) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<6 {
            return UIColor(
                red: CGFloat((0xDD0000) >> 16) / 255.0,
                green: CGFloat((0x008D00) >> 8) / 255.0,
                blue: CGFloat(0x00001D) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<9 {
            return UIColor(
                red: CGFloat((0xC80000) >> 16) / 255.0,
                green: CGFloat((0x006500) >> 8) / 255.0,
                blue: CGFloat(0x000005) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<12 {
            return UIColor(
                red: CGFloat((0xAF0000) >> 16) / 255.0,
                green: CGFloat((0x004300) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<15 {
            return UIColor(
                red: CGFloat((0x8F0000) >> 16) / 255.0,
                green: CGFloat((0x002800) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<18 {
            return UIColor(
                red: CGFloat((0x7B0000) >> 16) / 255.0,
                green: CGFloat((0x001B00) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<20 {
            return UIColor(
                red: CGFloat((0x6E0000) >> 16) / 255.0,
                green: CGFloat((0x001500) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<24 {
            return UIColor(
                red: CGFloat((0x5E0000) >> 16) / 255.0,
                green: CGFloat((0x000E00) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<30 {
            return UIColor(
                red: CGFloat((0x4C0000) >> 16) / 255.0,
                green: CGFloat((0x000800) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<40 {
            return UIColor(
                red: CGFloat((0x320000) >> 16) / 255.0,
                green: CGFloat((0x000300) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return UIColor(
            red: CGFloat((0x160000) >> 16) / 255.0,
            green: CGFloat((0x000000) >> 8) / 255.0,
            blue: CGFloat(0x000000) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    public func colorDecider(color: Double) -> UIColor{
        let srm = color
        
        if srm<3 {
            return UIColor(
                red: CGFloat((0xf40000) >> 16) / 255.0,
                green: CGFloat((0x00D300) >> 8) / 255.0,
                blue: CGFloat(0x000080) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<4 {
            return UIColor(
                red: CGFloat((0xE50000) >> 16) / 255.0,
                green: CGFloat((0x00A200) >> 8) / 255.0,
                blue: CGFloat(0x000031) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<6 {
            return UIColor(
                red: CGFloat((0xDD0000) >> 16) / 255.0,
                green: CGFloat((0x008D00) >> 8) / 255.0,
                blue: CGFloat(0x00001D) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<9 {
            return UIColor(
                red: CGFloat((0xC80000) >> 16) / 255.0,
                green: CGFloat((0x006500) >> 8) / 255.0,
                blue: CGFloat(0x000005) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<12 {
            return UIColor(
                red: CGFloat((0xAF0000) >> 16) / 255.0,
                green: CGFloat((0x004300) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<15 {
            return UIColor(
                red: CGFloat((0x8F0000) >> 16) / 255.0,
                green: CGFloat((0x002800) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<18 {
            return UIColor(
                red: CGFloat((0x7B0000) >> 16) / 255.0,
                green: CGFloat((0x001B00) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<20 {
            return UIColor(
                red: CGFloat((0x6E0000) >> 16) / 255.0,
                green: CGFloat((0x001500) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<24 {
            return UIColor(
                red: CGFloat((0x5E0000) >> 16) / 255.0,
                green: CGFloat((0x000E00) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<30 {
            return UIColor(
                red: CGFloat((0x4C0000) >> 16) / 255.0,
                green: CGFloat((0x000800) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<40 {
            return UIColor(
                red: CGFloat((0x320000) >> 16) / 255.0,
                green: CGFloat((0x000300) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return UIColor(
            red: CGFloat((0x160000) >> 16) / 255.0,
            green: CGFloat((0x000000) >> 8) / 255.0,
            blue: CGFloat(0x000000) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    public func colorDecider(recipe: Recipes) -> UIColor{
        let srm = recipe.calcSRM()

        if srm<3 {
            return UIColor(
                red: CGFloat((0xf40000) >> 16) / 255.0,
                green: CGFloat((0x00D300) >> 8) / 255.0,
                blue: CGFloat(0x000080) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<4 {
            return UIColor(
                red: CGFloat((0xE50000) >> 16) / 255.0,
                green: CGFloat((0x00A200) >> 8) / 255.0,
                blue: CGFloat(0x000031) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<6 {
            return UIColor(
                red: CGFloat((0xDD0000) >> 16) / 255.0,
                green: CGFloat((0x008D00) >> 8) / 255.0,
                blue: CGFloat(0x00001D) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<9 {
            return UIColor(
                red: CGFloat((0xC80000) >> 16) / 255.0,
                green: CGFloat((0x006500) >> 8) / 255.0,
                blue: CGFloat(0x000005) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<12 {
            return UIColor(
                red: CGFloat((0xAF0000) >> 16) / 255.0,
                green: CGFloat((0x004300) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<15 {
            return UIColor(
                red: CGFloat((0x8F0000) >> 16) / 255.0,
                green: CGFloat((0x002800) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<18 {
            return UIColor(
                red: CGFloat((0x7B0000) >> 16) / 255.0,
                green: CGFloat((0x001B00) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<20 {
            return UIColor(
                red: CGFloat((0x6E0000) >> 16) / 255.0,
                green: CGFloat((0x001500) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<24 {
            return UIColor(
                red: CGFloat((0x5E0000) >> 16) / 255.0,
                green: CGFloat((0x000E00) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<30 {
            return UIColor(
                red: CGFloat((0x4C0000) >> 16) / 255.0,
                green: CGFloat((0x000800) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<40 {
            return UIColor(
                red: CGFloat((0x320000) >> 16) / 255.0,
                green: CGFloat((0x000300) >> 8) / 255.0,
                blue: CGFloat(0x000000) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return UIColor(
            red: CGFloat((0x160000) >> 16) / 255.0,
            green: CGFloat((0x000000) >> 8) / 255.0,
            blue: CGFloat(0x000000) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
