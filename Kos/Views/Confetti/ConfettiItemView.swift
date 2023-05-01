//
//  ConfettiItemView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import SwiftUI

struct ConfettiItemView: View {
    let item: ConfettiItem
    let start: Bool
    let stop: Bool
    
    var body: some View {
        if !stop {
            Text(item.text)
                .font(.system(size: 40))
                .shadow(radius: 1)
                .position(CGPoint(x: item.posX, y: UIScreen.main.bounds.minY))
                .offset(y: start ? UIScreen.main.bounds.maxY : -100)
                .animation(
                    .linear(duration: 10)
                    .speed(item.speed())
                    .delay(item.delay())
                    .repeatForever(autoreverses: false),
                    value: start
                )
        }
    }
}

struct ConfettiItemView_Previews: PreviewProvider {
    static let midX: CGFloat = UIScreen.main.bounds.midX
    static let confetti: ConfettiItem = ConfettiItem(id: 1, posX: midX, text: "🥳")
    static var previews: some View {
        ConfettiItemView(item: confetti, start: true, stop: false)
    }
}
