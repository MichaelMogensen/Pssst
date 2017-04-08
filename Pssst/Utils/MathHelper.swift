//
//  MathHelper.swift
//  Pssst
//
//  Created by Michael Mogensen on 28/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

class MathHelper
{
    class func PhytagoraDist(_ dx: Float, dy: Float) -> Float
    {
        let dist = sqrt(pow(dx, 2.0) + pow(dy, 2.0))
        return dist
    }
    // Make α stay between β and γ.
    class func Between(_ α: inout Int, β: Int, γ: Int)
    {
        var β = β, γ = γ
        if (β > γ)
        { Swop(&β, b: &γ) }
        if (α < β)
        { α = β }
        else
            if (α > γ)
            { α = γ }
    }
    // Swop two values.
    class func Swop(_ a: inout Int, b: inout Int)
    {
        let temp = a
        b = a
        a = temp
    }
    class func IsEven(_ value: Int) -> Bool
    { return (value % 2 == 0) }
    class func IsOdd(_ value: Int) -> Bool
    { return !IsEven(value) }
}

