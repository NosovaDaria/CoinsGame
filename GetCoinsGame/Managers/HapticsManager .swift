//
//  HapticsManager {.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 21.11.2023.
//

import UIKit

final class HapticsManager {
    private init() {}
    static let shared = HapticsManager()
    
    
    public func impactVibrate() {
        DispatchQueue.main.async {
            let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            impactFeedbackGenerator.prepare()
            impactFeedbackGenerator.impactOccurred()
        }
    }
}
