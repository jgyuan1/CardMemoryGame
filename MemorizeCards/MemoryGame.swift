//
//  memoryGame.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/8/22.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set)var cards: Array<Card>
    // In order to keep in sync with info in cards
    // use computed value
    private var indexOfTheOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter({cards[$0].isFaceUp}).oneAndTheOnlyOne
        }
        set {
            cards.indices.forEach({cards[$0].isFaceUp = false})
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards:Int, createContent: (Int) -> (CardContent)) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let content = createContent(index)
            cards.append(Card(content: content, id: 2*index))
            cards.append(Card(content: content, id: 2*index+1))
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchedIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                }
            } else {
//                for index in cards.indices {
//                    cards[index].isFaceUp = false
//                }
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    struct Card:  Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content:CardContent
        let id:Int
    }
}

extension Array {
    var oneAndTheOnlyOne:Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
