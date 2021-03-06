//
//  MainView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/5.
//

import SwiftUI

struct calPercentageCircleView: View{
    @Binding var userCaloriesLeft: Int
    @Binding var userCalPersent: Double
    var body: some View {
        ZStack{
            // Ring
            PercentageRing(ringWidth: 50, percent: Double(userCalPersent), backgroundColor: basicColors.basicGray, foregroundColors: [basicColors.healthyColor, basicColors.healthyColorLight])
                .padding()
                .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            // Text
            VStack{
                Text(String(userCaloriesLeft))
                    .font(.system(size:50.0))
                    .fontWeight(.medium)
                    .foregroundColor(basicColors.textColor)
                Text("Calories Left")
                    .font(.system(size: 25.0))
                    .fontWeight(.regular)
                    .foregroundColor(basicColors.textColor)
            }
        }
    }
}
