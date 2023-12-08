//
//  RulesScene.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 24.11.2023.
//

import SpriteKit
import AVFoundation

class RulesScene: ParentScene {
    let systemSoundTap: SystemSoundID = 1105
    
    
    override func didMove(to view: SKView) {
        configureStartScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "okButton" {
            AudioServicesPlaySystemSound(systemSoundTap)
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size:  self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
            gameScene.createHUD()
        }
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint.universalCenterBackground(size: self.size)
        let background = Background.populateBackground(at: screenCenterPoint, image: "backgroundScene")
        background.size = CGSize.universalBackground(size: self.size)
        background.zPosition = 0
        self.addChild(background)
        
        let okTexture = SKTexture(imageNamed: "ok")
        let okButton = SKSpriteNode(texture: okTexture)
        okButton.scaleTo(screenWidthPercentage: 0.9)
        okButton.zPosition = 1
        okButton.position = CGPoint(x: screenCenterPoint.x , y: self.frame.midY / 5)
        okButton.name = "okButton"
        self.addChild(okButton)
        
        let rulesLabel = SKSpriteNode(imageNamed: "rulesBack")
        rulesLabel.scaleTo(screenWidthPercentage: 0.9)
        rulesLabel.position = CGPoint(x: screenCenterPoint.x, y: self.frame.midY)
        rulesLabel.zPosition = 1
        self.addChild(rulesLabel)
        
        let rulesHeader = SKLabelNode(text: "Rules of the game")
        rulesHeader.position = CGPoint(x: 0, y: 110)
        rulesHeader.horizontalAlignmentMode = .center
        rulesHeader.zPosition = 2
        rulesHeader.fontName = "Inter-Bold"
        rulesHeader.fontColor = .black
        rulesHeader.fontSize = CGFloat.universalFont(size: 20)
        rulesHeader.preferredMaxLayoutWidth = rulesLabel.size.width - 40
        rulesLabel.addChild(rulesHeader)
        
        let rulesText = SKLabelNode(text: "Catch the right crypto coins and set new records! To catch a crypto coin, you need to tap it. If you hit the wrong crypto or miss the right one, you lose your life. ")
        rulesText.position = CGPoint(x: 0, y: -50)
        rulesText.horizontalAlignmentMode = .center
        rulesText.numberOfLines = 0
        rulesText.zPosition = 2
        rulesText.fontName = "Inter-Medium"
        rulesText.fontColor = .black
        rulesText.fontSize = CGFloat.universalFont(size: 16)
        rulesText.preferredMaxLayoutWidth = rulesLabel.size.width - 50
        rulesLabel.addChild(rulesText)
        
        let rulesFooter = SKLabelNode(text: "Good luck!")
        
        rulesFooter.position = CGPoint(x: 0, y: -130)
        rulesFooter.horizontalAlignmentMode = .center
        rulesFooter.zPosition = 2
        rulesFooter.fontName = "Inter-Bold"
        rulesFooter.fontColor = .black
        rulesFooter.fontSize = CGFloat.universalFont(size: 20)
        rulesFooter.preferredMaxLayoutWidth = rulesLabel.size.width - 40
        rulesLabel.addChild(rulesFooter)
    }
}
