//
//  Background.swift
//  8888
//
//  Created by Дарья Носова on 15.11.2023.
//

import UIKit
import SpriteKit

class Background: SKSpriteNode {
    static func populateBackground(at point: CGPoint, image: String) -> Background {
        
        let background = Background(imageNamed: image)
        background.position = point
        background.zPosition = 0
        
        return background
    }
}
