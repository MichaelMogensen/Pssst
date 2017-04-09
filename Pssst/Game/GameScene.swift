//
//  GameScene.swift
//  Pssst
//
//  Created by Michael Mogensen on 02/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
   /****************************************
    * Basic properties.                    *
    ****************************************/

    var pssst: Pssst! = nil
    
    let feelAllTouches = false
    var lastTouch: CGPoint? = nil
    
   /****************************************
    * Init.                                *
    ****************************************/
    
    override init(size: CGSize)
    {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// <#Description#>
    ///
    /// - Parameter view: <#view description#>
    override func didMove(to view: SKView)
    {
        BeginGame()
    }
    // Called on 1..n touchec began.
    /*
    override func touchesBegan(_ touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if (feelAllTouches)
        {
            for touch in touches
            {
                OnTouchesBegan(touch as! UITouch)
            }
        }
        else
        {
            let oneTouchOnly = touches.first as! UITouch
            OnTouchesBegan(oneTouchOnly)
        }
    }
    */
    // Called on 1..n touches moved.
    /*
    override func touchesMoved(_ touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if (feelAllTouches)
        {
            for touch in touches
            {
                OnTouchesMoved(touch as! UITouch)
            }
        }
        else
        {
            let oneTouchOnly = touches.first as! UITouch
            OnTouchesMoved(oneTouchOnly)
        }
    }
    */
    // Called on 1..n touches ended.
    /*
    override func touchesEnded(_ touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if (feelAllTouches)
        {
            for touch in touches
            {
                OnTouchesEnded(touch as! UITouch)
            }
        }
        else
        {
            let oneTouchOnly = touches.first as! UITouch
            OnTouchesEnded(oneTouchOnly)
        }
    }
    */
    // Called on 1..n touches cancelled.
    /*
    override func touchesCancelled(_ touches: Set<NSObject>!, withEvent event: UIEvent!)
    {
        if (feelAllTouches)
        {
            for touch in touches
            {
                OnTouchesCancelled(touch as! UITouch)
            }
        }
        else
        {
            let oneTouchOnly = touches.first as! UITouch
            OnTouchesCancelled(oneTouchOnly)
        }
    }
    */
    // Called before each frame is rendered.
    override func update(_ currentTime: TimeInterval)
    {
        OnUpdate()
    }
    
   /****************************************
    * Worker methods.                      *
    ****************************************/
    
    // Setup monocrome background.
    func SetupMonocromeBackground()
    {
        self.backgroundColor = SKColor.orange
    }
    // Begin the game by going to its next step.
    func BeginGame()
    {
        let buildForDevice = EDevice.iPhone6 // TODO: Find out dynamically.

        // Start over.
        removeAllChildren()
        self.pssst = Pssst(
            self,
            buildForDevice,
            Int(self.frame.size.width),
            Int(self.frame.size.height))
    }
    // End the game.
    func EndGame()
    {
        self.pssst.Stop()
    }
    
   /****************************************
    * Event handlers.                      *
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
    func OnUpdate()
    {
    }
}



