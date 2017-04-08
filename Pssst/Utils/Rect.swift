//
//  Margin.swift
//  Pssst
//
//  Created by Michael Mogensen on 11/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class Rect
{
    var left: Int
    var top: Int
    var right: Int
    var bottom: Int
    
    var Width: Int { get { return (right - left) } }
    var Height: Int { get { return (top - bottom) } }
    
    init(left: Int, top: Int, right: Int, bottom: Int)
    {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }
    // Return random point within rect.
    func RandomPointWithin() -> CGPoint
    {
        let x = RandomNumbers.RandomInt(left, right)
        let y = RandomNumbers.RandomInt(bottom, top)
        return CGPoint(x: x, y: y)
    }
}

