//
//  HapticManager.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/16.
//

import SwiftUI

class HapticManager {
    
    static let shared = HapticManager()
    private init() {
        
    }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred(intensity: intensity)
    }
}
