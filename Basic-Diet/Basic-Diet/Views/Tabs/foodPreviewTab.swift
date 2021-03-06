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
            RoundedRectangle(cornerRadius: 10) // Background Rectangle
                .fill(basicColors.basicGradient)
                .frame(height: 110, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x:0.0, y: 9.0)
            
            HStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 10) // Picture Frame
                        .foregroundColor(.white)
                    foodImage(imageID: food.imageID).image
                        .resizable()
                        .padding()
                    
                }
                .frame(width: 90, height: 90)
                .offset(x:-10)
                VStack(alignment: .leading) { // Descriptions
                    Text(food.foodNameCHN) // Food Name
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    HStack { // Healthy Status Indicators
                        Circle() // Color Indicator
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
        }
        .padding(.horizontal)
        .padding(.vertical, 5.0)
    }
}

struct FoodPreviewTabSimple: View{
    var food: SearchFood
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 10) // Background Rectangle
                .fill(basicColors.basicGradient)
                .frame(height: 110, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x:0.0, y: 9.0)
            
            HStack{
                ZStack { // Food Image
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                    foodImage(imageID: food.imageID).image
                        .resizable()
                        .padding()
                    
                }
                .frame(width: 90, height: 90)
                .offset(x:-10)
                VStack(alignment: .leading) {
                    Text(food.foodNameCHN) // Food Name
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                        .multilineTextAlignment(.leading)
                }.frame(height: 55, alignment: .center)
                Spacer()

            }.padding()
        }
        .padding(.horizontal)
    }
}

struct foodPreviewTab_Previews: PreviewProvider {
    static var previews: some View {
        FoodPreviewTabSimple(food: SearchFood(foodNameCHN: "Test", id: 1, imageID: -1))
    }
}
