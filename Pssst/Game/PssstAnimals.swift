//
//  PssstAnimals.swift
//  Pssst
//
//  Created by Michael Mogensen on 12/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

enum EPssstAnimals : Int
{
    case
        Background = 0,
        Bee = 1,
        Box = 2,
        Duster = 3,
        Flower = 4,
        Leaf = 5,
        Owl = 6,
        SprayCan = 7,
        WaterCan = 8,
        Worm = 9
    
    var Name : String
    {
        switch self
        {
            case .Background: return "Background"
            case .Bee: return "Bee"
            case .Box: return "Box"
            case .Duster: return "Duster"
            case .Flower: return "Flower"
            case .Leaf: return "Leaf"
            case .Owl: return "Owl"
            case .SprayCan: return "SprayCan"
            case .WaterCan: return "WaterCan"
            case .Worm: return "Worm"
        }
    }
}

