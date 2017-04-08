//
//  OwlAnimation.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class OwlAnimation : AnimationBase
{
   /****************************************
    * Init.                                *
    ****************************************/
    
    init(
        textureAtlasName: String,
        animationName: String,
        uniqueName: String,
        xPos: Int,
        yPos: Int)
    {
        super.init(
            textureAtlasName: textureAtlasName,
            animationName: animationName,
            uniqueName: uniqueName,
            xPos: xPos,
            yPos: yPos,
            direction: EDirection.unknown,
            firstFrameNo: 1,
            frameDelta: 1)
        // Set features special for this animation.
        self.animation.frameDuration = 0.50
        let scaleInBothDirections = CGFloat(0.7)
        self.animation.setScale(scaleInBothDirections)
        // Move anchor point to mid/mid (also default).
        self.animation.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Create unique data for this type of node.
        self.animation.data = GameSpriteNodeData()
    }
}















