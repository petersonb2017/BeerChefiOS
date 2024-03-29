//
//  GrainWithWeight+CoreDataProperties.swift
//  BeerChef
//
//  Created by Bailey Peterson on 4/3/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension GrainWithWeight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GrainWithWeight> {
        return NSFetchRequest<GrainWithWeight>(entityName: "GrainWithWeight")
    }

    @NSManaged public var isExtract: Bool
    @NSManaged public var name: String?
    @NSManaged public var ppg: Double
    @NSManaged public var srm: Double
    @NSManaged public var weight: Double
    @NSManaged public var partOfRecipe: Recipes?
    
    convenience init(name: String, ppg: Double, srm: Double, isExtract: Bool, weight: Double, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "GrainWithWeight", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.ppg = ppg
        self.srm = srm
        self.isExtract = isExtract
        self.weight = weight
    }

}
