//
//  CardItemView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct CardItemView: View {

    let item: UserJsonModel

    var body: some View {
        HStack(alignment: .top, spacing: 16){
            if let profileImage = item.profile {
                AsyncImage(url: URL(string: profileImage)) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
            } else {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }

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
