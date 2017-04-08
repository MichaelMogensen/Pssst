//
//  GameState.swift
//  Pssst
//
//  Created by Michael Mogensen on 17/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class GameState
{
   /****************************************
    * Basic properties.                    *
    ****************************************/
    
    var startScreenID: String! = nil
    
    var flowerID: String! = nil
    var flowerRect: CGRect! = nil
    
    var animalsEating = 0
    
    var leftEatingAnimalPositions: [CGPoint]! = nil
    var rightEatingAnimalPositions: [CGPoint]! = nil

}