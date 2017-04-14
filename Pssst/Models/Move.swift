//
//  Move.swift
//  Pssst
//
//  Created by Michael Mogensen on 13/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class Move
{
    var x = 0
    var y = 0
    var duration = 0.0
    
    var Point: CGPoint { get { return CGPoint(x: x, y: y) } }
    
    init(_ x: Int, _ y: Int, _ duration: Double)
    {
        self.x = x
        self.y = y
        self.duration = duration
    }
}

