//
//  Pssst.swift
//  Pssst
//
//  Created by Michael Mogensen on 09/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

// Logical screen.
//
//
// Left                                           Right
// Shelfs                                         shelfs
//
// +-+                                               +-+
// | |                                               | |
// | |  4                                          9 | |
// | +----                                        ---+ | y4
// | |                                               | |
// | |  3                                          8 | |
// | +----                                        ---+ | y3
// | |                                               | |
// | |  2                                          7 | |
// | +----                                        ---+ | y2
// | |                                               | |
// | |  1                                          6 | |
// | +----                                        ---+ | y1
// | |                                               | |
// | |  0                                          5 | |
// | +-----------------------------------------------+ | y0
// +---------------------------------------------------+
//
//     x0                                          x1
//
class PssstScene : SKScene
{
    /****************************************
     * Basic static properties              *
     ****************************************/
        
/*
    static private let laneLim =
    [
        LaneLim(lane: 1, animal: EAnimal.worm,   min: 3, max: 10),
        LaneLim(lane: 1, animal: EAnimal.duster, min: 0, max: 0),
        LaneLim(lane: 1, animal: EAnimal.bee,    min: 0, max: 0),
        
        LaneLim(lane: 2, animal: EAnimal.worm,   min: 3, max: 20),
        LaneLim(lane: 2, animal: EAnimal.duster, min: 3, max: 6),
        LaneLim(lane: 2, animal: EAnimal.bee,    min: 0, max: 0),
        
        LaneLim(lane: 3, animal: EAnimal.worm,   min: 3, max: 30),
        LaneLim(lane: 3, animal: EAnimal.duster, min: 3, max: 6),
        LaneLim(lane: 3, animal: EAnimal.bee,    min: 3, max: 6)
    ]
*/
    /****************************************
     * Basic properties.                    *
     ****************************************/
    
    private var Screen: PssstScreen?
    
    /****************************************
     * Init.                                *
     ****************************************/
    
    override init(size: CGSize)
    {
        super.init(size: size)
        
        // Set to current screen.
        self.Screen = PssstScreen(Int(size.width), Int(size.height))
        
        BeginGame()
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    /****************************************
     * Internal methods.                    *
     ****************************************/
        
    // Begin game.
    func BeginGame()
    {
        // Build game scene.
        removeAllChildren()
        AddSprite(
            EPssstAnimals.Background.Name,
            Screen!.Width / 2,
            Screen!.Height / 2,
            Screen!.Width,
            Screen!.Height)
    }
    
    // Continue game.
    func ProceedGame()
    {
    }
    
    // End game.
    func EndGame()
    {
    }
    
    /****************************************
     * Exposed methods.                     *
     ****************************************/
    
    /****************************************
     * Event handlers.                      *
     ****************************************/
    
    override func didMove(to view: SKView)
    {
    }
    // Called before each frame is rendered.
    override func update(_ currentTime: TimeInterval)
    {
        Util.Log("Time = (\(currentTime))")
    }

    /****************************************
     * Helper methods.                      *
     ****************************************/

    // Add new sprite. Name has to be unique.
    func AddSprite(
        _ name: String,
        _ x: Int,
        _ y: Int,
        _ width: Int,
        _ height: Int)
    {
        let sprite = PssstSprite(imageNamed: name)
        sprite.name = name
        sprite.size = CGSize(
            width: width,
            height: height)
        sprite.position = CGPoint(
            x: x,
            y: y)
        addChild(sprite)
    }

    // Add new sprite with animation. Name has to be unique.
    func AddSpriteAnimation(
        _ name: String,
        _ atlasName: String! = nil, // Like "WormYellow"
        _ frameFromId: Int = -1,
        _ frameToId: Int = -1,
        _ frameStep: Int = -1,
        _ xScale: Int = 1,
        _ yScale: Int = 1)
    {
        func TryLoadAtlas() throws -> SKTextureAtlas?
        {
            return SKTextureAtlas(named: atlasName)
        }

        let textureAtlas: SKTextureAtlas?
        do
        {
            textureAtlas = try TryLoadAtlas()
        }
        catch
        {
            textureAtlas = nil
        }
        
        // Got atlas?
        if (textureAtlas == nil)
        { return }
        
        // Now load frames from it one by one.
        var sprite = PssstSprite()
        for frameNo in 0..<textureAtlas!.textureNames.count
        {
            let frameId = frameFromId + frameNo * frameStep
            let textureName = "\(atlasName)\(frameId)"
            let frame = textureAtlas?.textureNamed(textureName)
            if (frameNo == 0)
            {
                sprite = PssstSprite(texture: frame)
                sprite.name = name
                sprite.frames = []
            }
            sprite.frames.append(frame!)
        }
        addChild(sprite)
    }
    
    // Return sprite by name. On several found nil are returned so has to be unique.
    func LookupSprite(_ name: String) -> PssstSprite?
    {
        func FindFromName(_ object: AnyObject) -> Bool
        {
            if let sprite = object as? PssstSprite
            {
                return sprite.name == name
            }
            return false
        }
        let spritesFound = children.filter(FindFromName) as! [PssstSprite]
        return spritesFound.count == 1 ? spritesFound.first : nil
    }
    
    // Move existing sprite.
    func MoveSprite(
        _ xDistination: Int,
        _ yDistination: Int,
        _ travelTime: Double)
    {
        
    }
    
    // Remove existing sprite.
    func RemoveSprite(_ name : String)
    {
        
    }
    
    // Return T if sprite exist and F if not.
    func SpriteExist(_ name: String) -> Bool
    {
        return true
    }
    
    // On touch began for 1..N fingers.
    func OnTouchesBegan(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("Begin location = (\(location.x), \(location.y))")
    }
    // On touch has moved for 1..N fingers.
    func OnTouchesMoved(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("Moved location = (\(location.x), \(location.y))")
    }
    // On touch has ended for 1..N fingers.
    func OnTouchesEnded(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("End location = (\(location.x), \(location.y))")
    }
    // On touch has cancelled for 1..N fingers.
    func OnTouchesCancelled(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("Cancel location = (\(location.x), \(location.y))")
    }
    
}











