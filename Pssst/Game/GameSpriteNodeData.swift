//
//  SKSpriteNodeExtended.swift
//  Pssst
//
//  Created by Michael Mogensen on 17/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class GameSpriteNodeData
{
    let ID = Util.CreateGUID()
}

class GameSpriteNodeDataAnimal : GameSpriteNodeData
{
    var animalIsEating = false
}

class GameSpriteNodeDataNonAnimal : GameSpriteNodeData
{

}

