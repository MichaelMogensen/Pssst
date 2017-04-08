//
//  Util.swift
//  Pssst
//
//  Created by Michael Mogensen on 07/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

class Util
{
    class func CreateGUID() -> String
    {
        let guid = UUID().uuidString
        return guid
    }
    class func Log(_ text: String)
    {
        NSLog(text)
    }
    class func Log(_ number: Int)
    {
        NSLog("\(number)")
    }
    class func LogError(_ text: String)
    {
        NSLog("Error: \(text)")
    }
}

