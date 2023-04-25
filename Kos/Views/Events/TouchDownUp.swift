//
//  TouchDownUp.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

//extension View {
//    /// A convenience method for applying `TouchDownUpEventModifier.`
//    func onTouchDownUp(pressed: @escaping ((Bool) -> Void)) -> some View {
//        self.modifier(TouchDownUpEventModifier(pressed: pressed))
//    }
//}
//
//struct TouchDownUpEventModifier: ViewModifier {
//    /// Keep track of the current dragging state. To avoid using `onChange`, we won't use `GestureState`
//    @State var dragged = false
//
//    /// A closure to call when the dragging state changes.
//    var pressed: (Bool) -> Void
//    func body(content: Content) -> some View {
//        content
//            .gesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { _ in
//                        if !dragged {
//                            dragged = true
//                            pressed(true)
//                        }
//                    }
//                    .onEnded { _ in
//                        dragged = false
//                        pressed(false)
//                    }
//            )
//    }
//}
