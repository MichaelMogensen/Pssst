//
//  LeafAnimation.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class LeafAnimation : AnimationNonAnimal
{
   /****************************************
    * Init.                                *
    ****************************************/
    
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
            uniqueName: uniqueName,
            xPos: xPos,
            yPos: yPos,
            direction: direction,
            firstFrameNo: firstFrameNo,
            frameDelta: frameDelta)
        // Set features special for this animation.
        self.animation.frameDuration = 0.50
        let scaleInBothDirections = CGFloat(0.6)
        self.animation.setScale(scaleInBothDirections)
    }
    // Make it grow.
    func Grow()
    {
        // Kill running actions.
        let keyName = "\(String(describing: self.animation.name))GrowLeaf"
        EndSpecificAnimation(keyName)
        
        let actionToRun = SKAction.run({ self.MoveInPlaceNCycles(1) })
        self.animation.run(actionToRun, withKey:keyName)
    }
}















