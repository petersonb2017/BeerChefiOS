//
//  Recipe+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe");
    }

    @NSManaged public var grainsUsed: NSObject?
    @NSManaged public var hopsUsed: NSObject?
    @NSManaged public var yeastUsed: NSObject?
    @NSManaged public var name: String?

}
