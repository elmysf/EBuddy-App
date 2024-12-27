//
//  EBuddy_AppApp.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//

import SwiftUI

@main
struct EBuddy_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
