//
//  PssstRandomness.swift
//  Pssst
//
//  Created by Michael Mogensen on 15/04/2017.
//  Copyright © 2017 Michael Mogensen. All rights reserved.
//

import Foundation

class PssstRandomness
{
    static private let WormColors =
        [ EPssstColors.Cyan, EPssstColors.Green, EPssstColors.Red, EPssstColors.Yellow ]
    static private let DusterColors =
        [ EPssstColors.Red, EPssstColors.Yellow ]
    static private let BeeColors =
        [ EPssstColors.Magenta, EPssstColors.Yellow ]
    
    static private let HorizontalSides =
        [ EPssstSides.Top, EPssstSides.Bottom ]
    static private let VerticalSides =
        [ EPssstSides.Left, EPssstSides.Right ]
    
    static private let MinVerticalDistanceBetweenAnimals = 20
    static private let MinHorizontalDistanceBetweenAnimals = 20
    
    /****************************************
     * Random colors.                       *
     ****************************************/
    
    class func SelectRandomWormColor() -> EPssstColors
    {
        let randomNumber = RandomNumbers.RandomInt(0, PssstRandomness.WormColors.count - 1)
        return PssstRandomness.WormColors[randomNumber]
    }

    class func SelectRandomDusterColor() -> EPssstColors
    {
        let randomNumber = RandomNumbers.RandomInt(0, PssstRandomness.DusterColors.count - 1)
        return PssstRandomness.DusterColors[randomNumber]
    }
    
    class func SelectRandomBeeColor() -> EPssstColors
    {
        let randomNumber = RandomNumbers.RandomInt(0, PssstRandomness.BeeColors.count - 1)
        return PssstRandomness.BeeColors[randomNumber]
    }
    
    /****************************************
     * Random positions.                    *
     ****************************************/
    
    class func SelectRandomHorizontalSide() -> EPssstSides
    {
        let randomNumber = RandomNumbers.RandomInt(0, HorizontalSides.count - 1)
        return HorizontalSides[randomNumber]
    }
    
    class func SelectRandomVerticalSide() -> EPssstSides
    {
        let randomNumber = RandomNumbers.RandomInt(0, VerticalSides.count - 1)
        return VerticalSides[randomNumber]
    }
    
    class func SelectRandomPointOnHorizontalGameBoxSide(_ gameBox: Rect) -> Point
    {
        let randomHSide = PssstRandomness.SelectRandomHorizontalSide()
        let randomPoint = Point(
            RandomNumbers.RandomInt(gameBox.left, gameBox.right),
            randomHSide == EPssstSides.Top ? gameBox.top : gameBox.bottom) // OBS!
        
        return randomPoint
    }
    
    class func SelectRandomPointOnVerticalGameBoxSide(_ gameBox: Rect, _ yCoordinatesToAvoidForClash: [Int]?) -> Point
    {
        let randomVSide = PssstRandomness.SelectRandomVerticalSide()
        let randomPoint = Point(
            randomVSide == EPssstSides.Left ? gameBox.left : gameBox.right,
            RandomNumbers.RandomIntWithSpace(gameBox.bottom, gameBox.top, yCoordinatesToAvoidForClash, PssstRandomness.MinVerticalDistanceBetweenAnimals))
 
        Util.Log("p = (\(randomPoint.x), \(randomPoint.y))")

        return randomPoint
    }
    
    class func SelectRandomZigZigPath(
        _ from: Point,
        _ to: Point,
        _ durationPerMove: TimeInterval) -> [Move]
    {
        let path =
            [
                Move(RandomNumbers.RandomInt(100, 200), RandomNumbers.RandomInt(100,200), 10.0)
                //            Move(100, 200, 2.0),
                //            Move(200, 200, 1.0),
                //            Move(200, 100, 2.0),
                //            Move(100, 100, 1.0)
        ]
        return path
    }
    
    class func SelectRandomCurvedPath(
        _ from: Point,
        _ to: Point,
        _ duration: TimeInterval)
    {
    }
}

