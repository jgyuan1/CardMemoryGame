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
    // var cards:Array<MemoryGame<String>.Card> { return viewModel.cards}
   
    var body: some View {
        VStack {
            gameBody
            shuffle
            
        }

            .padding(.horizontal)
        
//        ScrollView{
//            LazyVGrid(columns: [GridItem(.adaptive(minimum:100))]) {
//                ForEach(game.cards, content: {card in
//                    CardView(card)
//                        .aspectRatio(2/3, contentMode: .fit)
//                    //onTapGesture uses viewModel, which cannot be used in CardView
//                    //Users/chenglonghao/Development/swiftLearn/MemorizeCards/MemorizeCards/ContentView.swift:48:13: Instance member 'viewModel' of type 'ContentView' cannot be used on instance of nested type 'ContentView.CardView'
//                        .onTapGesture {
//                            game.chooseCard(card)
//                        }
//                })
//            }
//        }
        
    }
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio:2/3, content: { card in
            CardView(card).onTapGesture {
                withAnimation {
                    game.chooseCard(card)
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
//                    .modifier(RotationAnimationModifier(isMatched: card.isMatched))
//                    .font(font(in: geometry.size))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
            .animation(.easeInOut(duration: 1), value: card.isMatched)
            .animation(.easeInOut(duration: 1), value: card.isFaceUp)
            
//            .animation(Animation.easeInOut(duration: 5),value: card.isMatched)
            
//            ZStack {
//                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
//                if card.isFaceUp {
//                    //this line will return some view
//                    shape.fill().foregroundColor(.white)
//                    // need to call strokeBorder on shape
//                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
//                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90 ))
//                        .padding(5).opacity(0.5)
//                    Text(card.content)
//                        .font(font(in: geometry.size))
//                } else if card.isMatched {
//                    shape.opacity(0)
//                } else {
//                    shape.fill()
//                }
//            }
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
