//
//  CardView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

struct CardView: View {
    @StateObject private var cardVM = CardUserViewModel()

    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical) {
                ForEach(cardVM.userData){ item in
                    VStack(alignment: .leading, spacing: 16){
                        NavigationLink(destination: CardDetailView(cardVM: self.cardVM, item: item)) {
                            CardItemView(item: item)
                        }
                    }
                }
            }
        }
        .padding(.top, 16)
        .onAppear {
            self.cardVM.fetchUsers()
        }
    }
}