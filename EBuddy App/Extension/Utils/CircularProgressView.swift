//
//  CircularProgressView.swift
//  EBuddy App
//
//  Created by Elmo on 29/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 10
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}