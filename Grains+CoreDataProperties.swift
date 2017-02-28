//
//  Grains+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 2/5/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Grains {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grains> {
        return NSFetchRequest<Grains>(entityName: "Grains");
    }

    @NSManaged public var name: String?
    @NSManaged public var ppg: Double
    @NSManaged public var srm: Double
    
    convenience init(name: String, ppg: Double, srm: Double, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Grains", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.ppg = ppg
        self.srm = srm
    }

}
