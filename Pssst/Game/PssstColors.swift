//
//  PssstColors.swift
//  Pssst
//
//  Created by Michael Mogensen on 13/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

enum EPssstColors : Int
{
    case
        Blue = 0,
        Green = 1,
        Red = 2,
        Yellow = 3
    
    var Name : String
    {
        switch self
        {
            case .Blue: return "Blue"
            case .Green: return "Green"
            case .Red: return "Red"
            case .Yellow: return "Yellow"
        }
    }
    
    static let count: Int =
    {
        var max: Int = 0
        while let _ = EPssstColors(rawValue: max) { max += 1 }
        return max
    }()
}

