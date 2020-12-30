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
            RoundedRectangle(cornerRadius: 10)
                .fill(basicColors.basicGradient)
                .frame(height: 250, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0, y: 9.0)
            VStack {
                HStack {
                    Text("Nutritions")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                    Spacer()
                }.padding()
                VStack { // Nutritions
                    VStack { // Protein
                        HStack {
                            Text("Protein")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                                
                            Spacer()
                            Text(String(food.protein!) + food.unitMap!["protein"]!)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                        }
                        ProgressBar(value: Float(getProportion(nutrition: food.protein!, unit: food.unitMap!["protein"]!))).frame(height: 15)
                    }
                    VStack {
                        HStack { // Carbohydrate
                            Text("Carbohydrate")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                                
                            Spacer()
                            Text(String(food.carbohydrate!) + food.unitMap!["carbohydrate"]!)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                        }
                        ProgressBar(value: Float(getProportion(nutrition: food.carbohydrate!, unit: food.unitMap!["carbohydrate"]!))).frame(height: 15)
                    }
                    VStack {
                        HStack {
                            Text("Fat")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                            Spacer()
                            Text(String(food.fat!) + food.unitMap!["fat"]!)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(basicColors.textColor)
                        }
                        ProgressBar(value: Float(getProportion(nutrition: food.fat!, unit: food.unitMap!["fat"]!))).frame(height: 15)
                    }
                }
                .padding()
                .offset(y: -30)
            }
        }.padding()
    }
}

struct NutritionTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NutritionTab(food: referenceFoods.chickenBreast)
        }
    }
}

func getProportion(nutrition: Float, unit: String) -> CGFloat{
    switch unit{
        case "g":
            return CGFloat(nutrition / 100)
        case "mg":
            return CGFloat(nutrition / 1000 / 100)
        case "mcg":
            return CGFloat(nutrition / 1000000 / 100)
        default:
            return CGFloat()
    }
}
