//
//  ProgressBar.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/30.
//

import SwiftUI

struct ProgressBar: View {
    var value: Float // The progress value
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background RoundedRect
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.white)
                // Progress Green Bar
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(basicColors.healthyColor)
                    .cornerRadius(45.0)
            }.cornerRadius(45.0)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.5).frame(height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
