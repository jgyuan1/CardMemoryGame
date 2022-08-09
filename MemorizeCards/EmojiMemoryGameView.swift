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
    // computed property will not be initialized before "self"
//    var cards:Array<MemoryGame<String>.Card> { return viewModel.cards}
   
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum:100))]) {
                ForEach(game.cards, content: {card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                    //onTapGesture uses viewModel, which cannot be used in CardView
                    //Users/chenglonghao/Development/swiftLearn/MemorizeCards/MemorizeCards/ContentView.swift:48:13: Instance member 'viewModel' of type 'ContentView' cannot be used on instance of nested type 'ContentView.CardView'
                        .onTapGesture {
                            game.chooseCard(card)
                        }
                })
            }
        }
        .foregroundColor(.red).padding(.horizontal)
    }
}
//nested type ContentView.CardView?????????????check docs

struct CardView: View {
    var card: EmojiMemoryGame.Card
    
    init(_ givenCard: EmojiMemoryGame.Card) {
        card = givenCard
        //or, if you want to match the name perfect, you can use self.card = card 
    }
                
    var body: some View {
        GeometryReader {
            geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    //this line will return some view
                    shape.fill().foregroundColor(.white)
                    // need to call strokeBorder on shape
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
        
    }
    
    private func font(in size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game:EmojiMemoryGame = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
