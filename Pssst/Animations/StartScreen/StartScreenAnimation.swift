//
//  StartScreenAnimation.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class StartScreenAnimation : AnimationBase
{
   /****************************************
    * Init.                                *
    ****************************************/
    
    init(
        xPos: Int,
        yPos: Int)
    {
        super.init(
            textureAtlasName: "StartScreen.atlas",
            animationName: "StartScreen",
            uniqueName: "StartScreen",
            xPos: xPos,
            yPos: yPos,
            direction: EDirection.unknown,
            firstFrameNo: 1,
            frameDelta: 1)
        // Set features special for this animation.
        self.animation.frameDuration = 0.20
        // Move anchor point to mid/mid (also default).
        self.animation.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.animation.size = CGSize(
            width: AnimationBase.gameDimensions.Width,
            height: AnimationBase.gameDimensions.Height)
        // Create unique data for this type of node.
        self.animation.data = GameSpriteNodeData()
    }
}

