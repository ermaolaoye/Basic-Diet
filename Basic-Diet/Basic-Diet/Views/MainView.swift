//
//  MainView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/5.
//

import SwiftUI

struct MainView: View {
    @State var user: User
    var body: some View {
        VStack {
            ZStack {
                PercentageRing(ringWidth: 50, percent: Double(user.calPercent), backgroundColor: basicColors.basicGray, foregroundColors: [basicColors.healthyColor, basicColors.healthyColorLight])
                    .padding(.all)
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                VStack {
                    Text(String(user.caloriesLeft!))
                        .font(.system(size: 50.0))
                        .fontWeight(.medium)
                        .foregroundColor(basicColors.textColor)
                    Text("Calories Left")
                        .font(.system(size: 25.0))
                        .fontWeight(.regular)
                        .foregroundColor(basicColors.textColor)
                }
            }
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: User(userGender: "Male", JWT: ""))
    }
}
