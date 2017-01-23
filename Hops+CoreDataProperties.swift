//
//  Hops+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Hops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hops> {
        return NSFetchRequest<Hops>(entityName: "Hops");
    }

    @NSManaged public var name: String?
    @NSManaged public var pellet: Bool
    @NSManaged public var aa: Double
    @NSManaged public var partOfRecipe: Recipes?


}