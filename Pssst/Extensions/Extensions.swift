//
//  Extensions.swift
//  Pssst
//
//  Created by Michael Mogensen on 31/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

/*
extension SKNode
{
    class func unarchiveFromFile(_ file : NSString) -> SKNode?
    {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks")
        {
            var sceneData = Data(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        }
        else
        {
            return nil
        }
    }
}
*/

extension CGPoint
{
    public func OffsetBy(_ dx: Int = 0, dy: Int = 0) -> CGPoint
    {
        return CGPoint(
            x: x + CGFloat(dx),
            y: y + CGFloat(dy))
    }
    public func OffsetBy(_ delta: CGSize) -> CGPoint
    {
        return CGPoint(
            x: x + delta.width,
            y: y + delta.height)
    }
}
func <(aPoint: CGPoint, bPoint: CGPoint) -> Bool
{ return (aPoint.x < bPoint.x) || (aPoint.y < bPoint.y) }

extension String
{
    func Replace(_ target: String, withString: String) -> String
    {
        return self.replacingOccurrences(
            of: target,
            with: withString,
            options: NSString.CompareOptions.literal,
            range: nil)
    }
    func Trim(_ target: String) -> String
    {
        return Replace(target, withString: "")
    }
}

extension GameScene
{
    // Add node.
    func AddNode(_ node: GameSpriteNode)
    {
        addChild(node)
    }
    // Ann one animation.
    func AddAnimation(_ animation: AnimationBase)
    {
        AddNode(animation.animation)
    }
    // Add array of animations.
    func AddAnimations(_ animations: [AnimationBase])
    {
        for animation in animations
        { AddAnimation(animation) }
    }
    // Return comma sep. list of names of all animations.
    func DumpNames() -> String
    {
        var commaSepList = ""
        let animations = SelectNames()
        for animation in animations
        {
            commaSepList += commaSepList.isEmpty ? animation : ", " + animation
        }
        return commaSepList
    }
    // Return children satisfying certain filter closure.
    func FilterChildren(_ filterExpression: (_ object: AnyObject) -> (Bool)) -> [GameSpriteNode]!
    {
        let childrenFiltered = children.filter(filterExpression) as! [GameSpriteNode]
        return childrenFiltered
    }
    // Select all names for all animations.
    func SelectNames() -> [String]
    {
        var names: [String] = []
        for child in children
        {
            names.append(child.name!)
        }
        return names
    }
    // Select all names containing specific substring.
    func SelectNames(_ match: String) -> [String]
    {
        let namesHoldingMatch: [String] = []
        for _ /*child*/ in children
        {
            /* FIX LATER
            if (child.name.rangeOfString(match) != nil)
            { namesHoldingMatch.append(child.name!) }
            */
        }
        return namesHoldingMatch
    }

    // Get animation having ID.
    func GetAnimation(_ ID: String) -> GameSpriteNode!
    {
        func theOneAndOnly(_ object: AnyObject) -> (Bool)
        {
            if let animation = object as? GameSpriteNode
            {
                if animation.data != nil
                {
                    return animation.data.ID == ID // Safe unpacking.
                }
            }
            return false // Something vent wrong.
        }
        let theOneAndOnlyNode = children.filter(theOneAndOnly) as! [GameSpriteNode]
        if theOneAndOnlyNode.count == 1
        { return theOneAndOnlyNode.first }
        // Not found.
        return nil
    }
    // Return all animations.
    func GetAnimations() -> [GameSpriteNode]!
    {
        return children as! [GameSpriteNode]
    }
}





