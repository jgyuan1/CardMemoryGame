//
//  AspectVGrid.swift
//  MemorizeCards
//
//  Created by CHENGLONG HAO on 8/9/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable{
    var items:[Item]
    var aspectRatio: CGFloat = 2/3
    var content:(Item) -> ItemView
    // @escaping: The compiler will let this closure live in heap and
// (Item) -> ItemView is a closure. which is a reference type. It will escape from the context.
// It is assigned to var content and content will hold on to it
// Whenever you have a function that you're passing that escapes, you should mark it as @escaping
    // two reasons to do so:
    // one: People who are calling your initializer here know that you are going to hold on to that function that I'm passing in to create a View, which they're going to always assume
    // two: The compiler needs to know this because if you're not going to hold on to this, if it's not going to escape then it could probably inline this function, just execute it right inline, it wouldn't have to go create memory for it.
   // because functions are types just like a struct is a type, classes are types, we know that structs and enums are value types, they don't live in the heap, they're just copied around. But we know classes are reference types. They have pointers to them in memory.
    // Well, closure's function types are reference types. They actually live in the heap and are pointed to.
    // content is a pointer that pointing to that (Item) -> ItemView closure function
    // So for the compiler to not create that memory and just inline this. It needs to know whether this is escaping
    
    
    //!!!init is actually a function, the closure (Item) -> ItemView wants to outlive init() and lets var content hold on to it.
    // so @escaping tells the compiler to let this closure live in the heap and escape the init() scope.
    
    //!!! if (Item) -> ItemView) contains if-elses or some view list, we should mark content as a ViewBuilder
    // @ViewBuilder will let the compiler use some mechanism to compile the things in {} as a view
    
//    init(items:[Item], aspectRatio:CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
//        self.items = items
//        self.aspectRatio = aspectRatio
//        self.content = content
//    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width = computedWidth(numberOfItems: items.count, ratio: aspectRatio, totalSize: geometry.size)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: width*CGFloat(0.95)))], content: {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                })
                Spacer()
            }
        }

    }
    
    private func computedWidth(numberOfItems: Int, ratio:CGFloat, totalSize: CGSize) -> CGFloat {
        var columnCount: Int = 1
        var rowCount: Int = numberOfItems
        var heightDemand: CGFloat
//        print("\(totalSize)")
//        print("numberOfItems" + "\(numberOfItems)")
        repeat{
            rowCount = Int(ceil( Double(numberOfItems)/Double(columnCount) ))
//            print("rowCount" + "\(rowCount)")
            heightDemand = totalSize.width*CGFloat(rowCount)/(CGFloat(columnCount)*aspectRatio)
            if heightDemand < totalSize.height {
//                print("column" + "\(columnCount)")
//                print("caculatedWidth" + "\(totalSize.width/CGFloat(columnCount))")
                return totalSize.width/CGFloat(columnCount)
            }
            columnCount += 1
        } while(true)
        
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
