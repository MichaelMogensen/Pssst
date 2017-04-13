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
        _ = AddSprite(
            EPssstAnimals.Background.Name,
            Screen!.Width / 2,
            Screen!.Height / 2,
            Screen!.Width,
            Screen!.Height)

        
        let sprite = AddSpriteAlive("WormGreen", 100, 100)
        MoveSprite(sprite: sprite)
        MoveSpriteTo(sprite, 200, 200)
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
//        Util.Log("Time = (\(currentTime))")
    }

    /****************************************
     * Helper methods.                      *
     ****************************************/

    // Add new sprite.
    private func AddSprite(
        _ name: String?,
        _ x: Int,
        _ y: Int,
        _ width: Int,
        _ height: Int) -> PssstSprite
    {
        let sprite = name == nil ? PssstSprite() : PssstSprite(imageNamed: name!)
        sprite.name = name
        sprite.position = CGPoint(
            x: x,
            y: y)
        sprite.size = CGSize(
            width: width,
            height: height)
        addChild(sprite)
        
        return sprite
    }

    // Add new sprite with atlas.
    private func AddSpriteAlive(
        _ name: String,
        _ x: Int,
        _ y: Int) -> PssstSprite
    {
        let atlas = LoadAtlas(name)
        let sprite = AddSprite(nil, x, y, Int(atlas[0].size().width), Int(atlas[0].size().height))
        sprite.atlas = atlas
        
        return sprite
    }
    
    // Return texture array from atlas.
    func LoadAtlas(_ name: String) -> [SKTexture]
    {
        let atlasName = "\(name).atlas"
        let atlas = SKTextureAtlas(named: atlasName)
        let atlasSize = atlas.textureNames.count
        var textures = [SKTexture]()
        for id in 1...atlasSize
        {
            let textureName = "\(name)\(id).png"
            textures.append(atlas.textureNamed(textureName))
        }
        return textures
    }
    
    // Return sprite by name when only one unique sprite are expected to be found.
    private func LookupSprite(_ name: String) -> PssstSprite?
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

    // Return sprite by name when more sprites are expected to be found.
    private func LookupSprites(_ name: String) -> [PssstSprite?]
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
        return spritesFound
    }
    
    // Move existing sprite.
    private func MoveSprite(
        _ xDistination: Int,
        _ yDistination: Int,
        _ travelTime: Double)
    {
        
    }

    // Move existing sprite in place.
    private func MoveSprite(sprite: PssstSprite)
    {
        let frames = SKAction.animate(with: sprite.atlas, timePerFrame: 0.5 / Double(sprite.atlas.count))
        let action = SKAction.repeatForever(frames)
        sprite.run(action)
    }

    // Move existing sprite in place.
    private func MoveSpriteTo(
        _ sprite: PssstSprite,
        _ newX: Int,
        _ newY: Int)
    {
        let newPoint = CGPoint(x: CGFloat(newX), y: CGFloat(newY))
        let action = SKAction.move(to: newPoint, duration: 5.0)
        sprite.run(action)
    }

    // Remove existing sprite.
    private func RemoveSprite(_ name : String)
    {
    }
    
    // Return T if sprite exist and F if not.
    private func SpriteExist(_ name: String) -> Bool
    {
        return true
    }
    
    // On touch began for 1..N fingers.
    private func OnTouchesBegan(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("Begin location = (\(location.x), \(location.y))")
    }
    // On touch has moved for 1..N fingers.
    private func OnTouchesMoved(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("Moved location = (\(location.x), \(location.y))")
    }
    // On touch has ended for 1..N fingers.
    private func OnTouchesEnded(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("End location = (\(location.x), \(location.y))")
    }
    // On touch has cancelled for 1..N fingers.
    private func OnTouchesCancelled(_ touch: UITouch)
    {
//        let location = touch.location(in: self)
//        
//        Util.Log("Cancel location = (\(location.x), \(location.y))")
    }
    
}











