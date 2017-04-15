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
    class func RandomIntWithSpace(_ min: Int, _ max: Int, _ values: [Int]?, _ minDistAcceptable: Int) -> Int
    {
        if let values_ = values
        {
            if (values_.isEmpty)
            {
                return RandomInt(min, max)
            }
            
            repeat
            {
                let candidate = RandomInt(min, max)
                
                var minDiff = Int.max
                for value in values_
                {
                    let diff = abs(value - candidate)
                    if (diff < minDiff)
                    { minDiff = diff }
                }
                
                if (minDiff >= minDistAcceptable)
                { return candidate }
            }
            while(true)
        }
        else
        {
            return RandomInt(min, max)
        }
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
}

