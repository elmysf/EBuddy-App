//
//  FirebaseService.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import UIKit
import Foundation
import FirebaseCore

class FirebaseService: NSObject{}

extension FirebaseService: UIApplicationDelegate {
    
    static let shared = FirebaseService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEV
        guard let filePath = Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist") else { return false }
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseConfiguration.shared.setLoggerLevel(.error)
        FirebaseApp.configure(options: options!)
        #else
        guard let filePath = Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist")  else { return false }
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure(options: options!)
        #endif
        return true
    }
}