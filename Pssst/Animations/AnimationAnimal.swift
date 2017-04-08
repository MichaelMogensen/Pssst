//
//  AnimationAnimal.swift
//  Pssst
//
//  Created by Michael Mogensen on 05/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationAnimal : AnimationBase
{
   /****************************************
    * Basic properties.                    *
    ****************************************/
    var yetAnotherAnimalIsEatingHandler: ((String) -> ())! = nil
    
   /****************************************
    * Init.                                *
    ****************************************/
    
    override init(animation: GameSpriteNode)
    {
        super.init(animation: animation)
    }
    init(
        textureAtlasName: String,
        animationName: String,
        uniqueName: String,
        xPos: Int,
        yPos: Int,
        yetAnotherAnimalIsEatingHandler: (String) -> (),
        direction: EDirection,
        firstFrameNo: Int,
        frameDelta: Int)
    {
        // FIX LATER
        let dummyHandler = { (arg: String) -> Void in }
        self.yetAnotherAnimalIsEatingHandler = dummyHandler // yetAnotherAnimalIsEatingHandler
        super.init(
            textureAtlasName: textureAtlasName,
            animationName: animationName,
            uniqueName: "Animal\(uniqueName)", // Add "Animal" to basic name to better count number of animals.
            xPos: xPos,
            yPos: yPos,
            direction: direction,
            firstFrameNo: firstFrameNo,
            frameDelta: frameDelta)
        // Move anchor point to mid/mid (also default).
        self.animation.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Create unique data for this type of node.
        self.animation.data = GameSpriteNodeDataAnimal()
    }
    // Make animal go to random spot on flower stem from current position.
    func GoToFlowerStem(_ cameFromLeftOrRight: ESide) -> SKAction
    {
        let actionGoToFlower = SKAction.run(
            {
                var actionsInOrderLastCrawl = [SKAction]()
                // Last crawl are made torwards the flower.
                var flowerPos = AnimationBase.gameDimensions.FlowerPosition
                flowerPos.x += (cameFromLeftOrRight == ESide.left) ? -self.animation.size.width / 2 : self.animation.size.width / 2
                // Find appropriate place on flower stem.
                let minY = Int(Pssst.gameState.flowerRect.origin.y)
                let maxY = Int(Pssst.gameState.flowerRect.origin.y) + Int(Pssst.gameState.flowerRect.size.height) - Int(CGFloat(AnimationBase.gameDimensions.flowerCrownHeightMax) / 1.6) // Division by 1.6: The picture is scaled in usage.
                
                let eatingAnimalPositions = (cameFromLeftOrRight == ESide.left) ?
                    Pssst.gameState.leftEatingAnimalPositions :
                    Pssst.gameState.rightEatingAnimalPositions
               
                if eatingAnimalPositions != nil
                {
                    // Make even Y-space to all other animals if possible.
                    let minYSeparation = Int(1.3 * self.animation.size.height)
                    var yCoordinates: [Int] = []
                    for eatingAnimalPosition in eatingAnimalPositions!
                    { yCoordinates.append(Int(eatingAnimalPosition.y)) }
                    flowerPos.y = CGFloat(RandomNumbers.RandomIntEvenSpaced(
                        minY,
                        max: maxY,
                        neighbourValues: yCoordinates,
                        minDistance: minYSeparation))
                }
                else
                {
                    // No other animals.
                    flowerPos.y = CGFloat(RandomNumbers.RandomInt(
                        minY,
                        maxY))
                }
                
                // Calc. last travel time.
                let δx = Int(flowerPos.x) - Int(self.animation.position.x)
                let δy = Int(flowerPos.y) - Int(self.animation.position.y)
                let endpointAndTravelTime = self.CalcEndpointAndTravelTime(δx, dy: δy)
                // Append last move and make him fast.
                actionsInOrderLastCrawl.append(SKAction.move(to: flowerPos, duration: endpointAndTravelTime.travelTime / 1.5))
                // After in place at the flower tag him at eating.
                actionsInOrderLastCrawl.append(SKAction.run(
                {
                    // Worm is now eating the flower. Tell parent to let him update game state.
                    self.yetAnotherAnimalIsEatingHandler(self.animation.data.ID)
                }))
                // Run finished build sequence.
                let actionsToRunLastCrawl = SKAction.sequence(actionsInOrderLastCrawl)
                self.animation.run(actionsToRunLastCrawl, withKey:"GoToFlowerStem")
            })
        return actionGoToFlower
    }
}











