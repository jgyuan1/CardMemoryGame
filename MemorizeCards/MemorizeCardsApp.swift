//
//  MemorizeCardsApp.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/5/22.
//

import SwiftUI

@main
struct MemorizeCardsApp: App {
    private let game:EmojiMemoryGame = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
