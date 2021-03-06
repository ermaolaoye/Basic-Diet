//
//  SwiftUIView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct FoodInfo: View {
    @ObservedObject var food = FoodModel(foodID: 1) // Food being displayed
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Presentation mode
    
    var body: some View {
        // Tabs
        ScrollView {
            foodPreviewTab(food: food.food)
                .padding(.top, 5.0)
            caloriesDesTab(food: food.food)
            NutritionTab(food: food.food)
                .offset(y:-10)
            NavigationLink(destination:FoodUpdateView(food: food.food)){
                Text("Update Food Information")
            }
        }
        // Custom navigation bar
        .navigationBarItems(leading: Button(action:{
            self.presentationMode.wrappedValue.dismiss() // Dismiss this view
        }){
            Image(systemName: "chevron.left") // Go back button
                .foregroundColor(basicColors.textColor)
        }, trailing: Button(action: {}){
            Image(systemName: "square.and.arrow.up") // Share button
                .foregroundColor(basicColors.textColor)
        })
        .navigationBarBackButtonHidden(true) // Hide the default navigation bar buttons
        .navigationTitle("Food Detail")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(StatusOverlayFood(model: food)) // Placeholder view for loading
        .onAppear{self.food.loadIfNeeded()} // Load food as the view showing up
        
    }
}

struct FoodInfo_Previews: PreviewProvider {
    static var previews: some View {
        FoodInfo(food: FoodModel(foodID: 1))
    }
}
