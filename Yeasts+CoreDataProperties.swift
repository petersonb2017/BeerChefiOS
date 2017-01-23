//
//  Yeasts+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Yeasts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Yeasts> {
        return NSFetchRequest<Yeasts>(entityName: "Yeasts");
    }

    @NSManaged public var attenHigh: Int16
    @NSManaged public var attenLow: Int16
    @NSManaged public var fermTempLow: Int16
    @NSManaged public var fermTempHigh: Int16
    @NSManaged public var name: String?
    @NSManaged public var partOfRecipe: Recipes?

}
