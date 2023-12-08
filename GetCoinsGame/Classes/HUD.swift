//
//  Score.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 16.11.2023.
//

import SpriteKit

class HUD: SKScene {
    let highScoreLabel = SKLabelNode(text: "High score: 0")
    let highScoreBackground = SKSpriteNode(imageNamed: "scoreBack")
    let scoreLabel = SKLabelNode(text: "Score: 0")
    let scoreBackground = SKSpriteNode(imageNamed: "scoreBack")
    let firstCoinToCollectBackground = SKSpriteNode(imageNamed: "coinBack")
    let secondCoinToCollectBackground = SKSpriteNode(imageNamed: "coinBack")
    let thirdCoinToCollectBackground = SKSpriteNode(imageNamed: "coinBack")
    
    let lifeFirst = SKSpriteNode(imageNamed: "lifepoint")
    let lifeSecond = SKSpriteNode(imageNamed: "lifepoint")
    let lifeThird = SKSpriteNode(imageNamed: "lifepoint")

    var firstCoinToCollect  = SKSpriteNode()
    var secondCoinToCollect = SKSpriteNode()
    var thirdCoinToCollect = SKSpriteNode()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = score.description
        }
    }
    
    func configureUI(screenSize: CGSize) {
        
        highScoreBackground.position = CGPoint(x: screenSize.width * 0.18, y: screenSize.height * 0.92)
        highScoreBackground.scaleTo(screenWidthPercentage: 0.32)
        highScoreBackground.zPosition = 5
        highScoreBackground.yScale = 1
        highScoreBackground.xScale = 1
        addChild(highScoreBackground)
        
        scoreBackground.position = CGPoint(x: screenSize.width * 0.18, y: screenSize.height * 0.84)
        scoreBackground.scaleTo(screenWidthPercentage: 0.32)
        scoreBackground.zPosition = 5
        scoreBackground.yScale = 1
        scoreBackground.xScale = 1
        addChild(scoreBackground)
        
        highScoreLabel.position = CGPoint(x: 0, y: 0)
        highScoreLabel.verticalAlignmentMode = .center
        highScoreLabel.horizontalAlignmentMode = .center
        highScoreLabel.zPosition = 6
        highScoreLabel.fontName = "Inter-Bold"
        highScoreLabel.fontColor = .black
        highScoreLabel.fontSize = CGFloat.universalFont(size: 15)
        highScoreLabel.numberOfLines = 1
        highScoreLabel.preferredMaxLayoutWidth = highScoreBackground.size.width - 10
        highScoreBackground.addChild(highScoreLabel)
        
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.zPosition = 6
        scoreLabel.fontName = "Inter-Bold"
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = CGFloat.universalFont(size: 15)
        scoreLabel.numberOfLines = 1
        scoreLabel.preferredMaxLayoutWidth = highScoreBackground.size.width - 10
        scoreBackground.addChild(scoreLabel)
        
        firstCoinToCollectBackground.position = CGPoint(x: screenSize.width * 0.2, y: screenSize.height * 0.07)
        firstCoinToCollectBackground.scaleTo(screenWidthPercentage: 0.16)
        firstCoinToCollectBackground.zPosition = 5
        firstCoinToCollectBackground.yScale = 1
        firstCoinToCollectBackground.xScale = 1
        addChild(firstCoinToCollectBackground)
        
        secondCoinToCollectBackground.position = CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.07)
        secondCoinToCollectBackground.scaleTo(screenWidthPercentage: 0.16)
        secondCoinToCollectBackground.zPosition = 5
        secondCoinToCollectBackground.yScale = 1
        secondCoinToCollectBackground.xScale = 1
        addChild(secondCoinToCollectBackground)
        
        thirdCoinToCollectBackground.position = CGPoint(x: screenSize.width * 0.8, y: screenSize.height * 0.07)
        thirdCoinToCollectBackground.scaleTo(screenWidthPercentage: 0.16)
        thirdCoinToCollectBackground.zPosition = 5
        thirdCoinToCollectBackground.yScale = 1
        thirdCoinToCollectBackground.xScale = 1
        addChild(thirdCoinToCollectBackground)
        
        
        let lifes = [lifeFirst, lifeSecond, lifeThird]
        for (index, life) in lifes.enumerated() {
            
            life.position = CGPoint.universalLifePosition(x: screenSize.width, y: screenSize.height * 0.92, size: life.size.width, index: index)
            life.scaleTo(screenWidthPercentage: 0.121)
            life.zPosition = 100
            addChild(life)
        }
    }
    
    func configureCoinsToCollect(coins: [String], screenSize: CGSize, first: Bool) {
        
        firstCoinToCollect = SKSpriteNode(imageNamed: coins[0])
        secondCoinToCollect = SKSpriteNode(imageNamed: coins[1])
        thirdCoinToCollect = SKSpriteNode(imageNamed: coins[2])
        
        firstCoinToCollect.size = CGSize(width: 50, height: 50.4)
        firstCoinToCollect.scaleTo(screenWidthPercentage: 0.12)
        firstCoinToCollect.alpha = 0
        firstCoinToCollect.position = CGPoint(x: 0, y: 0)
        firstCoinToCollect.zPosition = 6
        firstCoinToCollectBackground.addChild(firstCoinToCollect)
        
        secondCoinToCollect.size = CGSize(width: 50, height: 50.4)
        secondCoinToCollect.scaleTo(screenWidthPercentage: 0.12)
        secondCoinToCollect.alpha = 0
        secondCoinToCollect.position = CGPoint(x: 0, y: 0)
        secondCoinToCollect.zPosition = 6
        secondCoinToCollectBackground.addChild(secondCoinToCollect)
        
        thirdCoinToCollect.size = CGSize(width: 50, height: 50.4)
        thirdCoinToCollect.scaleTo(screenWidthPercentage: 0.12)
        thirdCoinToCollect.alpha = 0
        thirdCoinToCollect.position = CGPoint(x: 0, y: 0)
        thirdCoinToCollect.zPosition = 6
        thirdCoinToCollectBackground.addChild(thirdCoinToCollect)
        
        let fadeAlpha = SKAction.fadeAlpha(to: 1, duration: 2)
        
        if first {
            firstCoinToCollect.run(fadeAlpha)
            secondCoinToCollect.run(fadeAlpha)
            thirdCoinToCollect.run(fadeAlpha)
        } else {
            firstCoinToCollect.alpha = 1
            secondCoinToCollect.alpha = 1
            thirdCoinToCollect.alpha = 1
        }
    }
    
    func removeOldCollection() {
        firstCoinToCollect.removeFromParent()
        secondCoinToCollect.removeFromParent()
        thirdCoinToCollect.removeFromParent()
    }
}
