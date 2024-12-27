//
//  NameFonts.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import SwiftUI

public struct NameFonts {
    public let name: String
    
    private init(named name: String) {
        self.name = name
        do {
            try registerFont(named: name)
        } catch {
            let reason = error.localizedDescription
            fatalError("Failed to register font: \(reason)")
        }
    }
    
    public static let interBold  = NameFonts(named: "Inter-Bold")
    public static let interLight = NameFonts(named: "Inter-Light")
    public static let helvetica  = NameFonts(named: "HelveticaNeue")
}
