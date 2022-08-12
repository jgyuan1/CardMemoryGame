//
//  ContentView.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/5/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // swift is strong type language
    // infer the actual type for you
    // Array<String> or [String]
    
    @ObservedObject var game: EmojiMemoryGame
    @State var dealt: [Int] = []
    

    
    func isUndealt(_ card:EmojiMemoryGame.Card) -> Bool {
        for index in dealt {
            if card.id == index {
                return false
            }
        }
        return true
    }
    
    func dealAllCards() {
        for card in game.cards {
            dealt.append(card.id)
        }
    }
    // computed property will not be initialized before "self"
    // var cards:Array<MemoryGame<String>.Card> { return viewModel.cards}
   
    var body: some View {
        VStack {
            gameBody
            deckBody
            HStack {
                shuffle
                Spacer()
                restart
            }

        }
        .padding(.horizontal)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio:2/3, content: { card in
            //Color.clear can
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card)
                    .transition(AnyTransition.scale.animation(Animation.easeInOut(duration: 2)))
                    .onTapGesture {
                        withAnimation {
                            game.chooseCard(card)
                        }
                    }
            }
        })
            .foregroundColor(.red)
    }
    
    var shuffle: some View {
        Button("shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    var restart: some View {
        Button("restart") {
            withAnimation {
                game.restart()
                dealt = []
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            // ForEach() items should be identifiable and have ids
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card)
            }
        }.onTapGesture {
            dealAllCards()
        }
        .frame(width: 60, height: 90)
        .foregroundColor(.red)
    }
}



struct CardView: View {
    var card: EmojiMemoryGame.Card
    
    init(_ givenCard: EmojiMemoryGame.Card) {
        card = givenCard
        //or, if you want to match the name perfect, you can use self.card = card 
    }
                
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90 ))
                                        .padding(5).opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) * DrawingConstants.fontScale/DrawingConstants.fontSize
    }
    
    private func font(in size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.8
        static let fontSize: CGFloat = 32
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game:EmojiMemoryGame = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
