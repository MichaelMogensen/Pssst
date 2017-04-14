//
//  Screen.swift
//  Pssst
//
//  Created by Michael Mogensen on 10/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

class PssstScreen
{
    /****************************************
     * Basic static properties              *
     ****************************************/
    
    /****************************************
     * Basic properties.                    *
     ****************************************/

    var Width = 0
    var Height = 0
    
    var Shelfs = [Int : Shelf]()
    
    var BrickWallThickness = 0
    var FloorThickness = 0
    var ShelfThickness = 0
    var ShelfHeight = 0
    var ShelfWidth = 0
    
    var NonAnimalMargin = Rect(0, 0, 0, 0)
    var Animalδy = 0

    var GameBox: Rect
    { get { return Rect(
        NonAnimalMargin.left,
        NonAnimalMargin.top,
        Width - NonAnimalMargin.right,
        Height - NonAnimalMargin.bottom) } }
    
    /****************************************
     * Exposed methods.                     *
     ****************************************/

    // Setup fixpoints for screen of current device.
    init(_ width: Int, _ height: Int)
    {
        // Pct. measures as doubles are based on iPhone6 from absolute pixels. The iPhone6 constant
        // is the iPhone6 screen size and the fixed numbers in all the following %-constants are
        // also found on a iPhone6 screen.
        let iPhone6 = (667.0, 375.0)
        
        let shelfXPosPct =
        [
            41.0 / iPhone6.0,
            625.0 / iPhone6.0
        ]
        let shelfYPosPct =
        [
            15.0 / iPhone6.1,
            78.0 / iPhone6.1,
            140.0 / iPhone6.1,
            203.0 / iPhone6.1,
            265.0 / iPhone6.1
        ]
        
        let BrickWallThicknessPct = 21.0 / iPhone6.0
        let FloorThicknessPct = 14.0 / iPhone6.1
        let ShelfThicknessPct = 16.0 / iPhone6.1
        let ShelfHeightPct = 47.0 / iPhone6.1
        let ShelfWidthPct = 41.0 / iPhone6.0
        
        let NonAnimalMarginLeftPct = 80.0 / iPhone6.0
        let NonAnimalMarginTopPct = 20.0 / iPhone6.1
        let NonAnimalMarginRightPct = 80.0 / iPhone6.0
        let NonAnimalMarginBottomPct = 100.0 / iPhone6.1
        
        let AnimalδyPct = 30.0 / iPhone6.1
        
        // Set to current screen.
        self.Width = width
        self.Height = height

        // Setup shelfs positions for current screen.
        self.Shelfs.removeAll()
        for xid in 0..<shelfXPosPct.count
        {
            for yid in 0..<shelfYPosPct.count
            {
                let id = xid * shelfYPosPct.count + yid
                self.Shelfs[id] = Shelf(
                    Int(Double(self.Width) * shelfXPosPct[xid]),
                    Int(Double(self.Height) * shelfYPosPct[yid]),
                    false)
            }
        }
        
        // Setup all the other fixpoints for current screen.
        self.BrickWallThickness = Int(Double(self.Width) * BrickWallThicknessPct)
        self.FloorThickness = Int(Double(self.Height) * FloorThicknessPct)
        self.ShelfThickness = Int(Double(self.Height) * ShelfThicknessPct)
        self.ShelfHeight = Int(Double(self.Height) * ShelfHeightPct)
        self.ShelfWidth = Int(Double(self.Width) * ShelfWidthPct)
        
        self.NonAnimalMargin = Rect(
            Int(Double(self.Width) * NonAnimalMarginLeftPct),
            Int(Double(self.Height) * NonAnimalMarginTopPct),
            Int(Double(self.Width) * NonAnimalMarginRightPct),
            Int(Double(self.Height) * NonAnimalMarginBottomPct))
        
        self.Animalδy = Int(Double(self.Height) * AnimalδyPct)
    }
    
    // Empty all shelfs.
    func EmptyShelfs()
    {
        for id in 0..<self.Shelfs.count
        { EmptyShelf(id) }
    }
    
    // Empty shelf.
    func EmptyShelf(_ id: Int)
    {
        let s = self.Shelfs[id]!
        s.IsOccupied = false
        self.Shelfs.updateValue(s, forKey: id)
    }
    
    // Occupy shelf.
    func OccupyShelf(_ id: Int)
    {
        let s = self.Shelfs[id]!
        s.IsOccupied = true
        self.Shelfs.updateValue(s, forKey: id)
    }
}

