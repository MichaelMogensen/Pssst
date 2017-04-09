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
    
    var Width = 0
    var Height = 0
    
    var ShelfXPos = [ 0, 0 ]
    var ShelfYPos = [ 0, 0, 0, 0, 0 ]
    
    var BrickWallThickness = 0
    var FloorThickness = 0
    var ShelfThickness = 0
    var ShelfHeight = 0
    var ShelfWidth = 0

    var NonAnimalMargin = 0
    var Animalδy = 0
    
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
        // Make x shelf pos. match current screen.
        for x in 0...self.ShelfXPos.count
        { self.ShelfXPos[x] = self.Width * Pssst.shelfXPosPct[x] }
        // Make y shelf pos. match current screen.
        for y in 0...self.ShelfYPos.count
        { self.ShelfXPos[y] = self.Height * Pssst.shelfYPosPct[y] }
        
        // Make all the other fixpoints match current screen.
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

/*
 
 private var width: Int = 0
 var Width: Int
 { get { return width } set { width = newValue } }
 
 private var height: Int = 0
 var Height: Int
 { get { return height } set { height = newValue } }

*/

/*
 // static let iPhone6_Screen =         (667, 375)
 
 // Flower.
 self.flowerCrownHeightMax = 110
 
 // Measured pix. pos. in used background.
 self.xPosOfShelf = [ 41, 625 ]
 self.yPosOfShelf = [ 15, 78, 140, 203, 265 ]
 
 // Measured pix. pos. in used background.
 self.BrickWallThickness = 21
 self.FloorThickness = 14
 self.ShelfThickness = 16
 self.ShelfHeight = 47
 self.ShelfWidth = 41
 
 self.WormMargin = Rect(left: 80, top: 20, right: 80, bottom: 100)
 self.wormδy = 30
 
 */









