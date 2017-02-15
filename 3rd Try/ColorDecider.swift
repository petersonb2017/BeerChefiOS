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
                red: CGFloat((0xFF0000) >> 16) / 255.0,
                green: CGFloat((0x00F800) >> 8) / 255.0,
                blue: CGFloat(0x000056) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<4 {
            return UIColor(
                red: CGFloat((0xFE0000) >> 16) / 255.0,
                green: CGFloat((0x00E400) >> 8) / 255.0,
                blue: CGFloat(0x000050) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<6 {
            return UIColor(
                red: CGFloat((0xFB0000) >> 16) / 255.0,
                green: CGFloat((0x00D500) >> 8) / 255.0,
                blue: CGFloat(0x000058) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<9 {
            return UIColor(
                red: CGFloat((0xF60000) >> 16) / 255.0,
                green: CGFloat((0x00AB00) >> 8) / 255.0,
                blue: CGFloat(0x000055) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<12 {
            return UIColor(
                red: CGFloat((0xEB0000) >> 16) / 255.0,
                green: CGFloat((0x00A200) >> 8) / 255.0,
                blue: CGFloat(0x000052) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<15 {
            return UIColor(
                red: CGFloat((0xCB0000) >> 16) / 255.0,
                green: CGFloat((0x008400) >> 8) / 255.0,
                blue: CGFloat(0x00005F) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<18 {
            return UIColor(
                red: CGFloat((0x8C0000) >> 16) / 255.0,
                green: CGFloat((0x005600) >> 8) / 255.0,
                blue: CGFloat(0x00003F) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<20 {
            return UIColor(
                red: CGFloat((0x780000) >> 16) / 255.0,
                green: CGFloat((0x004900) >> 8) / 255.0,
                blue: CGFloat(0x000043) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<24 {
            return UIColor(
                red: CGFloat((0x570000) >> 16) / 255.0,
                green: CGFloat((0x003700) >> 8) / 255.0,
                blue: CGFloat(0x000031) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<30 {
            return UIColor(
                red: CGFloat((0x4A0000) >> 16) / 255.0,
                green: CGFloat((0x003B00) >> 8) / 255.0,
                blue: CGFloat(0x00002C) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<40 {
            return UIColor(
                red: CGFloat((0x360000) >> 16) / 255.0,
                green: CGFloat((0x002F00) >> 8) / 255.0,
                blue: CGFloat(0x00002D) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return UIColor(
            red: CGFloat((0x310000) >> 16) / 255.0,
            green: CGFloat((0x003000) >> 8) / 255.0,
            blue: CGFloat(0x00002C) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    public func colorDecider(color: Double) -> UIColor{
        let srm = color
        
        if srm<3 {
            return UIColor(
                red: CGFloat((0xFF0000) >> 16) / 255.0,
                green: CGFloat((0x00F800) >> 8) / 255.0,
                blue: CGFloat(0x000056) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<4 {
            return UIColor(
                red: CGFloat((0xFE0000) >> 16) / 255.0,
                green: CGFloat((0x00E400) >> 8) / 255.0,
                blue: CGFloat(0x000050) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<6 {
            return UIColor(
                red: CGFloat((0xFB0000) >> 16) / 255.0,
                green: CGFloat((0x00D500) >> 8) / 255.0,
                blue: CGFloat(0x000058) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<9 {
            return UIColor(
                red: CGFloat((0xF60000) >> 16) / 255.0,
                green: CGFloat((0x00AB00) >> 8) / 255.0,
                blue: CGFloat(0x000055) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<12 {
            return UIColor(
                red: CGFloat((0xEB0000) >> 16) / 255.0,
                green: CGFloat((0x00A200) >> 8) / 255.0,
                blue: CGFloat(0x000052) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<15 {
            return UIColor(
                red: CGFloat((0xCB0000) >> 16) / 255.0,
                green: CGFloat((0x008400) >> 8) / 255.0,
                blue: CGFloat(0x00005F) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<18 {
            return UIColor(
                red: CGFloat((0x8C0000) >> 16) / 255.0,
                green: CGFloat((0x005600) >> 8) / 255.0,
                blue: CGFloat(0x00003F) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<20 {
            return UIColor(
                red: CGFloat((0x780000) >> 16) / 255.0,
                green: CGFloat((0x004900) >> 8) / 255.0,
                blue: CGFloat(0x000043) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<24 {
            return UIColor(
                red: CGFloat((0x570000) >> 16) / 255.0,
                green: CGFloat((0x003700) >> 8) / 255.0,
                blue: CGFloat(0x000031) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<30 {
            return UIColor(
                red: CGFloat((0x4A0000) >> 16) / 255.0,
                green: CGFloat((0x003B00) >> 8) / 255.0,
                blue: CGFloat(0x00002C) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<40 {
            return UIColor(
                red: CGFloat((0x360000) >> 16) / 255.0,
                green: CGFloat((0x002F00) >> 8) / 255.0,
                blue: CGFloat(0x00002D) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return UIColor(
            red: CGFloat((0x310000) >> 16) / 255.0,
            green: CGFloat((0x003000) >> 8) / 255.0,
            blue: CGFloat(0x00002C) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    public func colorDecider(recipe: Recipes) -> UIColor{
        let srm = recipe.calcSRM()

        if srm<3 {
            return UIColor(
                red: CGFloat((0xFF0000) >> 16) / 255.0,
                green: CGFloat((0x00F800) >> 8) / 255.0,
                blue: CGFloat(0x000056) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<4 {
            return UIColor(
                red: CGFloat((0xFE0000) >> 16) / 255.0,
                green: CGFloat((0x00E400) >> 8) / 255.0,
                blue: CGFloat(0x000050) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<6 {
            return UIColor(
                red: CGFloat((0xFB0000) >> 16) / 255.0,
                green: CGFloat((0x00D500) >> 8) / 255.0,
                blue: CGFloat(0x000058) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<9 {
            return UIColor(
                red: CGFloat((0xF60000) >> 16) / 255.0,
                green: CGFloat((0x00AB00) >> 8) / 255.0,
                blue: CGFloat(0x000055) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<12 {
            return UIColor(
                red: CGFloat((0xEB0000) >> 16) / 255.0,
                green: CGFloat((0x00A200) >> 8) / 255.0,
                blue: CGFloat(0x000052) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<15 {
            return UIColor(
                red: CGFloat((0xCB0000) >> 16) / 255.0,
                green: CGFloat((0x008400) >> 8) / 255.0,
                blue: CGFloat(0x00005F) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<18 {
            return UIColor(
                red: CGFloat((0x8C0000) >> 16) / 255.0,
                green: CGFloat((0x005600) >> 8) / 255.0,
                blue: CGFloat(0x00003F) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<20 {
            return UIColor(
                red: CGFloat((0x780000) >> 16) / 255.0,
                green: CGFloat((0x004900) >> 8) / 255.0,
                blue: CGFloat(0x000043) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<24 {
            return UIColor(
                red: CGFloat((0x570000) >> 16) / 255.0,
                green: CGFloat((0x003700) >> 8) / 255.0,
                blue: CGFloat(0x000031) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<30 {
            return UIColor(
                red: CGFloat((0x4A0000) >> 16) / 255.0,
                green: CGFloat((0x003B00) >> 8) / 255.0,
                blue: CGFloat(0x00002C) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if srm<40 {
            return UIColor(
                red: CGFloat((0x360000) >> 16) / 255.0,
                green: CGFloat((0x002F00) >> 8) / 255.0,
                blue: CGFloat(0x00002D) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return UIColor(
            red: CGFloat((0x310000) >> 16) / 255.0,
            green: CGFloat((0x003000) >> 8) / 255.0,
            blue: CGFloat(0x00002C) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
