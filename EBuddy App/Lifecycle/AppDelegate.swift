//
//  AppDelegate.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let services: [UIApplicationDelegate] = [
        FirebaseService()
    ]
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        for service in services {
            _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
}