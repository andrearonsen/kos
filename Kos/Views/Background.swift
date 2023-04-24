//
//  Background.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import SwiftUI

struct Background: View {
    var image: Image
    
    var body: some View {
        GeometryReader { geometry in
            image
                .scaledToFit()
                .edgesIgnoringSafeArea(.top)
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background(image: Image("Pikachu"))
    }
}
