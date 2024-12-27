//
//  FontExtension.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import Foundation
import SwiftUI

public struct FontExtension {
    public init () {}
}

extension Font {
    public struct Fonts {
        public static func styleFont(_ style: NameFonts, size: CGFloat) -> Font {
            return Font.custom(style.name, size: size)
        }
    }
}