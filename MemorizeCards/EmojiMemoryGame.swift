//
//  EmojiMemoryGame.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/8/22.
//

import Foundation

class EmojiMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["π","π¦Ό","πΊ","π","π","π","π","π","π","π","π","π","π","π»","π","π","π","π","π","π","π","π","π²","π΅"]
    @Published private var model = MemoryGame<String> (numberOfPairsOfCards: 4) {index in emojis[index]}
    // WrongοΌ cards = model.cards
    // This is an initializer of class property, which uses an instance property "model" before 'self' is ready.
    // the steps of class initialization
    // step 1: initialize every property which has "=" !!! you cannot depend one property intializer on another property because you don't know the actual initialization order
    // step 2: all the other uninitialized properties needs to get its initial value when constructing a new class instance
    
    
    //use a computed var when it depends on some other properties
    
    var cards: Array<Card> {
        model.cards
    }
    // MARK: - Intent(s)
    func chooseCard(card: Card)  {
        model.chooseCard(card: card)
    }
    
}
