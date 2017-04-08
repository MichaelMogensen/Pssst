//
//  WormAnimation.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class WormAnimation : AnimationAnimal
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
        yetAnotherWormIsEatingHandler: (String) -> ())
    {
        super.init(
            textureAtlasName: textureAtlasName,
            animationName: animationName,
            uniqueName: uniqueName,
            xPos: xPos,
            yPos: yPos,
            yetAnotherAnimalIsEatingHandler: yetAnotherWormIsEatingHandler,
            direction: EDirection.leftToRight,
            firstFrameNo: 1,
            frameDelta: 1)
        // Set features special for this animation.
        self.animation.frameDuration = 0.03
        self.animation.isHidden = true
    }
    // Move worm on background in (x, y) to first (xPos, yPos) and from top towards bottom.
    func MoveInZigZagDownwards(
        _ xPos: Int,
        yPos: Int,
        speed: EAnimationSpeed)
    {
        let xPos = xPos, yPos = yPos, speed = speed
        // Kill running actions.
        let keyName = "\(String(describing: self.animation.name))MoveInZigZagDownwards"
        EndSpecificAnimation(keyName)
        
        self.animation.velocity = speed
        
        // Prepare array of actions to walk the line.
        var actionsInOrder = [SKAction]()
        
        // Decrease per crawl.
        let δx = xPos - Int(self.animation.position.x)
        let δy = yPos - Int(self.animation.position.y)
        
        // Max. number of even zigzag's to take.
        var ℳ = Int(yPos / abs(δy))
        ℳ = ℳ % 2 == 1 ? ℳ - 1 : ℳ
        ℳ /= 2
        
        // Begin building its movement.
        let cameFromLeftOrRight = (Int(self.animation.position.x) < AnimationBase.gameDimensions.Width / 2) ? ESide.left : ESide.right
        if (cameFromLeftOrRight == ESide.right)
        { actionsInOrder.append(SKAction.run({ self.animation.HorizontalTurnaround() })) }
        
        actionsInOrder.append(SKAction.fadeOut(withDuration: 0.0))
        actionsInOrder.append(SKAction.run({ self.MoveInPlaceForever() }))
        actionsInOrder.append(SKAction.unhide())
        actionsInOrder.append(SKAction.fadeIn(withDuration: 1.5))
        
        // Crawl out and home again.
        let endpointAndTravelTime = CalcEndpointAndTravelTime(δx, dy: δy)
        let endPoint = endpointAndTravelTime.endPoint
        for _ in 1...ℳ
        {
            // Crawl out and home again no matter the starting origo.
            let actionCrawlOut = SKAction.move(to: endPoint, duration: endpointAndTravelTime.travelTime)
            // FIX LATER: endPoint = endPoint.OffsetBy(-δx, δy)
            let actionCrawlHome = SKAction.move(to: endPoint, duration: endpointAndTravelTime.travelTime)
            // FIX LATER: endPoint = endPoint.OffsetBy(δx, δy)

            actionsInOrder.append(actionCrawlOut)
            actionsInOrder.append(SKAction.wait(forDuration: 0.5, withRange: 0.25) )
            actionsInOrder.append(SKAction.run({ self.animation.HorizontalTurnaround() }))
            actionsInOrder.append(actionCrawlHome)
            actionsInOrder.append(SKAction.run({ self.animation.HorizontalTurnaround() }))
        }
        
        // Last crawl are made torwards the flower but final destination are measured in a while from now because of slow growth of flower.
        actionsInOrder.append(GoToFlowerStem(cameFromLeftOrRight))
        
        // Run finished build sequence.
        let actionsToRun = SKAction.sequence(actionsInOrder)
        self.animation.run(actionsToRun, withKey:keyName)
    }
}

