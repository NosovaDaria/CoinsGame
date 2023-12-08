//
//  GameOverScene.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 16.11.2023.
//

import SpriteKit
import AVFoundation


class GameOverScene: ParentScene {
    
    fileprivate let screenSize = UIScreen.main.bounds.size
    let systemSoundTap: SystemSoundID = 1105
    
    override func didMove(to view: SKView) {
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "tryAgainButton" {
            AudioServicesPlaySystemSound(self.systemSoundTap)
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let firstScene = FirstScene(size:  self.size)
            firstScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(firstScene, transition: transition)
        }
    }
    
    private func configureUI() {
        let screenCenterPoint = CGPoint.universalCenterBackground(size: self.size)
        let background = Background.populateBackground(at: screenCenterPoint, image: "background")
        background.size = CGSize.universalBackground(size: self.size)
        self.addChild(background)
        
        let tryAgainTexture = SKTexture(imageNamed: "tryAgain")
        let tryAgainButton = SKSpriteNode(texture: tryAgainTexture)
        tryAgainButton.scaleTo(screenWidthPercentage: 0.90)
        tryAgainButton.zPosition = 1
        tryAgainButton.position = CGPoint(x: screenCenterPoint.x , y: self.frame.midY / 5)
        tryAgainButton.name = "tryAgainButton"
        self.addChild(tryAgainButton)
        
        let headerLabel = SKSpriteNode(imageNamed: "youLostAllLives")
        headerLabel.scaleTo(screenWidthPercentage: 0.8)
        headerLabel.position = CGPoint(x: screenCenterPoint.x, y: self.frame.midY / 2)
        headerLabel.zPosition = 1
        self.addChild(headerLabel)
    }
}
