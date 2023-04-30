//
//  SelectedWordLines.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 30/04/2023.
//

import SwiftUI

struct SelectedWordLines: View {
    let currentPoint: CGPoint
    let points: [CGPoint]
    
    var body: some View {
        Path { path in
            path.move(to: points[0])
            
            points[1...].forEach { p in
                path.addLine(to: p)
            }
            path.addLine(to: currentPoint)
        }
        .stroke(GameColors.defaultGameColor, style: StrokeStyle(lineWidth: 10))
    }
}

struct SelectedWordLines_Previews: PreviewProvider {
    static var previews: some View {
        SelectedWordLines(currentPoint: .zero, points: [])
    }
}
