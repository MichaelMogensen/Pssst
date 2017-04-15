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
class PssstScene : SKScene
{
    /****************************************
     * Basic static properties              *
     ****************************************/
    
    static private let LevelLims =
    [
        LevelLim(level: 1, animal: EPssstAnimals.Worm,   min: 3, max: 7),
        LevelLim(level: 1, animal: EPssstAnimals.Duster, min: 0, max: 0),
        LevelLim(level: 1, animal: EPssstAnimals.Bee,    min: 0, max: 0),
        
        LevelLim(level: 2, animal: EPssstAnimals.Worm,   min: 3, max: 14),
        LevelLim(level: 2, animal: EPssstAnimals.Duster, min: 3, max: 7),
        LevelLim(level: 2, animal: EPssstAnimals.Bee,    min: 0, max: 0),
        
        LevelLim(level: 3, animal: EPssstAnimals.Worm,   min: 3, max: 21),
        LevelLim(level: 3, animal: EPssstAnimals.Duster, min: 3, max: 14),
        LevelLim(level: 3, animal: EPssstAnimals.Bee,    min: 3, max: 7)
    ]

    /****************************************
     * Basic properties.                    *
     ****************************************/
    
    private let Debug = true
    
    private var Screen: PssstScreen?
    private var Timer: NSecondsTimer?
    private var Level = 1
    private var Lives = 3
    private var Time: TimeInterval?
    
    /****************************************
     * Init.                                *
     ****************************************/
    
    override init(size: CGSize)
    {
        super.init(size: size)
        
        // Set to current screen.
        self.Screen = PssstScreen(Int(size.width), Int(size.height))
        //self.Timer = nil
        self.Timer = NSecondsTimer(1, OnTimeout)
        
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    deinit
    {
        EndGame()
    }
    
    /****************************************
     * Debug methods.                       *
     ****************************************/

    func PrintAllSprites()
    {
        let animals = "..."
        
        Util.Log(animals)
    }
    
    /****************************************
     * Internal methods.                    *
     ****************************************/
        
    // Begin game.
    func BeginGame()
    {
        // Build game scene.
        Level = 1
        Lives = 3
        CleanScene()
        PlaceSprayCans()
        //StartTimer()
    }

    // Continue game.
    func ProceedGame()
    {
        BringInTheAnimals()
    }
    
    // End game.
    func EndGame()
    {
        StopTimer()
    }
    
    /****************************************
     * Exposed methods.                     *
     ****************************************/
    
    /****************************************
     * Event handlers.                      *
     ****************************************/
    
    // Ready.
    override func didMove(to view: SKView)
    {
        BeginGame()
    }
    
    // Called before each frame is rendered.
    override func update(_ time: TimeInterval)
    {
        if let t = self.Time
        {
            let diff = time - t
            if (diff > 1.0)
            {
                self.Time = time
                BringInTheAnimals()
            }
        }
        else
        {
            BringInTheAnimals()
            self.Time = time
        }
    }

    /****************************************
     * Calc. methods.                       *
     ****************************************/

    /****************************************
     * Game logic methods.                  *
     ****************************************/
    
    // Add yet another animal.
    private func AddAnimal()
    {
    }

    // Add some random bees.
    private func AddBees(_ animalData: (Int, [Int]?))
    {
        if (animalData.0 < 1)
        { return }
    }

    // Add some random dusters.
    private func AddDusters(_ animalData: (Int, [Int]?))
    {
        if (animalData.0 < 1)
        { return }
    }

    // Add some random worms.
    private func AddWorms(_ animalData: (Int, [Int]?))
    {
        if (animalData.0 < 1)
        { return }
        
        for _ in 1...animalData.0
        {
            let randomColor = PssstRandomness.SelectRandomWormColor()
            let randomStartPoint = PssstRandomness.SelectRandomPointOnVerticalGameBoxSide(self.Screen!.GameBox, animalData.1)
            let randomZigZagPath = PssstRandomness.SelectRandomZigZigPath(Point(0, 0), Point(0, 0), 10.0)
            
            let worm = AddSpriteAlive(EPssstAnimals.Worm, randomColor, randomStartPoint)
            MoveSprite(worm)
            MoveSpriteAround(worm, randomZigZagPath)
        }
    }

    // Bring in animals according to the level.
    private func BringInTheAnimals()
    {
        func AnimalData(_ animal: EPssstAnimals) -> (Int, [Int]?)
        {
            let levelLimAnimal = GetLevelLim(animal)!
            let animals = GetAnimals(animal)!
            let extra = animals.count < levelLimAnimal.min ? levelLimAnimal.min : animals.count < levelLimAnimal.max ? 1 : 0
            let animalPositions = GetSpritePositions(animals)
            
            if (animalPositions == nil)
            { return (extra, nil) }
            
            var animalYCoordinates = [Int]()
            for animalPosition in animalPositions!
            {
                animalYCoordinates.append(animalPosition.y)
            }
            
            return (extra, animalYCoordinates)
        }
        
        let wormData = AnimalData(EPssstAnimals.Worm)
        AddWorms(wormData)
        let dusterData = AnimalData(EPssstAnimals.Duster)
        AddWorms(dusterData)
        let beeData = AnimalData(EPssstAnimals.Bee)
        AddWorms(beeData)
    }

    // Wipe all.
    private func CleanScene()
    {
        removeAllChildren()
        _ = AddSprite(
            EPssstAnimals.Background.Name,
            EPssstAnimals.Background.Name,
            Screen!.Width / 2,
            Screen!.Height / 2,
            Screen!.Width,
            Screen!.Height)
        self.Screen!.EmptyShelfs()
    }

    // Return array of specific animal - like "Worm".
    private func GetAnimals(_ animal: EPssstAnimals) -> [PssstSprite]?
    {
        let sprites = LookupSprites(animal.Name.description)
        
        return sprites
    }
    
    // Return count of specific animal - like "Worm".
    private func GetAnimalCount(_ animal: EPssstAnimals) -> Int
    {
        let sprites = LookupSprites(animal.Name.description)
        if let s = sprites
        {
            return s.count
        }
        
        return 0
    }
    
    // Return level limits for level/animal.
    func GetLevelLim(_ animal: EPssstAnimals) -> LevelLim?
    {
        for levelLim in PssstScene.LevelLims
        {
            if (levelLim.level == self.Level && levelLim.animal == animal)
            { return levelLim }
        }
        
        return nil
    }
    
    // Place spray tools.
    private func PlaceSprayCans()
    {
        
    }

    // Place box.
    private func PlacePointBox()
    {
        
    }

    /****************************************
     * Timer methods.                       *
     ****************************************/

    // Start timer.
    private func StartTimer()
    {
        self.Timer!.Start()
    }

    // Stop timer.
    private func StopTimer()
    {
        self.Timer!.Stop()
    }

    // On timeout.
    private func OnTimeout(tickCount: Int)
    {
//        Util.Log("tickCount = (\(tickCount))")
        ProceedGame()
    }
    
    /****************************************
     * Sprite methods.                      *
     ****************************************/

    // Add new sprite.
    private func AddSprite(
        _ name: String,
        _ nameImage: String?,
        _ x: Int,
        _ y: Int,
        _ width: Int,
        _ height: Int) -> PssstSprite
    {
        let sprite = nameImage == nil ? PssstSprite() : PssstSprite(imageNamed: nameImage!)
        sprite.name = name // + GUID() for at gøre navnet unikt.
        sprite.position = CGPoint(
            x: x,
            y: y)
        sprite.size = CGSize(
            width: width,
            height: height)
        addChild(sprite)
        
        return sprite
    }

    // Add new sprite with atlas.
    private func AddSpriteAlive(
        _ name: String,
        _ nameAtlas: String,
        _ startPoint: Point) -> PssstSprite
    {
        let atlas = LoadAtlas(nameAtlas)
        let sprite = AddSprite(name, nil, startPoint.x, startPoint.y, Int(atlas[0].size().width), Int(atlas[0].size().height))
        sprite.atlas = atlas
        
        return sprite
    }

    // Add new sprite with atlas. Based on enum's.
    private func AddSpriteAlive(
        _ animal: EPssstAnimals,
        _ color: EPssstColors,
        _ startPoint: Point) -> PssstSprite
    {
        let name = animal.Name
        let nameAtlas = "\(animal.Name)\(color.Name)"
        
        return AddSpriteAlive(
            name,
            nameAtlas,
            startPoint)
    }
    
    // Return positions of sprites.
    private func GetSpritePositions(_ sprites: [PssstSprite]?) -> [Point]?
    {
        if (sprites == nil)
        { return nil }
        
        var positions = [Point]()
        for sprite in sprites!
        {
            positions.append(Point(sprite.position))
        }
        
        return positions
    }
    
    // Return texture array from atlas.
    func LoadAtlas(_ name: String) -> [SKTexture]
    {
        let atlasName = "\(name).atlas"
        let atlas = SKTextureAtlas(named: atlasName)
        let atlasSize = atlas.textureNames.count
        var textures = [SKTexture]()
        for id in 1...atlasSize
        {
            let textureName = "\(name)\(id).png"
            textures.append(atlas.textureNamed(textureName))
        }
        
        return textures
    }
    
    // Return sprite by name when only one unique sprite are expected to be found.
    private func LookupSprite(_ name: String) -> PssstSprite?
    {
        func FindFromName(_ object: AnyObject) -> Bool
        {
            if let sprite = object as? PssstSprite
            {
                return sprite.name == name
            }
            return false
        }
        let spritesFound = children.filter(FindFromName) as! [PssstSprite]
        
        return spritesFound.count == 1 ? spritesFound.first : nil
    }

    // Return sprite by name when more sprites are expected to be found.
    private func LookupSprites(_ name: String) -> [PssstSprite]?
    {
        func FindFromName(_ object: AnyObject) -> Bool
        {
            if let sprite = object as? PssstSprite
            {
                return sprite.name == name
            }
            return false
        }
        let spritesFound = children.filter(FindFromName) as? [PssstSprite]
        
        return spritesFound
    }
    
    // Move existing sprite in place.
    private func MoveSprite(_ sprite: PssstSprite)
    {
        let frames = SKAction.animate(with: sprite.atlas, timePerFrame: 0.5 / Double(sprite.atlas.count))
        let action = SKAction.repeatForever(frames)
        sprite.run(action)
    }

    // Move existing sprite to new place.
    private func MoveSpriteAround(
        _ sprite: PssstSprite,
        _ newMoves: [Move])
    {
        var actions = [SKAction]()
        for newMove in newMoves
        {
            let action = SKAction.move(to: newMove.Point, duration: newMove.duration)
            actions.append(action)
        }
        let actionSequence = SKAction.sequence(actions)
        sprite.run(actionSequence)
    }
    
    // Remove existing sprite.
    private func RemoveSprite(_ name : String)
    {
    }
    
    // Return T if sprite exist and F if not.
    private func SpriteExist(_ name: String) -> Bool
    {
        return true
    }
    
    /****************************************
     * Helper methods.                      *
     ****************************************/
    
}











