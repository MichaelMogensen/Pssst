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
    private var Id = 0
    private var ToolPos = (0, 0)
    private var IsOccupied = false
    
    init(_ id: Int, _ xToolPos: Int, _ yToolPos: Int, _ isOccupied: Bool)
    {
        self.Id = id
        self.ToolPos = (xToolPos, yToolPos)
        self.IsOccupied = isOccupied
    }
}
