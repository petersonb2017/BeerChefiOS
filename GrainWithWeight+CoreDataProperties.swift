//
//  GrainWithWeight+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/5/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension GrainWithWeight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GrainWithWeight> {
        return NSFetchRequest<GrainWithWeight>(entityName: "GrainWithWeight");
    }

    @NSManaged public var name: String?
    @NSManaged public var ppg: Double
    @NSManaged public var srm: Double
    @NSManaged public var weight: Double
    @NSManaged public var partOfRecipe: Recipes?

}
