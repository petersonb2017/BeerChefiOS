//
//  Grain+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 1/16/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Grain {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grain> {
        return NSFetchRequest<Grain>(entityName: "Grain");
    }

    @NSManaged public var name: String?
    @NSManaged public var ppg: Double
    @NSManaged public var srm: Double

}
