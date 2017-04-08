//
//  AnimationNonAnimal.swift
//  Pssst
//
//  Created by Michael Mogensen on 05/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationNonAnimal : AnimationBase
{
   /****************************************
    * Basic properties.                    *
    ****************************************/

   /****************************************
    * Init.                                *
    ****************************************/
    
    override init(animation: GameSpriteNode)
    {
        super.init(animation: animation)
    }
    override init(
        textureAtlasName: String,
        animationName: String,
        uniqueName: String,
        xPos: Int,
        yPos: Int,
        direction: EDirection,
        firstFrameNo: Int,
        frameDelta: Int)
    {
        super.init(
            textureAtlasName: textureAtlasName,
            animationName: animationName,
            uniqueName: "Thing\(uniqueName)", // Add "Thing" to basic name to better count number of things.
            xPos: xPos,
            yPos: yPos,
            direction: direction,
            firstFrameNo: firstFrameNo,
            frameDelta: frameDelta)
        // Move anchor point to mid bottom.
        self.animation.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        // Create unique data for this type of node.
        self.animation.data = GameSpriteNodeDataNonAnimal()
    }
}











