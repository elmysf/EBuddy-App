//
//  CardListView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

struct CardListView: View {
    @StateObject private var cardVM = CardUserViewModel()

    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical) {
                ForEach(cardVM.userData){ item in
                    VStack(alignment: .leading, spacing: 16){
                        HStack(alignment: .top){
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                            VStack(alignment: .leading, spacing: 4){
                                Text(item.uid)
                                    .foregroundColor(.black)
                                Text(item.genderInformation)
                                    .foregroundColor(.black)
                                Text(item.phoneNumber)
                                    .foregroundColor(.black)
                                Text(item.email)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
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