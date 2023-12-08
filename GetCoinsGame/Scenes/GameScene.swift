//
//  GameScene.swift
//  8888
//
//  Created by Дарья Носова on 15.11.2023.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: ParentScene {
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var lives = 3 {
        didSet {
           countLives()
        }
    }
    let systemSoundTap: SystemSoundID = 1306
    var movementSpeed: CGFloat = 1.0
    var coinsToCollect: [String] = []
    var timeOfTheLastReload: CFTimeInterval = 0.0
    var timePerReload: CFTimeInterval = 5.0
    var first = true
    
    var viewController: UIViewController!
    

    override func sceneDidLoad() {
        hud.highScoreLabel.text = "High score: \(gameResult.highScore[0])"

    }
    
    override func didMove(to view: SKView) {
        self.spawnCoins()
        self.increaseSpeed()
        configureStartScene()
        reloadCoinsToCollect()
    }
    
    
    fileprivate func spawnCoins() {
        let spawnCoinsWait = SKAction.wait(forDuration: 2.0)

        let spawnCoinAction = SKAction.run {
            let coin = Coin.populateCoin()
            self.addChild(coin)
        }
        let spawnCoinsSequence = SKAction.sequence([spawnCoinsWait, spawnCoinAction])
        let spawnCoinsForever = SKAction.repeatForever(spawnCoinsSequence)
        run(spawnCoinsForever, withKey: "spawnCoins")
    }
    
    fileprivate func reloadCoinsToCollect() {
        coinsToCollect = Coin.configureCoinsToCollectName()
        hud.configureCoinsToCollect(coins: coinsToCollect, screenSize: screenSize, first: first)
    }
    
    
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint.universalCenterBackground(size: self.size)
        let background = Background.populateBackground(at: screenCenterPoint, image: "backgroundScene")
        background.size = CGSize.universalBackground(size: self.size)
        self.addChild(background)
    }
    
    override func didSimulatePhysics() {
        enumerateChildNodes(withName: "*coin*") { node, stop in
            node.speed = self.movementSpeed
            self.removeCoin(at: node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            
            switch node.name {
                case "coin1":
                    takeCoin(at: node)
                case "coin2":
                    takeCoin(at: node)
                case "coin3":
                    takeCoin(at: node)
                case "coin4":
                    takeCoin(at: node)
                case "coin5":
                    takeCoin(at: node)
                case "coin6":
                    takeCoin(at: node)
                case .none:
                    return
                case .some(_):
                    return
            }

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (currentTime - timeOfTheLastReload > timePerReload) {
            coinsToCollect.removeAll()
            hud.removeOldCollection()
            reloadCoinsToCollect()
            self.timeOfTheLastReload = currentTime
            first = false
        }
    }
    
    func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    private func increaseSpeed() {
        let wait = SKAction.wait(forDuration: 10.0)
        let update = SKAction.run(
        {
            self.movementSpeed += 0.3
        }
        )
        let seq = SKAction.sequence([wait,update])
        let repeatUpdate = SKAction.repeatForever(seq)
        run(repeatUpdate)
    }
    
    private func takeCoin(at node: SKNode) {
        let fadeOutAction = SKAction.fadeOut(withDuration: 1)
        node.run(fadeOutAction)
        node.removeFromParent()
        
        guard let name = node.name else { return }
        if coinsToCollect.contains(name) {
            AudioServicesPlaySystemSound(systemSoundTap)
            HapticsManager.shared.impactVibrate()
            gameResult.currentScore += 10
            hud.scoreLabel.text = "Score: \(gameResult.currentScore)"
        } else {
            lives -= 1
        }
    }
    
    private func removeCoin(at node: SKNode) {
            guard let name = node.name else { return }
            if node.position.y == 100 {
                node.removeFromParent()
                if self.coinsToCollect.contains(name) {
                    self.lives -= 1
                }
            }
    }
    
    private func countLives() {
        switch lives {
            case 3:
                hud.lifeFirst.isHidden = false
                hud.lifeSecond.isHidden = false
                hud.lifeThird.isHidden = false
            case 2:
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                hud.lifeFirst.isHidden = false
                hud.lifeSecond.isHidden = false
                hud.lifeThird.isHidden = true
            case 1:
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                hud.lifeFirst.isHidden = false
                hud.lifeSecond.isHidden = true
                hud.lifeThird.isHidden = true
            default:
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                hud.lifeFirst.isHidden = true
                hud.lifeSecond.isHidden = true
                hud.lifeThird.isHidden = true
                gameResult.saveGameResults()
                
                let transition = SKTransition.crossFade(withDuration: 1.0)
                let gameOverScene = GameOverScene(size:  self.size)
                gameOverScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameOverScene, transition: transition)
        }
    }
        
}
