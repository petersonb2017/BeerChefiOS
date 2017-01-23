//
//  Grains+CoreDataClass.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData

@objc(Grains)
public class Grains: NSManagedObject {
    public func getName() -> String
    {
        return name!
    }
    
    public func getPPG() -> Double
    {
        return ppg
    }
    
    public func getSRM() -> Double
    {
        return srm
    }
}
