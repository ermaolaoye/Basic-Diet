//
//  SwiftUIView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct FoodInfo: View {
    @ObservedObject var food = FoodModel(foodID: 1)
    var body: some View {
        ScrollView {
            foodPreviewTab(food: food.food)
            caloriesDesTab(food: food.food)
            NutritionTab(food: food.food)
        }
        .overlay(StatusOverlay(model: food))
        .onAppear{self.food.loadIfNeeded()}
    }
}

struct FoodInfo_Previews: PreviewProvider {
    static var previews: some View {
        FoodInfo(food: FoodModel(foodID: 4))
    }
}
