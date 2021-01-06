//
//  SwiftUIView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct FoodInfo: View {
    var foodID: Int
    var body: some View {
        getFoodDescription(id: foodID, userCompletionHandler: { food, error in
            if let food = food{
                ScrollView {
                    foodPreviewTab(food: food)
                    caloriesDesTab(food: food)
                    NutritionTab(food: food)
                    RecipeTab(food: food)
                }
            }
        })
    }
}

struct FoodInfo_Previews: PreviewProvider {
    static var previews: some View {
        FoodInfo(foodID: 1)
    }
}
