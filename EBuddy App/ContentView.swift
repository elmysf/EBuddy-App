//
//  ContentView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var cardVM = CardUserViewModel()
    var body: some View {
        NavigationView {
            CardView()
                .navigationTitle("E-Buddy")
                .toolbar {
                    HStack(spacing: 8) {
                        Button(action: {
                            isDarkMode.toggle()
                        }) {
                            Image(systemName: isDarkMode ? "moon.fill" : "moon")
                                .foregroundColor(Color.mainFontColor)
                        }
                    }
                }
        }
        .environmentObject(self.cardVM)
        .onAppear  {
            self.cardVM.fetchUsers()
        }
    }
}
