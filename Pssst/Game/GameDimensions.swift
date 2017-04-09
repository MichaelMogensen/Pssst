//
//  GameDimensions.swift
//  Pssst
//
//  Created by Michael Mogensen on 28/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class GameDimensions
{
   /****************************************
    * Dim. of screen.                      *
    ****************************************/
    
    private var width: Int = 0
    var Width: Int
    { get { return width } set { width = newValue } }
    
    private var height: Int = 0
    var Height: Int
    { get { return height } set { height = newValue } }

   /****************************************
    * Dim. of things inside the game.      *
    ****************************************/
    
    // All these must be set for new background on each device.
    var flowerCrownHeightMax: Int = 0
    var flowerLeafsMax: Int = 4
    
    var xPosOfShelf: [Int]! = nil
    var yPosOfShelf: [Int]! = nil

    var BrickWallThickness: CGFloat = 0
    var FloorThickness: CGFloat = 0
    var ShelfThickness: CGFloat = 0
    var ShelfHeight: CGFloat = 0
    var ShelfWidth: CGFloat = 0

    var WormMargin: Rect! = nil
    var wormδy: Int! = nil
    
   /****************************************
    * Init.                                *
    ****************************************/
    
    init(width: Int, height: Int)
    {
        self.width = width
        self.height = height
        EmptyBookcase()
    }
    
   /****************************************
    * Bookcase and its shelfs.             *
    ****************************************/
    
    // Return screen pos. for shelf. All background regarded as one bookcase.
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

    var BookcaseSize: Int
    { return 10 }
    
    var bookcaseContent: [Tool]! = nil
    var BookcaseContent: [Tool]!
    { get { return bookcaseContent } set { bookcaseContent = newValue } }
    
    // Make bookcase empty.
    func EmptyBookcase()
    {
        if (self.BookcaseContent == nil)
        {
            self.BookcaseContent = []
        }
        else
        {
            self.BookcaseContent.removeAll(keepingCapacity: false)
        }
        for shelfId in 0...self.BookcaseSize
        {
            self.BookcaseContent.append(Tool(shelfId: shelfId))
        }
    }
    
    // Return shelf pos. from id = 0 -> self.BookcaseSize - 1.
    func GetShelfPosition(_ shelfId: Int) -> CGPoint!
    {
        let shelfId = shelfId
        if (shelfId < 0 || shelfId > self.BookcaseSize - 1)
        { return nil } // Error.
        
        var x = ESide.left
        var y = shelfId
        
        if (y >= self.BookcaseSize / 2)
        {
            y -= (self.BookcaseSize / 2)
            x = ESide.right
        }
        return CGPoint(
            x: self.xPosOfShelf[x.rawValue],
            y: self.yPosOfShelf[y])
    }
    // Return several of the above.
    func GetShelfPositions(_ shelfIds: [Int]) -> [CGPoint]!
    {
        let shelfIds = shelfIds
        var shelfPositions: [CGPoint] = []
        for shelfId in shelfIds
        {
            shelfPositions.append(GetShelfPosition(shelfId))
        }
        return shelfPositions
    }
    // Return rendom free shelf id.
    func GetRandomFreeShelfId() -> Int
    {
        // TODO: Check that not all is occupied!
        repeat
        {
            let someRandomShelfId = RandomNumbers.RandomInt(
                0,
                BookcaseSize - 1)
            if (self.BookcaseContent[someRandomShelfId].type == ETool.nothing)
            { return someRandomShelfId }
        }
        while(true)
    }
    
   /****************************************
    * Flower.                              *
    ****************************************/
    
    // Return flower pos.
    var FlowerPosition: CGPoint
    {
        get
        {
            let flowerPosition = CGPoint(
                x: Int(self.Width) / 2,
                y: Int(self.FloorThickness))
            return flowerPosition
        }
    }
}

class GameDimensionsIPhone6 : GameDimensions
{
   /****************************************
    * Init.                                *
    ****************************************/
    
    override init(width: Int, height: Int)
    {
        super.init(width: width, height: height)
        //super.init(width: 667, height: 375)
        
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
    }

}






