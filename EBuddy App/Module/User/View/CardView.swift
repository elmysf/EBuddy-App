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
    @StateObject private var carouselVM = CarouselViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack() {
                Image.icFiltered
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                
                Menu {
                    Button(action: { cardVM.sortedBy = .lastActive }) {
                        Label("Last Active", systemImage: cardVM.sortedBy == .lastActive ? "checkmark" : "")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(cardVM.sortedBy == .lastActive ? .blue : .mainFontColor)
                    }
                    Button(action: { cardVM.sortedBy = .rating }) {
                        Label("Rating", systemImage: cardVM.sortedBy == .rating ? "checkmark" : "")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(cardVM.sortedBy == .rating ? .blue : .mainFontColor)
                    }
                    Button(action: { cardVM.sortedBy = .price }) {
                        Label("Price", systemImage: cardVM.sortedBy == .price ? "checkmark" : "")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(cardVM.sortedBy == .price ? .blue : .mainFontColor)
                    }
                } label: {
                    Text(cardVM.currentSortLabel)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.mainFontColor)
                }
                
                Toggle("", isOn: $cardVM.filterBy)
                    .toggleStyle(GenderToggleStyle())
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 16)
            
            ScrollView(.vertical) {
                
                CarouselView()
                    .frame(height: 190)
                    .environmentObject(carouselVM.stateModel)
                
                HStack(alignment: .center, spacing: 3) {
                    //foreach with your items (array of image) from viewmodel/API
                    ForEach(0..<4, id: \.self) { index in
                        if index == carouselVM.activeCard {
                            ProgressBar(value: self.carouselVM.progress)
                                .frame(width: 44, height: 8)
                                .onAppear{
                                    self.carouselVM.animateProgress()
                                }
                        }else{
                            Circle()
                                .frame(width: index == carouselVM.activeCard ? 8 : 7, height: index == carouselVM.activeCard ? 8 : 7)
                                .foregroundColor(index == carouselVM.activeCard ? .red : Color.gray.opacity(0.4))
                                .overlay(Circle().stroke(Color.clear, lineWidth: 1))
                        }
                        
                    }
                }
                LazyVGrid(columns: cardVM.columns, spacing: 8){
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
