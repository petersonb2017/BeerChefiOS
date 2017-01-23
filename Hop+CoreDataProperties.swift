//
//  Hop+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Hop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hop> {
        return NSFetchRequest<Hop>(entityName: "Hop");
    }

    @NSManaged public var name: String?
    @NSManaged public var pellet: Bool
    @NSManaged public var aa: Double

}
