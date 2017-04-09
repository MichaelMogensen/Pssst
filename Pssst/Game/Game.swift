//
//  Game.swift
//  Defines a Pssst game
//
//  Created by Michael Mogensen on 31/03/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//

import Foundation
import SpriteKit

class PssstOld
{
   /****************************************
    * Basic static properties              *
    ****************************************/
    
    static let showStartScreen = false

    static let gameLim =
    [
        LaneLim(lane: 1, animal: EAnimal.worm, min: 3, max: 10),
        LaneLim(lane: 1, animal: EAnimal.duster, min: 0, max: 0),
        LaneLim(lane: 1, animal: EAnimal.bee, min: 0, max: 0),

        LaneLim(lane: 2, animal: EAnimal.worm, min: 3, max: 20),
        LaneLim(lane: 2, animal: EAnimal.duster, min: 3, max: 6),
        LaneLim(lane: 2, animal: EAnimal.bee, min: 0, max: 0),
        
        LaneLim(lane: 3, animal: EAnimal.worm, min: 3, max: 30),
        LaneLim(lane: 3, animal: EAnimal.duster, min: 3, max: 6),
        LaneLim(lane: 3, animal: EAnimal.bee, min: 3, max: 6)
    ]
    
    static var gameState: GameState!
    
   /****************************************
    * Basic properties.                    *
    ****************************************/
    
    var lane: Int = 1
    
    var gameScene: GameScene!
    
    var gameTimer: NSecondsTimer!
    
    var TheFlower: GameSpriteNode!
    {
        get { return gameScene.GetAnimation(PssstOld.gameState.flowerID) }
    }
    
   /****************************************
    * Init.                                *
    ****************************************/

    init(
        _ gameScene: GameScene,
        _ buildForDevice: EDevice,
        _ width: Int,
        _ height: Int)
    {
        // Setup right dimension for current divice.
        switch (buildForDevice)
        {
            case EDevice.iPhone6:
                AnimationBase.gameDimensions = GameDimensionsIPhone6(width: width, height: height)
            case EDevice.iPhone6Plus:
                AnimationBase.gameDimensions = nil
            case EDevice.iPad:
                AnimationBase.gameDimensions = nil
        }

        self.gameScene = gameScene
        self.gameTimer = NSecondsTimer(
            timeout: 1,
            handler: Update)
        PssstOld.gameState = GameState()
        Setup()
    }
    
   /****************************************
    * Worker methods.                      *
    ****************************************/

    // Add random worm(s).
    func CheckUpOnAllAnimals()
    {
        func LookupAnimalExtrema(_ animal: EAnimal) -> (min: Int, max:Int)
        {
            let allAnimalsInLane = PssstOld.gameLim.filter { $0.lane == self.lane }
            let animalRequested = allAnimalsInLane.filter { $0.animal == animal }[0]
            return (animalRequested.min, animalRequested.max)
        }
        // Add more animals as needed.
        CheckUpOnWorms(LookupAnimalExtrema)
        CheckUpOnDusters(LookupAnimalExtrema)
        CheckUpOnBees(LookupAnimalExtrema)
    }
    // Add random worm(s) if needed.
    func CheckUpOnWorms(_ lookupAnimalExtrema: (EAnimal) -> (min: Int, max:Int))
    {
        var wormAnimations: [WormAnimation] = []
        let wormsExtrema = lookupAnimalExtrema(EAnimal.worm)
        let wormsCountMin = wormsExtrema.min
        let wormsCountMax = wormsExtrema.max
        let wormsCount = gameScene.SelectNames("Worm").count
        // Add new worm(s).
        if (wormsCount < wormsCountMin)
        {
            for worm in 1...wormsCountMin
            {
                wormAnimations.append(CreateRandomWormCrawlingInZigZag(worm))
            }
        }
        else
        {
            if (wormsCount < wormsCountMax)
            { wormAnimations.append(CreateRandomWormCrawlingInZigZag(wormsCount + 1)) }
        }
        gameScene.AddAnimations(wormAnimations)
    }
    // Add random duster(s) if needed.
    func CheckUpOnDusters(_ lookupAnimalExtrema: (EAnimal) -> (min: Int, max:Int))
    {
        //let dusters = self.gameScene.SelectNames("Duster").count
        //let dusterExtrema = lookupAnimalExtrema(EAnimal.duster)
        // TODO.
    }
    // Add random bee(s) if needed.
    func CheckUpOnBees(_ lookupAnimalExtrema: (EAnimal) -> (min: Int, max:Int))
    {
        //let bees = self.gameScene.SelectNames("Bee").count
        //let beesExtrema = lookupAnimalExtrema(EAnimal.bee)
        // TODO.
    }
    // Depending on how many animals are eating the flower grow up or down :-)
    func CheckUpOnFlowerGrowth()
    {
        // Remember current rect. of flower in gamestate.
        if let theFlower = TheFlower
        {
            PssstOld.gameState.flowerRect = CGRect(origin: theFlower.position, size: theFlower.size)
        }
        // Attach leaf.
        let leafsCount = gameScene.SelectNames("Leaf").count
        if (leafsCount <  AnimationBase.gameDimensions.flowerLeafsMax)
        {
            let leafδy = 30
            let stemHeight = Int(PssstOld.gameState.flowerRect.height)
            if (stemHeight > leafδy * (1 + leafsCount))
            {
                gameScene.AddAnimation(CreateLeaf(MathHelper.IsEven(leafsCount) ? ESide.right : ESide.left, yPos: stemHeight - 10))
            }
        }
    }
    // Count animals in diff. states.
    func CheckUpOnGameState()
    {
        // Remember cunt of all eating animals in gamestate.
        func filterAnimalIsEating(_ object: AnyObject) -> (Bool)
        {
            if let animation = object as? GameSpriteNode
            {
                if let animalData = animation.data as? GameSpriteNodeDataAnimal
                {
                    return animalData.animalIsEating
                }
            }
            return false
        }
        PssstOld.gameState.animalsEating = self.gameScene.FilterChildren(filterAnimalIsEating).count
    }
    // Be sure that sufficient animals are present at all time.
    func UpdateGameState()
    {
        //CheckUpOnAllAnimals()
        //CheckUpOnGameState()
        //CheckUpOnFlowerGrowth()
    }
    // Setup beginning animations.
    func Setup(_ forReal: Bool = false)
    {
        if (PssstOld.showStartScreen && !forReal)
        {
            self.gameScene.AddAnimation(StartScreen())
        }
        else
        {
            self.gameScene.AddNode(LoadBackground())
            self.gameScene.AddAnimations(SprayCans())
            //self.gameScene.AddAnimation(Flower())
            //self.gameScene.AddAnimation(OwlForUser())
            //Start()
        }
    }
    // Load game backgound from original 1983 picture.
    func LoadBackground() -> GameSpriteNode!
    {
        let backgroundSprite = GameSpriteNode(imageNamed: "Background")
        backgroundSprite.name = "Background"
        backgroundSprite.size = CGSize(
            width: AnimationBase.gameDimensions.Width,
            height: AnimationBase.gameDimensions.Height)
        backgroundSprite.position = CGPoint(
            x: AnimationBase.gameDimensions.Width / 2,
            y: AnimationBase.gameDimensions.Height / 2)
        backgroundSprite.data = GameSpriteNodeData() // Not used for anything.
        return backgroundSprite
    }
    // Start the game.
    func Start()
    {
        self.gameTimer.Start()
    }
    // Update the game.
    func Update(_ tickCount: Int)
    {
        //Util.Log("Tick: \(tickCount), Animations: \(gameScene.Dump())")
        UpdateGameState()
    }
    // Stop the game.
    func Stop()
    {
        self.gameTimer.Stop()
    }
    
   /****************************************
    * Spray cans.                          *
    ****************************************/
    
    // Create 1 spraycan.
    func SprayCan(
        _ tool: ETool,
        pos: CGPoint,
        logicalId: Int) -> SprayCanAnimation
    {
        // To get the color clear.
        let color = tool.description.Trim("SprayCan")
        
        let textureAtlasName = "SprayCan\(color).atlas"
        let animationName = "SprayCan\(color)"
        let uniqueName = "SprayCan\(color)"
        
        let sprayCan = SprayCanAnimation(
                textureAtlasName: textureAtlasName,
                animationName: animationName,
                uniqueName: uniqueName,
                xPos: Int(pos.x),
                yPos: Int(pos.y),
                direction: EDirection.leftToRight,
                firstFrameNo: 1,
                frameDelta: 1)
        
        // Place logically.
        AnimationBase.gameDimensions.BookcaseContent[logicalId].type = tool
        return sprayCan
    }
    // Create N spraycans.
    func SprayCans() -> [SprayCanAnimation]
    {
        let sprayCans =
        [ ETool.blueSprayCan, ETool.yellowSprayCan, ETool.redSprayCan ]
        
        var someRandomFreeShelfIds = RandomNumbers.RandomDifferentInts(
            sprayCans.count,
            min: 0,
            max: AnimationBase.gameDimensions.BookcaseSize - 1)
        
        var someRandomFreeShelfPositions = AnimationBase.gameDimensions.GetShelfPositions(someRandomFreeShelfIds!)
        
        var spraycans: [SprayCanAnimation] = []
        var sprayCanId = 0
        for sprayCan in sprayCans
        {
            let aSprayCan = SprayCan(
                sprayCan,
                pos: (someRandomFreeShelfPositions?[sprayCanId])!,
                logicalId: (someRandomFreeShelfIds?[sprayCanId])!)
            spraycans.append(aSprayCan)
            sprayCanId += 1
        }
        return spraycans
    }

   /****************************************
    * Box.                                 *
    ****************************************/

   /****************************************
    * Water can.                           *
    ****************************************/

   /****************************************
    * Worms.                               *
    ****************************************/

    // Create 1 worm crawling in zigzag.
    func CreateWormCrawlingInZigZag(
        _ wormNo: Int,
        x1Pos: Int,
        y1Pos: Int,
        x2Pos: Int,
        y2Pos: Int,
        speed: EAnimationSpeed,
        color: String) -> WormAnimation!
    {
        let worm = WormAnimation(
            textureAtlasName: "Worm\(color).atlas",
            animationName: "Worm\(color)",
            uniqueName: "\(color)Worm\(wormNo)",
            xPos: x1Pos,
            yPos: y1Pos,
            yetAnotherWormIsEatingHandler: YetAnotherWormIsEating)
        worm.MoveInZigZagDownwards(
            x2Pos,
            yPos: y2Pos,
            speed: speed)
        return worm
    }
    // Create 1 random worm crawling in zigzag.
    func CreateRandomWormCrawlingInZigZag(_ wormNo: Int) -> WormAnimation!
    {
        // Random speed.
        let randomSpeed = EAnimationSpeed.undesided.random
        // Random color.
        let randomColor = EColor.Undesided.random
        // Random initial pos.
        let wormArea = Rect(
            left: AnimationBase.gameDimensions.WormMargin.left,
            top: AnimationBase.gameDimensions.Height - AnimationBase.gameDimensions.WormMargin.top,
            right: AnimationBase.gameDimensions.Width - AnimationBase.gameDimensions.WormMargin.right,
            bottom: AnimationBase.gameDimensions.WormMargin.bottom)
        let randomPointInWormArea = wormArea.RandomPointWithin()
        
        // From (x1, y1) to (x2, y2).
        let directionToCrawl = (Int(randomPointInWormArea.x) < AnimationBase.gameDimensions.Width / 2) ? EDirection.leftToRight : EDirection.rightToLeft
        let x1Pos = Int(randomPointInWormArea.x)
        let y1Pos = Int(randomPointInWormArea.y)
        let x2Pos = (directionToCrawl == EDirection.leftToRight) ? wormArea.right : wormArea.left
        let y2Pos = y1Pos - AnimationBase.gameDimensions.wormδy
        
        return CreateWormCrawlingInZigZag(
            wormNo,
            x1Pos: x1Pos,
            y1Pos: y1Pos,
            x2Pos: x2Pos,
            y2Pos: y2Pos,
            speed: randomSpeed,
            color: randomColor.rawValue)
    }
    // Eat-handler for worm.
    func YetAnotherWormIsEating(_ ID: String)
    {
        TagYetAnotherAnimalAsEating(ID)
    }
    
   /****************************************
    * Dusters.                             *
    ****************************************/
    
    // Create 1 duster.
    func Duster(
        _ dusterNo: Int,
        xPos: Int,
        yPos: Int,
        dx: Int,
        dy: Int) -> DusterAnimation!
    {
        let duster = DusterAnimation(
            textureAtlasName: "Duster.atlas",
            animationName: "DusterGreen",
            uniqueName: "Duster\(dusterNo)",
            xPos: xPos,
            yPos: yPos,
            yetAnotherDusterIsEatingHandler: YetAnotherDusterIsEating)
        return duster
    }
    // Eat-handler for duster.
    func YetAnotherDusterIsEating(_ ID: String)
    {
        TagYetAnotherAnimalAsEating(ID)
    }

   /****************************************
    * Bees.                                *
    ****************************************/
    
    // Create 1 bee.
    func Bee(
        _ beeNo: Int,
        xPos: Int,
        yPos: Int,
        dx: Int,
        dy: Int) -> BeeAnimation!
    {
        let bee = BeeAnimation(
            textureAtlasName: "Bee.atlas",
            animationName: "Bee",
            uniqueName: "Bee\(beeNo)",
            xPos: xPos,
            yPos: yPos,
            yetAnotherBeeIsEatingHandler: YetAnotherBeeIsEating)
        return bee
    }
    // Eat-handler for bee.
    func YetAnotherBeeIsEating(_ ID: String)
    {
        TagYetAnotherAnimalAsEating(ID)
    }
    
   /****************************************
    * Flower.                              *
    ****************************************/
    
    // Create 1 flower.
    func Flower() -> FlowerAnimation!
    {
        let flowerPos = AnimationBase.gameDimensions.FlowerPosition
        let flower = FlowerAnimation(
            textureAtlasName: "Flower.atlas",
            animationName: "Flower",
            uniqueName: "Flower",
            xPos: Int(flowerPos.x),
            yPos: Int(flowerPos.y),
            direction: EDirection.unknown,
            firstFrameNo: 50,
            frameDelta: 5)
        flower.Grow()
        PssstOld.gameState.flowerID = flower.animation.data.ID
        return flower
    }
    
   /****************************************
    * Leaf.                                *
    ****************************************/
    
    // Create 1 leaf.
    func CreateLeaf(_ side: ESide, yPos: Int) -> LeafAnimation!
    {
        let xPos = (side == ESide.left) ?
            Int(PssstOld.gameState.flowerRect.origin.x) - 14 :
            Int(PssstOld.gameState.flowerRect.origin.x) + 14
        
        let leaf = LeafAnimation(
            textureAtlasName: "Leaf.atlas",
            animationName: "Leaf",
            uniqueName: "Leaf",
            xPos: xPos,
            yPos: yPos,
            direction: EDirection.unknown,
            firstFrameNo: 1,
            frameDelta: 1)
        if (side == ESide.right)
        { leaf.animation.HorizontalTurnaround() }
        leaf.Grow()
        
        return leaf
    }
    
   /****************************************
    * Owl.                                 *
    ****************************************/

    // Create controlling "cursor".
    func OwlForUser() -> OwlAnimation!
    {
        let owl = Owl(
            AnimationBase.gameDimensions.Width / 2,
            yPos: AnimationBase.gameDimensions.Height / 2,
            color: "White")
        owl?.MoveInPlaceForever()
        return owl
    }
    // Create 1 owl.
    func Owl(
        _ xPos: Int,
        yPos: Int,
        color: String) -> OwlAnimation!
    {
        let owl = OwlAnimation(
            textureAtlasName: "Owl\(color).atlas",
            animationName: "Owl\(color)",
            uniqueName: "\(color)Owl",
            xPos: xPos,
            yPos: yPos)
        return owl
    }

   /****************************************
    * StartScreen.                         *
    ****************************************/
    
    // Create animated start screen with tape recorder load-stribes :-).
    func StartScreen() -> StartScreenAnimation!
    {
        let splashScr = StartScreenAnimation(
            xPos: AnimationBase.gameDimensions.Width / 2,
            yPos: AnimationBase.gameDimensions.Height / 2)
        splashScr.MoveInPlaceNCycles(10, restoreToFirstFrame: true, endAnimationHandler: StartScreenEnded)
        PssstOld.gameState.startScreenID = splashScr.animation.data.ID

        return splashScr
    }
    // End-handler for start screen.
    func StartScreenEnded()
    {
        // Remove start screen now and really begin the game...
        if let startScreen = gameScene.GetAnimation(PssstOld.gameState.startScreenID)
        {
            startScreen.removeFromParent()
            Setup(true)
        }
    }

   /****************************************
    * Workers.                             *
    ****************************************/
    
    // Turn flag to signal this animal as eating.
    func TagYetAnotherAnimalAsEating(_ ID: String)
    {
        /*
        // Remember that this animal is eating.
        if let animation = self.gameScene.GetAnimation(ID)
        {
            if let animalData = animation.data as? GameSpriteNodeDataAnimal
            {
                animalData.animalIsEating = true
                animation.data = animalData
            }
        }
        // Update all eating animal positions to help better position of new eating animal.
        (Pssst.gameState.leftEatingAnimalPositions,
         Pssst.gameState.rightEatingAnimalPositions) =
            GetPositionOfAllLeftAndRightEatingAnimals()
        // Update all eating animal count.
        Pssst.gameState.animalsEating = Pssst.gameState.leftEatingAnimalPositions.count + Pssst.gameState.rightEatingAnimalPositions.count
        // Time to shrink?
        if (Pssst.gameState.animalsEating == 1)
        {
            if let theFlower = TheFlower
            {
                let flower = FlowerAnimation(animation: theFlower)
                flower.Shrink()
            }
        }
        */
    }
    // Get left/right positions of all eating animals.
    func GetPositionOfAllLeftAndRightEatingAnimals() -> ([CGPoint]?, [CGPoint]?)
    {
        func onlyEatingAnimal(_ gsn: GameSpriteNode) -> (Bool)
        {
            if let animalData = gsn.data as? GameSpriteNodeDataAnimal
            { return animalData.animalIsEating }
            return false // Not an animal.
        }
        let eatingAnimals = self.gameScene.GetAnimations().filter(onlyEatingAnimal)
        // Collect positions of all animals eating L/R.
        var leftEatingAnimalPositions: [CGPoint]! = []
        var rightEatingAnimalPositions: [CGPoint]! = []
        for eatingAnimal in eatingAnimals
        {
            if (eatingAnimal.xScale == 1)
            { leftEatingAnimalPositions.append(eatingAnimal.position) }
            else
            { rightEatingAnimalPositions.append(eatingAnimal.position) }
        }
        return (leftEatingAnimalPositions, rightEatingAnimalPositions)
    }
}





