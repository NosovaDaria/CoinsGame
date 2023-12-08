//
//  FirstScene.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 17.11.2023.
//

import SpriteKit
import AVFoundation

class FirstScene: ParentScene {

    let systemSoundTap: SystemSoundID = 1105
    
    
    override func didMove(to view: SKView) {
        configureStartScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "playButton" {
            AudioServicesPlaySystemSound(systemSoundTap)
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let rulesScene = RulesScene(size:  self.size)
            rulesScene.scaleMode = .aspectFit
            self.scene?.view?.presentScene(rulesScene, transition: transition)
        }
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint.universalCenterBackground(size: self.size)
        let background = Background.populateBackground(at: screenCenterPoint, image: "background")
        background.size = CGSize.universalBackground(size: self.size)
        self.addChild(background)
        
        let playTexture = SKTexture(imageNamed: "play")
        let playButton = SKSpriteNode(texture: playTexture)
        playButton.scaleTo(screenWidthPercentage: 0.90)
        playButton.zPosition = 1
        playButton.position = CGPoint(x: screenCenterPoint.x , y: self.frame.midY / 5)
        playButton.name = "playButton"
        self.addChild(playButton)
        
        let headerLabel = SKSpriteNode(imageNamed: "getToBitcoin")
        headerLabel.scaleTo(screenWidthPercentage: 0.8)
        headerLabel.position = CGPoint(x: screenCenterPoint.x, y: self.frame.midY / 2)
        headerLabel.zPosition = 1
        self.addChild(headerLabel)
    }
}
