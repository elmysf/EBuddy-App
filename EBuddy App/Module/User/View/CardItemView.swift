//
//  CardItemView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct CardItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    let item: UserJsonModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            self.headerView
            
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .bottomLeading){
                    self.cardImageView
                    self.gameSectionView
                }
                
                if item.isVoiceAvailable ?? false {
                    self.voiceSectionView
                }
            }
            .padding(.bottom, 24)
            
            VStack(alignment: .leading,  spacing: 8) {
                self.ratingView
                self.manaView
            }
            .padding(.top, 8)
        }
        .padding(.all, 8)
        .background(Color.mainBackgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.mainShadowColor.opacity(0.3), radius: 2)
    }
}


extension CardItemView {
    private var headerView: some View {
        HStack {
            HStack(spacing: 8){
                Text(self.item.name ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.mainFontColor)
                Circle()
                    .fill(self.item.isOnline ?? false ? Color.green : Color.clear)
                    .frame(width: 8, height: 8)
            }
            Spacer()
            
            if item.isVerified ?? false {
                Image.icVerified
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
            
            if let haveInstagram = item.isHaveInstagram, !haveInstagram.isEmpty {
                Image.icInstagram
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
        }
    }
    
    @ViewBuilder private var cardImageView: some View {
        if let profileImage = item.profile {
            AsyncImage(url: URL(string: profileImage)) { image in
                image
                    .resizable()
                    .centerCropped()
                    .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                    .cornerRadius(16)
                    .overlay(
                        ZStack() {
                            if item.isAVailable ?? false {
                                HStack(spacing: 8) {
                                    Image.icLightning
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                    
                                    Text("Available today!")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.top, 8)
                            }
                        },alignment: .top)
            } placeholder: {
                ZStack() {
                    Image.imgDefault
                        .resizable()
                        .centerCropped()
                        .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                        .cornerRadius(16)
                }
            }
        } else {
            Image.imgDefault
                .resizable()
                .centerCropped()
                .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                .cornerRadius(16)
        }
    }
    
    @ViewBuilder private var gameSectionView: some View {
        HStack(spacing: -10) {
            ForEach(0..<(item.gemes?.count ?? 0), id: \.self) { index in
                AsyncImage(url: URL(string: item.gemes?[index] ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                        .overlay(
                            ZStack {
                                if (item.gemes?.count ?? 0) > 2 {
                                    Circle()
                                        .fill(Color.white.opacity(0.5))
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 1)
                                        )
                                    Text("+\(item.gemes?.count ?? 0 - 2)")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                }
                            })
                } placeholder: {
                    Image.imgDefault
                        .resizable()
                        .centerCropped()
                        .frame(width: 36, height: 36)
                        .cornerRadius(16)
                }
            }
            Spacer()
        }
        .padding(.leading, 8)
        .offset(y: 28)
    }
    
    private var voiceSectionView: some View {
        ZStack() {
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.purple, .pink, .orange]), startPoint: .bottomLeading, endPoint: .topTrailing)
                )
                .frame(width: 36, height: 36)
            
            Image.icVoice
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.white)
                .frame(width: 18, height: 18)
        }
        .padding(.trailing, 8)
        .offset(y: 18)
    }
    
    @ViewBuilder private var ratingView: some View {
        if let rating = item.rating, let totalRating = item.totalRating {
            HStack {
                Image.icStar
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                Text(String(format: "%.2f", rating))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.mainFontColor)
                
                Text("(\(totalRating))")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.tertiaryColor)
            }
        }
    }
    
    @ViewBuilder private var manaView: some View {
        if self.item.price != nil {
            HStack {
                Image.icMana
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(self.item.priceNominal)/1Hr")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.mainFontColor)
                }
            }
        }
    }
}
