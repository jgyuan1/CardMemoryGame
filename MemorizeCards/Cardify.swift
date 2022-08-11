//
//  Cardify.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/10/22.
//

import Foundation
import SwiftUI
// Text("👻").modifier(Cardify(isFaceUp: true))

// Text("👻").cardify(isFaceUp: true)
// add the following extention, you will simplify the usage

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched ))
    }
}

//protocol ViewModifier {
//typealias Content
//func body(content: Content) -> some View {
//    return some View that almost certainly contains the View content
//}
//}
struct Cardify: AnimatableModifier {
    // AnimatableModifier is an Animatable and a ViewModifier at the same time
    var isFaceUp: Bool
    var isMatched: Bool
    
    var rotation: Double// in degrees
    
    
    // Double/ CGFloat/ ...Pair can be animatableData
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, isMatched: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if rotation < 90 {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).strokeBorder(lineWidth: DrawingConstants.lineWidth, antialiased: true)
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
            content.opacity(rotation < 90 ? 1 : 0)
                
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
        // want isFaceUp from false to true
       
//        .animation(.linear(duration: 3), value: isHide)

        
    }
}

