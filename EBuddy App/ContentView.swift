//
//  ContentView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cardVM = CardUserViewModel()
    var body: some View {
        NavigationView {
            CardView()
                .navigationTitle("E-Buddy")
        }
        .environmentObject(self.cardVM)
        .onAppear  {
            self.cardVM.fetchUsers()
        }
    }
}
