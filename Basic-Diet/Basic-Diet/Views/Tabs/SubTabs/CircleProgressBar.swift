//
//  CircleProgressBar.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/5.
//

import SwiftUI
struct CircleProgressBar: View {
    @Binding var value: Float
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(basicColors.healthyColorLight)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.value, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(basicColors.healthyColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}
