//
//  CardDetailView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct CardDetailView: View {
    @ObservedObject var cardVM: CardUserViewModel
    @State private var showImagePicker: Bool = false
    @State private var profileImage: UIImage?
    let item: UserJsonModel

    var body: some View {
        VStack(alignment: .center, spacing: 16){

            if let profileImage = item.profile {
                AsyncImage(url: URL(string: profileImage)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
            } else {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading, spacing: 8){
                Text(item.uid)
                    .foregroundColor(.black)
                Text(item.genderInformation)
                    .foregroundColor(.black)
                Text(item.phoneNumber)
                    .foregroundColor(.black)
                Text(item.email)
                    .foregroundColor(.black)
            }
            Button(action: {
                self.showImagePicker = true
            }, label: {
                Text("Upload Profile Image")
            })
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
