//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)
var gr1 = Grain(name: "2 Row", ppg: 32, lovi: 2.0)
print(gr1)
var hp1 = Hop(name: "Cascade",AA: 7.5,pellet: true)
var yt1 = Yeast(name: "Wyeast 1026 American Ale Yeast", attenLow: 75,attenHigh:85,fermTempLow: 65,fermTempHigh: 72)
print(hp1.getName())
print(yt1.getFermTempLow())

let file = "file.txt" //this is the file. we will write to and read from it

let text = "some text" //just a text

if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    
    let path = dir.appendingPathComponent(file)
    
    //writing
    do {
        try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
    }
    catch {/* error handling here */}
    
    //reading
    do {
        let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
        print(text2)
    }
    catch {/* error handling here */}
}
