//
//  DusterAnimation.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class DusterAnimation : AnimationAnimal
{
   /****************************************
    * Init.                                *
    ****************************************/
    
    init(
        textureAtlasName: String,
        animationName: String,
        uniqueName: String,
        xPos: Int,
        yPos: Int,
        yetAnotherDusterIsEatingHandler: (String) -> ())
    {
        super.init(
            textureAtlasName: textureAtlasName,
            animationName: animationName,
            uniqueName: uniqueName,
            xPos: xPos,
            yPos: yPos,
            yetAnotherAnimalIsEatingHandler: yetAnotherDusterIsEatingHandler,
            direction: EDirection.unknown,
            firstFrameNo: 1,
            frameDelta: 1)
    }
}















