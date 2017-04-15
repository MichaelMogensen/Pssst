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
        Cyan = 1,
        Green = 2,
        Magenta = 3,
        Red = 4,
        Yellow = 5
    
    var Name : String
    {
        switch self
        {
            case .Blue: return "Blue"
            case .Cyan: return "Cyan"
            case .Green: return "Green"
            case .Magenta: return "Magenta"
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

