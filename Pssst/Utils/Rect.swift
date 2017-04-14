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
    
    init(_ left: Int, _ top: Int, _ right: Int, _ bottom: Int)
    {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }
}

