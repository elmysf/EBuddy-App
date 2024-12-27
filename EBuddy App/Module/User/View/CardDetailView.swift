//
//  CardDetailView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject private var cardVM: CardUserViewModel
    @State private var showImagePicker: Bool = false
    @State private var profileImage: UIImage?
    let item: UserJsonModel
    
    var body: some View {
        VStack() {
            Spacer()
            VStack() {
                if let profileImage = item.profile {
                    AsyncImage(url: URL(string: profileImage)) { image in
                        image
                            .resizable()
                            .frame(width:100, height: 100, alignment: .center)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                } else {
                    Image.imgUser
                        .resizable()
                        .frame(width:100, height: 100, alignment: .center)
                        .clipShape(Circle())
                }
                Text(item.name ?? "")
                    .font(.title)
                    .foregroundStyle(Color.mainShadowColor)
                Text(item.email)
                    .font(.subheadline)
                    .foregroundColor(.tertiary)
                
                Button(action: {
                    self.showImagePicker = true
                }) {
                    Text("Upload Photo")
                        .frame(width: 50, height: 30)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .background(Color.blue)
                .cornerRadius(25)
                
                VStack(alignment: .leading, spacing: 8){
                    Text(item.uid)
                        .foregroundColor(.mainShadowColor)
                    Text(item.genderInformation)
                        .foregroundColor(.mainShadowColor)
                    Text(item.phoneNumber)
                        .foregroundColor(.mainShadowColor)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
        .onChange(of: profileImage) { uploadImage in
            if let image = uploadImage {
                self.cardVM.uploadImage(uid: item.uid, image: image)
            }
        }
    }
}
