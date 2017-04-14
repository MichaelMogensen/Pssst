//
//  Point.swift
//  Pssst
//
//  Created by Michael Mogensen on 14/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

class Point
{
    var x: Int
    var y: Int
    
    init()
    {
        self.x = 0
        self.y = 0
    }
    init(_ x: Int, _ y: Int)
    {
        self.x = x
        self.y = y
    }
}

