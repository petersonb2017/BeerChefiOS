//
//  Yeasts+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/5/17.
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
    @NSManaged public var fermTempHigh: Int16
    @NSManaged public var fermTempLow: Int16
    @NSManaged public var name: String?
    @NSManaged public var partOfRecipe: NSSet?
    
    convenience init(name: String,attenLow: Int16,attenHigh: Int16,fermTempLow: Int16,fermTempHigh: Int16, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Yeasts", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.attenLow = attenLow
        self.attenHigh = attenHigh
        self.fermTempLow = fermTempLow
        self.fermTempHigh = fermTempHigh
    }

}

// MARK: Generated accessors for partOfRecipe
extension Yeasts {

    @objc(addPartOfRecipeObject:)
    @NSManaged public func addToPartOfRecipe(_ value: Recipes)

    @objc(removePartOfRecipeObject:)
    @NSManaged public func removeFromPartOfRecipe(_ value: Recipes)

    @objc(addPartOfRecipe:)
    @NSManaged public func addToPartOfRecipe(_ values: NSSet)

    @objc(removePartOfRecipe:)
    @NSManaged public func removeFromPartOfRecipe(_ values: NSSet)

}
