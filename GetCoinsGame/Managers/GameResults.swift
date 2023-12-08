//
//  GameResults.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 16.11.2023.
//

import UIKit

class GameResults: NSObject {
    let ud = UserDefaults.standard
    
    var highScore = [0]
    var currentScore = 0
    
    let scoreKey = "score"

    
    override init() {
        super.init()
        
        loadGameResults()
    }
    
    func saveGameResults() {
        highScore.append(currentScore)
            if highScore[1] < highScore[0] {
                highScore.removeLast()
            } else {
                highScore.removeFirst()
            }
        
            ud.set(highScore, forKey: scoreKey)
            ud.synchronize()
    }
    
    func loadGameResults() {
        guard ud.value(forKey: scoreKey) != nil else { return }
        
        highScore = ud.array(forKey: scoreKey) as! [Int]
    }
}
