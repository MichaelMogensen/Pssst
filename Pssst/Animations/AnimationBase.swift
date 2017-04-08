//
//  AnimationBase.swift
//  Pssst
//
//  Created by Michael Mogensen on 04/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit
import Darwin

class AnimationBase
{
    
   /****************************************
    * Basic static properties              *
    ****************************************/
    
    static let π = CGFloat(Double.pi)
    static var gameDimensions: GameDimensions! = nil
    
    /****************************************
    * Basic properties.                    *
    ****************************************/
    var animation: GameSpriteNode! = nil
    
   /****************************************
    * Calc. properties.                    *
    ****************************************/
    var x: Int
    { get { return Int(self.animation.position.x) } }
    var y: Int
    { get { return Int(self.animation.position.y) } }

   /****************************************
    * Init.                                *
    ****************************************/
    
    init(animation: GameSpriteNode)
    {
        self.animation = animation
    }
    init(
        textureAtlasName: String,
        animationName: String,
        uniqueName: String,
        xPos: Int,
        yPos: Int,
        direction: EDirection,
        firstFrameNo: Int,
        frameDelta: Int)
    {
        SetupAnimation(
            textureAtlasName,
            animationName: animationName,
            uniqueName: uniqueName,
            xPos: xPos,
            yPos: yPos,
            direction: direction,
            firstFrameNo: firstFrameNo,
            frameDelta: frameDelta)
    }
    // Calc. endpoint and time it takes to reach it from current location. Animation speed must be set prior to call.
    func CalcEndpointAndTravelTime(_ dx: Int, dy: Int) -> (travelTime: Double, endPoint: CGPoint)
    {
        let dist = Double(MathHelper.PhytagoraDist(Float(dx), dy: Float(dy)))
        let duration: Double = self.animation.framesDuration * dist / self.animation.velocity.rawValue
        let endPoint = CGPoint(
            x: CGFloat(self.x + dx),
            y: CGFloat(self.y + dy))
        
        return (travelTime: duration, endPoint: endPoint)
    }
    // Load all atlas images and build up the frames.
    fileprivate func SetupAnimation(
        _ textureAtlasName: String,
        animationName: String,
        uniqueName: String,
        xPos: Int,
        yPos: Int,
        direction: EDirection,
        firstFrameNo: Int,
        frameDelta: Int)
    {
        let animationAnimatedAtlas = SKTextureAtlas(named: textureAtlasName) // Like "Worms"
        if (animationAnimatedAtlas.textureNames.count == 0)
        // Empty atlas.
        { return }
        // Append frames to sprite.
        var frameNo = firstFrameNo
        for id in 1...animationAnimatedAtlas.textureNames.count
        {
            let animationTextureName = "\(animationName)\(frameNo)"  // Like "Worm + 7".
            frameNo += frameDelta
            let frame = animationAnimatedAtlas.textureNamed(animationTextureName)
            if (id == 1)
            {
                self.animation = GameSpriteNode(texture: frame)
                self.animation.frames = []
            }
            self.animation.frames.append(frame)
        }
        // Place it.
        self.animation.position = CGPoint(x: xPos, y: yPos)
        self.animation.name = uniqueName // Like "Worm7".
        self.animation.xScale = 1
        self.animation.yScale = 1
        if (direction == EDirection.rightToLeft)
        {
            self.animation.HorizontalTurnaround()
        }
    }
    // Remove all animations.
    func EndAllAnimations()
    {
        self.animation.removeAllActions();
    }
    // Remove 1 animation.
    func EndSpecificAnimation(_ keyName: String)
    {
        let keyName = keyName
        if (self.animation.action(forKey: keyName) == nil)
        { return }
        self.animation.removeAction(forKey: keyName)
    }
    // Move animation in place forever cycle.
    func MoveInPlaceForever()
    {
        // Kill running actions.
        let keyName = "\(String(describing: self.animation.name))MoveInPlaceForever"
        EndSpecificAnimation(keyName)
        
        let actionMove = SKAction.animate(
            with: self.animation.frames,
            timePerFrame: self.animation.frameDuration,
            resize: true,
            restore: true)
        let actionMoveForever = SKAction.repeatForever(actionMove)
        self.animation.run(actionMoveForever, withKey:keyName)
    }
    // Move animation in place N cycle(s).
    func MoveInPlaceNCycles(_ cycles: Int = 1, restoreToFirstFrame: Bool = false, endAnimationHandler: (() -> ())! = nil)
    {
        // Kill running actions.
        let keyName = "\(String(describing: self.animation.name))MoveInPlaceNCycles"
        EndSpecificAnimation(keyName)
        
        let actionMove = SKAction.animate(
            with: self.animation.frames,
            timePerFrame: self.animation.frameDuration,
            resize: true,
            restore: restoreToFirstFrame)
        
        var actionsToPerform = [SKAction]()
        // Sometimes the caller want to know when cycle(s) finished.
        actionsToPerform.append(SKAction.repeat(actionMove, count: cycles))
        if (endAnimationHandler != nil)
        {
            actionsToPerform.append(SKAction.run(
            {
                endAnimationHandler()
            }))
        }
        self.animation.run(SKAction.sequence(actionsToPerform), withKey:keyName)
    }
}





