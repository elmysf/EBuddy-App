//
//  ContentView.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CardListView()
                .navigationTitle("E-Buddy")
        }
    }
}
