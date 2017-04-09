//
//  GameViewController.swift
//  Pssst
//
//  Created by Michael Mogensen on 02/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

// iPhone6 display = 1334 × 750
// Background = 1024 x 768

import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    // Overridden methods.

    /*
     
    // ...
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    // ...
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
    // ...
    override var shouldAutorotate : Bool
    {
        return true
    }
    // ...
    override func supportedInterfaceOrientations() -> Int
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        }
        else
        {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    */
    
    // ...
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        /*
        let pssst = Pssst(size: view.bounds.size)
        pssst.Setup()
        */
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    // ...
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
    }
    
}


