//
//  ConfettiView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import SwiftUI

struct ConfettiView: View {
    let confetti: [ConfettiItem] = createConfetti()
    
    @Binding var start: Bool
    @Binding var stop: Bool
    
    var body: some View {
        ForEach(confetti) { cf in
            ConfettiItemView(item: cf, start: $start, stop: $stop)
        }
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView(start: .constant(false), stop: .constant(false))
    }
}
