//
//  CardView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

struct CardView: View {
    @EnvironmentObject private var cardVM: CardUserViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)

    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 8){
                    ForEach(cardVM.userData){ item in
                        NavigationLink(destination: CardDetailView(item: item)) {
                            CardItemView(item: item)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 16)
            }
        }
        .padding(.top, 16)
    }
}
