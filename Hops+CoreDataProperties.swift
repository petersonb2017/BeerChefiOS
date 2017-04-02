//
//  Hops+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/8/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Hops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hops> {
        return NSFetchRequest<Hops>(entityName: "Hops");
    }

    @NSManaged public var aa: Double
    @NSManaged public var name: String?
    @NSManaged public var pellet: Bool

    
    convenience init(name: String, aa: Double, pellet: Bool, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Hops", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.aa = aa
        self.pellet = pellet
    }
}
