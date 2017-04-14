//
//  RandomNumbers.swift
//  Pssst
//
//  Created by Michael Mogensen on 30/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

class RandomNumbers
{
    // Return random int in [min; max].
    class func RandomInt(_ min: Int, _ max: Int) -> Int
    {
        var min_ = min
        var max_ = max
        if (min_ > max_)
        { MathHelper.Swop(&min_, &max_) }
        var value = max_ - min_ + 1
        value = value >= 0 ? value : 0
        let random = min_ + Int(arc4random_uniform(UInt32(value)))
        
        return random
    }
    // Return random int in [min; max].
    class func RandomIntEvenSpaced(_ min: Int, max: Int, neighbourValues: [Int], minDistance: Int) -> Int
    {
        func isAtSafeDisttanceFromAllItsNeighbours(_ value: Int, neighbourValues: [Int], minDistance: Int) -> Bool
        {
            for neighbourValue in neighbourValues
            {
                if abs(value - neighbourValue) < minDistance
                { return false }
            }
            return true
        }
        
        var attempts = 50
        var newRandomInt: Int
        repeat
        {
            newRandomInt = RandomNumbers.RandomInt(min, max)
            attempts -= 1
            if attempts == 0
            { return newRandomInt }
        }
        while (!isAtSafeDisttanceFromAllItsNeighbours(newRandomInt, neighbourValues: neighbourValues, minDistance: minDistance))
        
        return newRandomInt
    }
    // Return n different random int's in [min; max].
    class func RandomDifferentInts(_ numberOfDifferentRandomNumbers: Int, _ min: Int, _ max: Int) -> [Int]!
    {
        let range = max - min
        if (numberOfDifferentRandomNumbers > range)
        {
            // Impossible.
            return nil
        }
        
        // Local helper.
        func ensureUniqueRandomNumber(
            _ diffRandomNumbers: [Int],
            _ min: Int,
            _ max: Int) -> Int
        {
            var uniqueRandomNumber = 0
            repeat
            {
                uniqueRandomNumber = RandomNumbers.RandomInt(min, max)
            }
            while(diffRandomNumbers.contains(uniqueRandomNumber))
            
            return uniqueRandomNumber
        }
        
        // Collect n unique random numbers.
        var differentRandomNumbers: [Int] = []
        for _ in 0...numberOfDifferentRandomNumbers
        {
            let uniqueRandomNumber = ensureUniqueRandomNumber(differentRandomNumbers, min, max)
            differentRandomNumbers.append(uniqueRandomNumber)
        }
        
        return differentRandomNumbers
    }
    // Return 0 or 1 in 50% chance.
    class func FiftyFifty() -> Bool
    {
        let diceWith2Sides = RandomInt(0, 100)
        
        return diceWith2Sides > 50
    }
    // Return [0; 5] in 100/6% chance.
    class func RollDice() -> Int
    {
        let diceWith6Sides = RandomInt(0, 5)
        
        return diceWith6Sides
    }
}

