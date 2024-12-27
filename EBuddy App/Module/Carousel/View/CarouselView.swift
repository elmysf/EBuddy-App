//
//  CarouselView.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

struct CarouselView: View {
    
    var body: some View {
        let spacing: CGFloat = 8
        let widthOfHiddenCards: CGFloat = 8
        let cardHeight: CGFloat = 180
        
        let items = [
            CarouselItemModel(id: 0, name: "1. description.", image: Image.imgBest),
            CarouselItemModel(id: 1, name: "2. description.", image: Image.imgNewUser),
            CarouselItemModel(id: 2, name: "3. description.", image: Image.imgDiscord),
            CarouselItemModel(id: 3, name: "4. description", image: Image.imgTelegram),
        ]
        
        return Canvas {
            Carousel(
                numberOfItems: CGFloat(items.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach(items, id: \.self.id) { item in
                    Item(
                        _id: Int(item.id),
                        spacing: spacing,
                        widthOfHiddenCards: widthOfHiddenCards,
                        cardHeight: cardHeight
                    ) {
                        VStack {
                            item.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .cornerRadius(8)
                    .transition(AnyTransition.slide)
                }
            }
        }
    }
}
