//
//  ImageExt.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

extension Image {
    static let icVerified = Image("icVerified")
    static let icInstagram = Image("icInstagram")
    static let icLightning = Image("icLightning")
    static let icVoice = Image("icVoice")
    static let icStar = Image("icStar")
    static let imgCallOfDuty = Image("imgCallOfDuty")
    static let icMana = Image("icMana")
    static let imgMobileLegend = Image("imgMobileLegend")
    static let icOnline = Image("icOnline")
    static let imgBest = Image("imgBest")
    static let imgDiscord = Image("imgDiscord")
    static let imgNewUser = Image("imgNewUser")
    static let imgTelegram = Image("imgTelegram")
    static let imgDefault = Image("imgDefault")
    static let imgUser = Image("imgUser")
    static let imgYuno = Image("imgYuno")
    
    func centerCropped() -> some View {
         GeometryReader { geo in
             self
             .resizable()
             .scaledToFill()
             .frame(width: geo.size.width, height: geo.size.height)
             .clipped()
         }
     }

}

extension Color {
    static let mainFontColor = Color("fontColor")
    static let tertiaryColor = Color("tertiaryColor")
    static let mainBackgroundColor = Color("backgroundColor")
    static let mainShadowColor = Color("shadowColor")
}
