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
    
    // Load game backgound from original 1983 picture.
    private func LoadBackground() -> SKSpriteNode!
    {
        let backgroundSprite = SKSpriteNode(imageNamed: "Background")
        backgroundSprite.name = "Background"
        backgroundSprite.size = CGSize(
            width: Screen!.Width,
            height: Screen!.Height)
        backgroundSprite.position = CGPoint(
            x: Screen!.Width / 2,
            y: Screen!.Height / 2)
        return backgroundSprite
    }
    
    // Begin game.
    func BeginGame()
    {
        // Build game scene.
        removeAllChildren()
        addChild(LoadBackground())
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

    // On touch began for 1..N fingers.
    func OnTouchesBegan(_ touch: UITouch)
    {
        let location = touch.location(in: self)
        
        Util.Log("Begin location = (\(location.x), \(location.y))")
    }
    // On touch has moved for 1..N fingers.
    func OnTouchesMoved(_ touch: UITouch)
    {
        let location = touch.location(in: self)
        
        Util.Log("Moved location = (\(location.x), \(location.y))")
    }
    // On touch has ended for 1..N fingers.
    func OnTouchesEnded(_ touch: UITouch)
    {
        let location = touch.location(in: self)
        
        Util.Log("End location = (\(location.x), \(location.y))")
    }
    // On touch has cancelled for 1..N fingers.
    func OnTouchesCancelled(_ touch: UITouch)
    {
        let location = touch.location(in: self)
        
        Util.Log("Cancel location = (\(location.x), \(location.y))")
    }
    
}











