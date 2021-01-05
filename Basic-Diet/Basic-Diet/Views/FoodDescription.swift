//
//  SwiftUIView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct FoodInfo: View {
    var food: Food
    var body: some View {
        ScrollView {
            foodPreviewTab(food: food)
            caloriesDesTab(food: food)
            NutritionTab(food: food)
            RecipeTab(food: food)
        }
    }
}

struct FoodInfo_Previews: PreviewProvider {
    static var previews: some View {
        FoodInfo(food: referenceFoods.chickenRice)
    }
}
