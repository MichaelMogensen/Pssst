//
//  GameEnums.swift
//  Pssst
//
//  Created by Michael Mogensen on 30/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation

enum EDialogAnswer : Int
{
    case cancel = 0, ok = 1, yes = 2, no = 3
    
    var description : String
    {
        switch self
        {
        case .cancel:
            return "Cancel"
        case .ok:
            return "OK"
        case .yes:
            return "Yes"
        case .no:
            return "No"
        }
    }
}

enum EAnimationSpeed: Double, CustomStringConvertible
{
    case undesided = 0.0, slow = 10.0, normal = 13.0, fast = 23.0
    
    var description : String
    {
        switch self
        {
            case .undesided: return "Undesided"
            case .slow: return "Slow"
            case .normal: return "Normal"
            case .fast: return "Fast"
        }
    }
    var random: EAnimationSpeed
    {
        get
        {
            let enums = [ EAnimationSpeed.slow, EAnimationSpeed.normal, EAnimationSpeed.fast ]
            let randomEnum = enums[RandomNumbers.RandomInt(0, enums.count - 1)]
            return randomEnum
        }
    }
}

enum EColor: String, CustomStringConvertible
{
    case Undesided = "", Blue = "Blue", Green = "Green", Yellow = "Yellow", Red = "Red"

    var description : String
    {
        return self.rawValue
    }
    var random: EColor
    {
        get
        {
            let enums = [ EColor.Undesided, EColor.Blue, EColor.Green, EColor.Yellow, EColor.Red ]
            let randomEnum = enums[RandomNumbers.RandomInt(1, enums.count - 1)]
            return randomEnum
        }
    }
}

enum EDevice: Int
{
    case iPhone6 = 0, iPhone6Plus = 1, iPad = 2
}

enum EDirection
{
    case leftToRight, rightToLeft, bottomToTop, topToBottom, unknown
}

enum ESide: Int
{
    case undesided = -1, left = 0, right = 1

    var random: ESide
    {
        get
        {
            let enums = [ ESide.undesided, ESide.left, ESide.right ]
            let randomEnum = enums[RandomNumbers.RandomInt(1, enums.count - 1)]
            return randomEnum
        }
    }
}

enum ETool : Int
{
    case
        nothing = 0,
        blueSprayCan = 1,
        redSprayCan = 2,
        yellowSprayCan = 3,
        box = 4,
        waterCan = 5

    var description : String
    {
        switch self
        {
            case .nothing: return "Nothing"
            case .blueSprayCan: return "BlueSprayCan"
            case .redSprayCan: return "RedSprayCan"
            case .yellowSprayCan: return "YellowSprayCan"
            case .box: return "Box"
            case .waterCan: return "WaterCan"
        }
    }
}

enum EAnimal : Int
{
    case
        nothing = 0,
        worm = 1,
        duster = 2,
        bee = 3
    
    var description : String
    {
        switch self
        {
            case .nothing: return "Nothing"
            case .worm: return "Worm"
            case .duster: return "Duster"
            case .bee: return "Bee"
        }
    }
}





