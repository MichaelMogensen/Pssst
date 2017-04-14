//
//  Shelf.swift
//  Pssst
//
//  Created by Michael Mogensen on 09/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

class Shelf
{
    private var ToolPos = (0, 0)
    var IsOccupied = false
    
    init(_ xToolPos: Int, _ yToolPos: Int, _ isOccupied: Bool)
    {
        self.ToolPos = (xToolPos, yToolPos)
        self.IsOccupied = isOccupied
    }
}
