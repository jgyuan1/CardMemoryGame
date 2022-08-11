//
//  RotationAnimationModifier.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/10/22.
//

import Foundation
import SwiftUI

struct RotationAnimationModifier: ViewModifier {
    var isMatched: Bool
    
    func body(content: Content) -> some View {
        withAnimation {
            content.rotationEffect(Angle.degrees(isMatched ? 360 : 0))
        }
    }
}
