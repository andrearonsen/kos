//
//  InputWheel.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import SwiftUI

struct InputWheel: View {
    var image: Image
    var body: some View {
        image
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        .overlay {
            Circle().stroke(.white, lineWidth: 4)
        }
        .shadow(radius: 7)
        .frame(width: 100, height: 100)
    }
}

struct InputWheel_Previews: PreviewProvider {
    static var previews: some View {
        InputWheel(image: Image("CatCircle"))
    }
}
