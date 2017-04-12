//
//  LaneLim.swift
//  Pssst
//
//  Created by Michael Mogensen on 07/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

class LaneLim
{
    var lane: Int
    var animal: Int //EAnimal
    var min: Int
    var max: Int
    
    init(
        lane: Int,
        animal: Int, //EAnimal,
        min: Int,
        max: Int)
    {
        self.lane = lane
        self.animal = animal
        self.min = min
        self.max = max
    }
}

