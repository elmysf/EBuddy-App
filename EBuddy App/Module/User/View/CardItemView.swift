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
                    self.profileImageView
                    self.gameSectionView
                }
                
                if item.isVoiceAvailable {
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
                    .fill(self.item.isOnline ? Color.green : Color.clear)
                    .frame(width: 8, height: 8)
            }
            Spacer()
            
            if item.isVerified {
                Image.icVerified
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
            
            if item.isHaveInstagram {
                Image.icInstagram
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
        }
    }
    
    @ViewBuilder private var profileImageView: some View {
        if let profileImage = item.profile {
            AsyncImage(url: URL(string: profileImage)) { image in
                image
                    .resizable()
                    .centerCropped()
                    .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                    .cornerRadius(16)
                    .overlay(
                        ZStack{
                            HStack(spacing: 8) {
                                Image.icLightning
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                
                                Text("Available today!")
                                    .font(.Fonts.styleFont(.interLight, size: 12))
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
                        ,
                        alignment: .top)
            } placeholder: {
                ZStack{
                    Image.imgDefault
                        .resizable()
                        .centerCropped()
                        .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                        .cornerRadius(16)
                    
                    ProgressView()
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
    
    private var gameSectionView: some View {
        HStack(spacing: -10) {
            Image.imgCallOfDuty
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Image.imgMobileLegend
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .overlay(
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.5))
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        Text("+3")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .foregroundColor(Color.black)
                    }
                )
            
            Spacer()
        }
        .padding(.leading, 8)
        .offset(y: 28)
    }
    
    private var voiceSectionView: some View {
        ZStack {
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
                    .font(.Fonts.styleFont(.interBold, size: 14))
                    .foregroundColor(.mainFontColor)
                
                Text("(\(totalRating))")
                    .font(.Fonts.styleFont(.interLight, size: 14))
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
                    Text(self.item.priceNominal)
                        .font(.Fonts.styleFont(.interBold, size: 16))
                        .foregroundColor(.mainFontColor)
                    
                    Text(".\(self.item.priceDecimal)/1Hr")
                        .font(.Fonts.styleFont(.interLight, size: 12))
                        .foregroundColor(.mainFontColor)
                }
            }
        }
    }
}
