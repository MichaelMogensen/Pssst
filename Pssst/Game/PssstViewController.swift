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

class PssstViewController : UIViewController
{
    
    // ...
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let pssst = PssstScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        pssst.scaleMode = .resizeFill
        skView.presentScene(pssst)
    }
    
    // ...
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
    }

}


