//
//  wiggle.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 03/05/2023.
//

import Foundation
import SwiftUI

extension View {
    func wiggling(shouldWiggle: Bool) -> some View {
        modifier(WiggleModifier(shouldWiggle: shouldWiggle))
    }
}

struct WiggleModifier: ViewModifier {
    let shouldWiggle: Bool
    
    @State private var wiggleValue: Double = 0.0
    
    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    private let rotateAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 0.14,
                withVariance: 0.025
            )
        )
        .repeatForever(autoreverses: true)
        //.repeatCount(5, autoreverses: true)
    
    private let bounceAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 0.18,
                withVariance: 0.025
            )
        )
        //.repeatCount(5, autoreverses: true)
       .repeatForever(autoreverses: true)
    
    func body(content: Content) -> some View {
        if shouldWiggle {
            content
                .rotationEffect(.degrees(wiggleValue))
                .animation(rotateAnimation, value: wiggleValue)
                .offset(x: 0, y: wiggleValue)
                .animation(bounceAnimation, value: wiggleValue)
                .onAppear() {
                    if wiggleValue == 0.0 {
                        wiggleValue = 2.0
                    } else {
                        wiggleValue = 0.0
                    }
                        
                }
        } else {
            content
        }
    }
}
