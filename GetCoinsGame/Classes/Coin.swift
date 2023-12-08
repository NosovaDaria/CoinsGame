//
//  Coin.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 15.11.2023.
//

import SpriteKit
import GameplayKit

class Coin: SKSpriteNode {
    static func populateCoin() -> Coin  {
        let coinImageName = configureCoinName()
        let coin = Coin(imageNamed: coinImageName)
        coin.position = randomPoint()
        coin.size = CGSize(width: 50, height: 50.4)
        coin.scaleTo(screenWidthPercentage: 0.12)
        coin.zPosition = 1
        coin.name = coinImageName
        coin.anchorPoint = CGPoint(x: 0.5, y: 3.0)
        coin.run(move(from: coin.position))
        
        
        return coin
    }
    
   fileprivate static func configureCoinName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 6)
        let randomNumber = distribution.nextInt()
        let imageName = "coin" + "\(randomNumber)"
        
        return imageName
    }
    
    
    fileprivate static func move (from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: 100)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 60.0
        
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
    
    static func configureCoinsToCollectName() -> [String] {
        var coinsToCollect:[String] = []
        var imageName = ""
        for _ in 1...3 {
            repeat {
                let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 6)
                let randomNumber = distribution.nextInt()
                imageName = "coin" + "\(randomNumber)"
            } while coinsToCollect.contains(imageName)
            coinsToCollect.append(imageName)
        }
        return coinsToCollect
    }
    
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 150, highestValue: Int(screen.size.height) + 160)
        
        let y: CGFloat = CGFloat(distribution.nextInt())
        let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
}

