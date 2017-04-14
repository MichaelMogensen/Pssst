//
//  LaneLim.swift
//  Pssst
//
//  Created by Michael Mogensen on 07/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

class LevelLim
{
    var level: Int
    var animal: EPssstAnimals
    var min: Int
    var max: Int
    
    init(
        level: Int,
        animal: EPssstAnimals,
        min: Int,
        max: Int)
    {
        self.level = level
        self.animal = animal
        self.min = min
        self.max = max
    }
}

