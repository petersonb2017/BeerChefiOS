//
//  HopWithWeight+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/5/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension HopWithWeight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HopWithWeight> {
        return NSFetchRequest<HopWithWeight>(entityName: "HopWithWeight");
    }

    @NSManaged public var aa: Double
    @NSManaged public var name: String?
    @NSManaged public var time: Int16
    @NSManaged public var weight: Double
    @NSManaged public var partOfRecipe: Recipes?

}
