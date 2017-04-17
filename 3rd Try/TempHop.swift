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



class TempHop{
    public var hop: Hops
    public var time: Int
    public var weight: Double
    
    init(tempHop: Hops, tempTime: Int, tempWeight: Double){
        hop = tempHop
        time = tempTime
        weight = tempWeight
    }
    
}
