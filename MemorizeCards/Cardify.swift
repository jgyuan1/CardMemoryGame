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
    func cardify(isFaceUp: Bool, isHide: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, isHide: isHide ))
    }
}

//protocol ViewModifier {
//typealias Content
//func body(content: Content) -> some View {
//    return some View that almost certainly contains the View content
//}
//}
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var isHide: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                content
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
        }.opacity(isHide ? 0 : 1)
    }
}
