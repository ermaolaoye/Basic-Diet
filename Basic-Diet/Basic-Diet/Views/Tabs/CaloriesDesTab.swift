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
                .frame(height: 200, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x:0.0, y: 9.0)
            VStack {
                HStack {    // Title
                    Text("Calories")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(basicColors.textColor)
                    Spacer()
                }.padding()
                VStack{
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
                    if food.type != nil {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(basicColors.healthyColor)
                                .padding(.horizontal)
                                .frame(height:15) // 根据user剩余卡路里改颜色<++>
                            
                            Text("About " + getComparisionFood(calories: Int(food.calories), type: correspondingType(type: food.type)))
                                .foregroundColor(basicColors.captionColor)
                        }.offset(y: 10)
                        
                    }
                }.offset(y: -15)
            }
            .frame(height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .offset(y:-12)
        }
        .padding(.horizontal)
        .padding(.vertical, 5.0)
    }
}

struct caloriesDesTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            caloriesDesTab(food: referenceFoods.chickenBreast)
        }
    }
}

func correspondingType(type: Int) -> FoodType{
    switch type{
    case 0:
        return FoodType.meat
    case 1:
        return FoodType.staple
    case 2:
        return FoodType.desert
    case 3:
        return FoodType.beverage
    default:
        return FoodType.meat
    }
}

func getComparisionFood(calories: Int, type: FoodType) -> String{
   /*
     Parameters:
     calories       Calories of the food that want to compare
     type           Type of the food input
    */
    var compareCalories: Int
    var compareUnit: String
    var foodName: String
    switch type {
    case FoodType.meat:
        compareCalories = Int(referenceFoods.chickenBreast.calories)
        compareUnit = "slice"
        foodName = referenceFoods.chickenBreast.foodNameCHN
    case FoodType.beverage:
        compareCalories = Int(referenceFoods.cola.calories)
        compareUnit = "cup"
        foodName = referenceFoods.cola.foodNameCHN
    case FoodType.desert:
        compareCalories = Int(referenceFoods.oreo.calories)
        compareUnit = "slice"
        foodName = referenceFoods.oreo.foodNameCHN
    case FoodType.staple:
        compareCalories = Int(referenceFoods.rice.calories)
        compareUnit = "bowl"
        foodName = referenceFoods.rice.foodNameCHN
    }
    return String(calories / compareCalories) + " " + compareUnit + " of " + foodName
}
