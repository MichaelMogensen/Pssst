//
//  Tool.swift
//  Pssst
//
//  Created by Michael Mogensen on 01/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

class Tool
{
    var shelfId = 0
    var type = ETool.nothing
    var value = 0
    
    init(shelfId: Int = 0, type: ETool = ETool.nothing, value: Int = 0)
    {
        self.shelfId = shelfId
        self.type = type
        self.value = value
    }
}

