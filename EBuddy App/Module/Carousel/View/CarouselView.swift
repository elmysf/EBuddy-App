//
//  CarouselView.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

struct CarouselView: View {
    @ObservedObject var carouselVM: CarouselViewModel
    
    var body: some View {
        let spacing: CGFloat = 8
        let widthOfHiddenCards: CGFloat = 8
        let cardHeight: CGFloat = 180
        
        // if u test for local
//        let items = [
//            CarouselItemModel(id: 0, name: "1. description.", image: Image.imgBest),
//            CarouselItemModel(id: 1, name: "2. description.", image: Image.imgNewUser),
//            CarouselItemModel(id: 2, name: "3. description.", image: Image.imgDiscord),
//            CarouselItemModel(id: 3, name: "4. description", image: Image.imgTelegram),
//        ]
        
        return Canvas {
            Carousel(
                numberOfItems: CGFloat(carouselVM.slidersData.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach(carouselVM.slidersData, id: \.self.id) { item in
                    Item(
                        _id: item.id,
                        spacing: spacing,
                        widthOfHiddenCards: widthOfHiddenCards,
                        cardHeight: cardHeight
                    ) {
                        VStack {
                            AsyncImage(url: URL(string: item.image)) { image in
                                image
                                    .image?.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .cornerRadius(8)
                    .transition(AnyTransition.slide)
                }
            }
        }
    }
}
