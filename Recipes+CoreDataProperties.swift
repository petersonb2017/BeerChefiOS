//
//  Recipes+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes");
    }

    @NSManaged public var grainsUsed: NSObject?
    @NSManaged public var hopsUsed: NSObject?
    @NSManaged public var yeastUsed: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var containsGrain: Grains?
    @NSManaged public var containsHop: Hops?
    @NSManaged public var containsYeast: Yeasts?

}
