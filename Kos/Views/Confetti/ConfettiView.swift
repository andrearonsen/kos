//
//  ConfettiView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import SwiftUI

struct ConfettiView: View {
//    let confetti: [ConfettiItem] = createConfetti(level: 2)
    
    @Binding var start: Bool
    @Binding var stop: Bool
    let level: Int
    
    var body: some View {
        ForEach(createConfetti(level: level)) { cf in
            ConfettiItemView(item: cf, start: $start, stop: $stop)
        }
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView(start: .constant(false), stop: .constant(false), level: 1)
    }
}
