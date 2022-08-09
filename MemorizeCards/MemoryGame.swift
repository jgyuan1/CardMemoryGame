//
//  memoryGame.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/8/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set)var cards: Array<Card>
    // In order to keep in sync with info in cards
    // use computed value
    private var indexOfTheOnlyFaceUpCard: Int? {
        var indexesOfFaceUpCard: [Int] = []
        for cardIndex in cards.indices {
            if(cards[cardIndex].isFaceUp){
                indexesOfFaceUpCard.append(cardIndex)
            }
        }
        if indexesOfFaceUpCard.count == 1 {
            return indexesOfFaceUpCard.first
        } else {
            return nil
        }
    }
    
    init(numberOfPairsOfCards:Int, createContent: (Int) -> (CardContent)) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let content = createContent(index)
            cards.append(Card(content: content, id: 2*index))
            cards.append(Card(content: content, id: 2*index+1))
        }
    }
    
    mutating func chooseCard(card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchedIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                }
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
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
