//
//  FoodList.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

struct FoodList: View {
    @ObservedObject var foods = SearchFoodModel(searchContent: "1")
    var body: some View {
        List(foods.foods){ food in
            FoodPreviewTabSimple(food: food)
        }
        .overlay(StatusOverlaySearchFood(model: foods))
        .onAppear{self.foods.loadIfNeeded()}
        
    }
}

struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodList(foods: SearchFoodModel(searchContent: "馒头"))
    }
}
