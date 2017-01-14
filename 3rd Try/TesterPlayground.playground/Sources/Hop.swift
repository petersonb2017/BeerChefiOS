//
//  Hop.swift
//  3rd Try
//
//  Created by Bailey Peterson on 1/2/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
public class Hop
{
    private var name: String
    private var AA: Double
    private var pellet: Bool
    
    public init(name hopName: String, AA alpha: Double, pellet form: Bool)
    {
    name = hopName
    AA = alpha
    pellet = form
    }
    
    public func getName() -> String
    {
    return name;
    }
    
    public func getAA() -> Double
    {
    return AA;
    }
    
    public func getPellet() -> Bool
    {
    return pellet;
    }
}
