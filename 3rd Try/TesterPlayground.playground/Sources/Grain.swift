//
//  Grain.swift
//  3rd Try
//
//  Created by Bailey Peterson on 1/2/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation

public class Grain
{
    private var name: String
    private var ppg: Double
    private var lovi: Double

    public init(name grainName: String, ppg gravity: Double, lovi color: Double)
    {
    name = grainName
    ppg = gravity
    lovi = color
    }
    
    public func getName() -> String
    {
    return name
    }
    
    public func getPPG() -> Double
    {
    return ppg
    }
    
    public func getLovi() -> Double
    {
    return lovi
    }
}
