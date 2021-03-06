//
//  NutritionTab.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/30.
//

import SwiftUI

struct NutritionTab: View {
    var food: Food
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10) // Background rectangle
                .fill(basicColors.basicGradient)
                .frame(height: 250, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0, y: 9.0)
            VStack {
                HStack {
                    Text("Nutritions") // Title
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                    Spacer()
                }
                .padding()
                .offset(y:15)
                VStack { // Nutritions
                    NutritionProportionBar(nutritionName: "Protein", nutritionVal: food.protein, nutritionUnit: referenceFoods.unitMap["protein"]!)
                    NutritionProportionBar(nutritionName: "Carbohydrate", nutritionVal: food.carbohydrate, nutritionUnit: referenceFoods.unitMap["carbohydrate"]!)
                    NutritionProportionBar(nutritionName: "Fat", nutritionVal: food.fat, nutritionUnit: referenceFoods.unitMap["fat"]!)
                    NavigationLink(destination: NutritionDetailView(food: food)){
                        ZStack {
                            RoundedRectangle(cornerRadius: 10) // Background rectangle
                                .fill(basicColors.basicGradient)
                                .frame(width:100, height: 30, alignment: .center)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0, y: 9.0)
                            Text("More")
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                        }
                    }
                } // Change color by different healthy proportion<++>
                .padding()
                .offset(y: -20)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5.0)
    }
}

struct NutritionTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NutritionTab(food: referenceFoods.rice)
        }
    }
}
