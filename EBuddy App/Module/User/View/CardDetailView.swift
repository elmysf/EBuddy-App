//
//  CardDetailView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct CardDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var cardVM: CardUserViewModel
    @State private var showImagePicker: Bool = false
    @State private var profileImage: UIImage?
    let item: UserJsonModel
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    if cardVM.loadingProgress > 0 && cardVM.loadingProgress < 1 {
                        ZStack() {
                            CircularProgressView(progress: cardVM.loadingProgress)
                                .frame(width:100, height: 100, alignment: .center)
                            Text("\(cardVM.loadingProgress * 100, specifier: "%.0f")")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.blue)
                        }
                    } else {
                        if let profileImage = item.profile {
                            AsyncImage(url: URL(string: profileImage)) { image in
                                image
                                    .resizable()
                                    .centerCropped()
                                    .frame(width:100, height: 100, alignment: .center)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image.imgDefault
                                    .resizable()
                                    .centerCropped()
                                    .frame(width:100, height: 100, alignment: .center)
                                    .clipShape(Circle())
                            }
                            .clipShape(Circle())
                        } else {
                            Image.imgUser
                                .resizable()
                                .frame(width:100, height: 100, alignment: .center)
                                .clipShape(Circle())
                        }
                        
                        Text("Set New Photo")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.blue)
                            .onTapGesture {
                                self.showImagePicker = true
                            }

                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Section() {
                    HStack() {
                        Text("Name:")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                        Spacer()
                        Text(item.name ?? "")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                    }
                    
                    HStack() {
                        Text("Gender:")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                        Spacer()
                        Text(item.genderInformation)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                    }
                    
                    HStack() {
                        Text("Email:")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                        Spacer()
                        Text(item.email)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                    }
                    
                    HStack() {
                        Text("Country:")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                        Spacer()
                        Text(item.country ?? "")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                    }
                    
                    if !item.phoneNumber.isEmpty {
                        HStack() {
                            Text("Phone Number:")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.mainShadowColor)
                            Spacer()
                            Text(item.phoneNumber)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.mainShadowColor)
                        }
                    }
                    
                    HStack() {
                        Text("UID:")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                        Spacer()
                        Text(item.uid)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                    }
                }
                
                Section() {
                    HStack {
                        Text("Version")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                        Spacer()
                        Text(cardVM.appVersion)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.mainShadowColor)
                    }
                    
                    Text(cardVM.copyrightInfo)
                        .foregroundColor(.mainShadowColor)
                        .font(.system(size: 14, weight: .regular))
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
        .alert(isPresented: $cardVM.showAlert) {
            Alert(
                title: Text(cardVM.alertTitle),
                message: Text(cardVM.alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if cardVM.alertTitle == "Success" {
                        presentationMode.wrappedValue.dismiss()
                    }
                })
            )
        }
        .onChange(of: profileImage) { uploadImage in
            if let image = uploadImage {
                self.cardVM.uploadImage(uid: item.uid, image: image)
            }
        }
    }
}
