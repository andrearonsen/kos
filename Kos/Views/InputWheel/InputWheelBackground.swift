//
//  InputWheel.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import SwiftUI

struct InputWheelBackground: View {
    var body: some View {
        Circle()
            .fill(GameColors.background)
            .opacity(0.8)
            .padding(InputWheel.padding)
    }
}

struct InputWheelBackground_Previews: PreviewProvider {
    static var previews: some View {
        InputWheelBackground()
    }
}
