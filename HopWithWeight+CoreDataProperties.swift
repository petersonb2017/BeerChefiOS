//
//  HopWithWeight+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/8/17.
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
    @NSManaged public var pellet: Bool
    @NSManaged public var partOfRecipe: Recipes?
    
    convenience init(name: String, aa: Double, time: Int16, weight: Double, pellet: Bool, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "HopWithWeight", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.aa = aa
        self.time = time
        self.weight = weight
        self.pellet = pellet
    }

}
