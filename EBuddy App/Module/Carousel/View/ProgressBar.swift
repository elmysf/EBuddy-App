//
//  ProgressBar.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    init(value: Float) {
        self.value = value
    }
    
    var value: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.2)
                    .foregroundColor(.gray)
                  
                ZStack(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 45)
                        .fill(Color.blue)
                        .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                }
            }
            .cornerRadius(45.0)
        }
    }
}
