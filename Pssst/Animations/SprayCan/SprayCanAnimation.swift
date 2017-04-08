//
//  SprayCanAnimation.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class SprayCanAnimation : AnimationNonAnimal
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
    }
}















