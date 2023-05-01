//
//  SelectedWordDisplay.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import SwiftUI

struct SelectedWordDisplay: View {
    let selectedWord: String
    
    var body: some View {
        Text(selectedWord)
            .bold()
            .foregroundColor(GameColors.foreground)
            .font(.system(size: 30))
            .background(
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .fill(GameColors.defaultGameColor)
            )
            .frame(height: 30, alignment: .center)
    }
}

struct SelectedWordDisplay_Previews: PreviewProvider {
    static var previews: some View {
        SelectedWordDisplay(selectedWord: "SØLV")
    }
}
