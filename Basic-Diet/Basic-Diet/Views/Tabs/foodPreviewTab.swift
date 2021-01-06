//
//  foodPreviewTab.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct foodPreviewTab: View {
    var food: Food
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(basicColors.basicGradient)
                .frame(height: 110, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x:0.0, y: 9.0)
            
            HStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                    food.image
                        .resizable()
                        .padding()
                    
                }
                .frame(width: 90, height: 90)
                .offset(x:-10)
                VStack(alignment: .leading) {
                    Text(food.foodNameCHN)
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    HStack {
                        Circle()
                            .fill(basicColors.healthyGradient)
                            .frame(width: 20, height: 20, alignment: .center)
                        Text("Relatively Healthy")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(basicColors.healthyColor)
                            .multilineTextAlignment(.leading)
                    }
                }.frame(height: 55, alignment: .center)
                Spacer()

            }.padding()
        }.padding()
    }
}

struct foodPreviewTab_Previews: PreviewProvider {
    static var previews: some View {
        foodPreviewTab(food: Food.default)
            
    }
}
