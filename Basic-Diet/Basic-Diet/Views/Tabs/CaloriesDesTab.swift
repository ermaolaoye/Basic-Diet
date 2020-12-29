//
//  caloriesDesTab.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct caloriesDesTab: View {
    var food: Food
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(basicColors.basicGradient)
                .frame(height: 250, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0, y: 9.0)
            VStack {
                HStack {    // Title
                    Text("Calories")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                    Spacer()
                }.padding()
                HStack {
                    Text(String(food.calories))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("Kcal")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                .foregroundColor(basicColors.textColor)
                Text("Per 100g (edible proportion)")
                    .font(.body)
                    .foregroundColor(basicColors.captionColor)
                Spacer()
                if let type = food.type {
                    VStack {
                        ZStack {
                            HStack {
                                VStack {
                                    Text("Low")
                                        .font(.callout)
                                        .foregroundColor(basicColors.captionColor)
                                        .offset(y: 5)
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width:110, height:10)
                                        .foregroundColor(basicColors.healthyColorLight)
                                }
                                VStack {
                                    Text("Medium")
                                        .font(.callout)
                                        .foregroundColor(basicColors.captionColor)
                                        .offset(y: 5)
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 110, height: 10)
                                        .foregroundColor(basicColors.healthyColor)
                                }
                                VStack {
                                    Text("High")
                                        .font(.callout)
                                        .foregroundColor(basicColors.captionColor)
                                        .offset(y: 5)
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 110, height: 10)
                                        .foregroundColor(basicColors.healthyColorStrong)
                                }
                            }
                            Circle()
                                .strokeBorder(basicColors.healthyColor, lineWidth: 4.0)
                                .background(Circle().foregroundColor(.white))
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .offset(x: -170 + (340/30), y:15)
                        }
                        Text("About " + getComparisionFood(calories: food.calories, type: food.type!))
                            .foregroundColor(basicColors.captionColor)
                    }
                    
                }
            }
            .frame(height: 230, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .offset(y:-12)
        }
        .padding()
    }
}

struct caloriesDesTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            caloriesDesTab(food: Food.default)
        }
    }
}

func getComparisionFood(calories: Int, type: FoodType) -> String{
    var compareCalories: Int
    var compareUnit: String
    var foodName: String
    switch type {
    case FoodType.meat:
        compareCalories = referenceFoods.chickenBreast.calories
        compareUnit = "slice"
        foodName = referenceFoods.chickenBreast.foodNameCHN
    case FoodType.beverage:
        compareCalories = referenceFoods.cola.calories
        compareUnit = "cup"
        foodName = referenceFoods.cola.foodNameCHN
    case FoodType.desert:
        compareCalories = referenceFoods.oreo.calories
        compareUnit = "slice"
        foodName = referenceFoods.oreo.foodNameCHN
    case FoodType.staple:
        compareCalories = referenceFoods.rice.calories
        compareUnit = "bowl"
        foodName = referenceFoods.rice.foodNameCHN
    }
    return String(calories / compareCalories) + " " + compareUnit + " of " + foodName
}
