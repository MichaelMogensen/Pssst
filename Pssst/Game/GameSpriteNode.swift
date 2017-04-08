//
//  GameSpriteNode.swift
//  Pssst
//
//  Created by Michael Mogensen on 17/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class GameSpriteNode : SKSpriteNode
{
    var data: GameSpriteNodeData! = nil
    var frames: [SKTexture]! = nil

    var frameDuration: Double = 0.0
    var framesDuration: Double
    {
        get
        { return (Double(self.frames.count) * self.frameDuration) }
    }
    var velocity: EAnimationSpeed = EAnimationSpeed.normal
    
    // Turn around y-axis.
    func HorizontalTurnaround()
    { self.xScale *= -1 }
    // Turn around x-axis.
    func VerticalTurnaround()
    { self.yScale *= -1 }
    
    // Reverse frames.
    func Reverse()
    {
        frames = frames.reversed()
    }
}

