//
//  LevelDisplay.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import SwiftUI

struct LevelDisplay: View {
    let level: Int
    
    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
                .bold()
                .foregroundColor(.purple)
                .padding(.leading, 10)
            Text("\(level)")
                .bold()
                .foregroundColor(.purple)
                .font(.system(size: 20))
            Spacer()
        }
    }
}

struct LevelDisplay_Previews: PreviewProvider {
    static var previews: some View {
        LevelDisplay(level: 13)
    }
}
