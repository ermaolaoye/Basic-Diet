//
//  SwiftUIView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct FoodInfo: View {
    @ObservedObject var food = FoodModel(foodID: 1)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            foodPreviewTab(food: food.food)
                .padding(.top, 5.0)
            caloriesDesTab(food: food.food)
            NutritionTab(food: food.food)
        }
        .navigationBarItems(leading: Button(action:{
            self.presentationMode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.left")
                .foregroundColor(basicColors.textColor)
        }, trailing: Button(action: {}){
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(basicColors.textColor)
        })
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Food Detail")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(StatusOverlayFood(model: food))
        .onAppear{self.food.loadIfNeeded()}
        
    }
}

struct FoodInfo_Previews: PreviewProvider {
    static var previews: some View {
        FoodInfo(food: FoodModel(foodID: 30))
    }
}
