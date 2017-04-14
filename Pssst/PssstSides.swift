//
//  Sides.swift
//  Pssst
//
//  Created by Michael Mogensen on 14/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

enum EPssstSides : Int
{
    case
        Left = 0,
        Right = 1
    
    var Name : String
    {
        switch self
        {
            case .Left: return "Left"
            case .Right: return "Right"
        }
    }
    
    static let count: Int =
    {
        var max: Int = 0
        while let _ = EPssstSides(rawValue: max) { max += 1 }
        return max
    }()
}

