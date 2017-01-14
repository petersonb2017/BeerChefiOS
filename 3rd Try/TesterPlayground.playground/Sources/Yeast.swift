//
//  Yeast.swift
//  3rd Try
//
//  Created by Bailey Peterson on 1/2/17.
//  Copyright © 2017 Bailey Peterson. All rights reserved.
//

import Foundation
public class Yeast
{
    private var name: String
    private var attenLow: Int
    private var attenHigh: Int
    private var fermTempLow: Int
    private var fermTempHigh: Int
    
    public init(name yeastName: String, attenLow aLow: Int, attenHigh aHigh: Int, fermTempLow fTempLow: Int, fermTempHigh fTempHigh: Int)
    {
    name = yeastName
    attenLow = aLow
    attenHigh = aHigh
    fermTempLow = fTempLow
    fermTempHigh = fTempHigh
    }
    
    public func getName() -> String
    {
    return name;
    }
    
    public func getAttenLow() -> Int
    {
    return attenLow;
    }
    
    public func getAttenHigh() -> Int
    {
    return attenHigh;
    }
    public func getFermTempLow() -> Int
    {
    return fermTempLow;
    }
    public func getFermTempHigh() -> Int
    {
    return fermTempHigh;
    }
}
