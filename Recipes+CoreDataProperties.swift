//
//  Recipes+CoreDataProperties.swift
//  Beer-App-Swift
//
//  Created by Bailey Peterson on 3/8/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
import CoreData


extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes");
    }

    @NSManaged public var batchSize: Double
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var efficiency: Double
    @NSManaged public var containsGrain: NSSet?
    @NSManaged public var containsHop: NSSet?
    @NSManaged public var containsYeast: NSSet?
    
    convenience init(batchSize: Double, info: String, name: String, efficiency: Double, grains: NSSet, hops: NSSet, yeast: NSSet, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Recipes", in: context)!
        self.init(entity: entity, insertInto: context)
        self.batchSize = batchSize
        self.info = info
        self.name = name
        self.efficiency = efficiency
        self.containsGrain = grains
        self.containsHop = hops
        self.containsYeast = yeast
    }

}

// MARK: Generated accessors for containsGrain
extension Recipes {

    @objc(addContainsGrainObject:)
    @NSManaged public func addToContainsGrain(_ value: GrainWithWeight)

    @objc(removeContainsGrainObject:)
    @NSManaged public func removeFromContainsGrain(_ value: GrainWithWeight)

    @objc(addContainsGrain:)
    @NSManaged public func addToContainsGrain(_ values: NSSet)

    @objc(removeContainsGrain:)
    @NSManaged public func removeFromContainsGrain(_ values: NSSet)

}

// MARK: Generated accessors for containsHop
extension Recipes {

    @objc(addContainsHopObject:)
    @NSManaged public func addToContainsHop(_ value: HopWithWeight)

    @objc(removeContainsHopObject:)
    @NSManaged public func removeFromContainsHop(_ value: HopWithWeight)

    @objc(addContainsHop:)
    @NSManaged public func addToContainsHop(_ values: NSSet)

    @objc(removeContainsHop:)
    @NSManaged public func removeFromContainsHop(_ values: NSSet)

}

// MARK: Generated accessors for containsYeast
extension Recipes {

    @objc(addContainsYeastObject:)
    @NSManaged public func addToContainsYeast(_ value: Yeasts)

    @objc(removeContainsYeastObject:)
    @NSManaged public func removeFromContainsYeast(_ value: Yeasts)

    @objc(addContainsYeast:)
    @NSManaged public func addToContainsYeast(_ values: NSSet)

    @objc(removeContainsYeast:)
    @NSManaged public func removeFromContainsYeast(_ values: NSSet)

}
