//
//  InputWheel.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import SwiftUI

struct InputWheelBackground: View {
    var body: some View {
        GeometryReader { geometry in
//            let height = geometry.size.height * 0.4
            //let paddingSide = geometry.size.width * 0.2
            Circle()
                .fill(Color.gray.opacity(0.5))
                //.padding([.leading, .trailing], paddingSide)
                //.frame(height: height)
                //.position(x: geometry.size.width / 2, y: geometry.size.height - height / 2)
        }
       
    }
}

struct InputWheelBackground_Previews: PreviewProvider {
    static var previews: some View {
        InputWheelBackground()
    }
}
