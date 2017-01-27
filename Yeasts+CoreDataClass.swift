//
//  Yeasts+CoreDataClass.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData

@objc(Yeasts)
public class Yeasts: NSManagedObject {
    public func getName() -> String
    {
        return name!
    }
    
    public func getAttenLow() -> Int
    {
        return Int(attenLow)
    }
    
    public func getAttenHigh() -> Int
    {
        return Int(attenHigh)
    }
    public func getFermTempLow() -> Int
    {
        return Int(fermTempLow)
    }
    public func getFermTempHigh() -> Int
    {
        return Int(fermTempHigh)
    }

}
