//
//  Extension.swift
//  GetCoinsGame
//
//  Created by Дарья Носова on 22.11.2023.
//

import UIKit
import SpriteKit

enum UIUserInterfaceIdiom: Int {
    case undefined
    case phone
    case pad
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    
    static let isiPhoneSmallSize = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength <= 667.0
    static let isiPhoneMidSize = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength >= 736.0 && ScreenSize.maxLength <  844.0
    static let isiPhoneBigSize = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength >= 844.0 && ScreenSize.maxLength <= 932
    static let isiPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength >= 1024.0

}

public extension CGFloat {
    static func universalFont(size: CGFloat) -> CGFloat {
        if DeviceType.isiPad {
            return size * 1.6
        } else {
            return size * 1.0
        }
    }
}

extension CGPoint {
    static func universalCenterBackground(size: CGSize) -> CGPoint {
        if DeviceType.isiPad {
            return CGPoint(x: size.width / 2, y: size.height / 4.2)
        }
        if DeviceType.isiPhoneSmallSize {
            return CGPoint(x: size.width / 2, y: size.height / 2.4)
        } else {
            return CGPoint(x: size.width / 2, y: size.height / 2)
        }
    }
    
    static func universalLifePosition(x: Double, y: Double, size: Double, index: Int) -> CGPoint {
        if DeviceType.isiPad {
            return CGPoint(x: (x - CGFloat(index + 1) * (size + 25)), y: y)
        } else {
            return CGPoint(x: (x - CGFloat(index + 1) * size + 15), y: y)
        }
    }
}

extension CGSize {
    static func universalBackground(size: CGSize) -> CGSize {
        if DeviceType.isiPhoneSmallSize {
            return CGSize(width: size.width, height: size.height + 120)
        }
        
        if DeviceType.isiPhoneMidSize {
            return CGSize(width: size.width, height: size.height)
        }
        
        if DeviceType.isiPhoneBigSize {
            return CGSize(width: size.width, height: size.height)
        }
        
        if DeviceType.isiPad {
            return CGSize(width: size.width, height: size.height + 800)
        } else {
            return CGSize(width: size.width, height: size.height)
        }
    }
}


extension SKSpriteNode {
    func scaleTo(screenWidthPercentage: CGFloat) {
        let aspectRatio = self.size.height / self.size.width
        
        if ScreenSize.maxLength > 1000 {
            self.size.width = ScreenSize.width * screenWidthPercentage / 1.5
        } else {
            self.size.width = ScreenSize.width * screenWidthPercentage
        }
        
        self.size.height = self.size.width * aspectRatio
    }
}
