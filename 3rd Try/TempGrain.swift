//
//  File.swift
//  BeerChef
//
//  Created by Bailey Peterson on 4/6/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation


import UIKit
import CoreData



class TempGrain{
    public var grain: Grains
    public var weight: Double
    
    init(tempGrain: Grains, tempWeight: Double){
        grain = tempGrain
        weight = tempWeight
    }
    
}
