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
class Pssst : SKScene
{
    /****************************************
     * Basic static properties              *
     ****************************************/

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

    static private let iPhone6 = (667, 375)
    
    static private let shelfXPosPct =
    [
         41 / iPhone6.0,
        625 / iPhone6.0
    ]
    static private let shelfYPosPct =
    [
         15 / iPhone6.1,
         78 / iPhone6.1,
        140 / iPhone6.1,
        203 / iPhone6.1,
        265 / iPhone6.1
    ]

    static private let BrickWallThicknessPct = 21 / iPhone6.0
    static private let FloorThicknessPct = 14 / iPhone6.0
    static private let ShelfThicknessPct = 16 / iPhone6.0
    static private let ShelfHeightPct = 47 / iPhone6.0
    static private let ShelfWidthPct = 41 / iPhone6.0

    static private let NonAnimalMarginPct = Rect(
        left:    80 / iPhone6.0,
        top:     20 / iPhone6.1,
        right:   80 / iPhone6.0,
        bottom: 100 / iPhone6.1)
    static private let AnimalδyPct = 30 / iPhone6.1

    /****************************************
     * Basic properties.                    *
     ****************************************/
    
    private var Width = 0
    private var Height = 0
    
    private var Shelfs = [Shelf]()
    
    private var BrickWallThickness = 0
    private var FloorThickness = 0
    private var ShelfThickness = 0
    private var ShelfHeight = 0
    private var ShelfWidth = 0

    private var NonAnimalMargin = 0
    private var Animalδy = 0
    
    /****************************************
     * Init.                                *
     ****************************************/
    
    override init(size: CGSize)
    {
        super.init(size: size)
        
        // Set to current screen.
        self.Width = Int(size.width)
        self.Height = Int(size.height)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    /****************************************
     * Internal methods.                    *
     ****************************************/
    
    /****************************************
     * Exposed methods.                     *
     ****************************************/
    
    // Setup the game.
    func Setup()
    {
        // Setup empty shelfs for current screen.
        Shelfs = []
        for xid in 0..<Pssst.shelfXPosPct.count
        {
            for yid in 0..<Pssst.shelfYPosPct.count
            {
                let id = xid * Pssst.shelfYPosPct.count + yid
                Shelfs.append(Shelf(id, self.Width * Pssst.shelfXPosPct[xid], self.Height * Pssst.shelfYPosPct[yid], false))
            }
        }
        
        // Setup all the other fixpoints for current screen.
        self.BrickWallThickness = self.Width * Pssst.BrickWallThicknessPct
        
        
        
        // And the rest ...
    }
    
    /****************************************
     * Event handlers.                      *
     ****************************************/

    /****************************************
     * Helper methods.                      *
     ****************************************/
    
}











