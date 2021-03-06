//
//  FoodList.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

struct FoodList: View {
    @ObservedObject var foods: SearchFoodModel
    var body: some View {
        ScrollView {
            ForEach(foods.foods){ food in
                // Destination FoodInfo View
                    NavigationLink(destination: FoodInfo(food: FoodModel(foodID: food.id))){
                        FoodPreviewTabSimple(food: food) // Each Food's preview tab
                            
                    }
                }
                .overlay(StatusOverlaySearchFood(model: foods)) // Overlay views
                .onAppear{
                    self.foods.loadIfNeeded() // Load the content
                    
                }
        }
        
        
    }
}

struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodList(foods: SearchFoodModel(searchContent: "面条"))
    }
}
