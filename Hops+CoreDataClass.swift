//
//  Hops+CoreDataClass.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData

@objc(Hops)
public class Hops: NSManagedObject {
    public func getName() -> String
    {
        return name!
    }
    
    public func getAA() -> Double
    {
        return aa
    }
    
    public func getPellet() -> Bool
    {
        return pellet
    }

}
