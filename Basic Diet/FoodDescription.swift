//
//  DescriptionView.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import SwiftUI

struct FoodDescription: View {
    var foodProfile: FoodProfile
    
    var body: some View {
        List{
            Text(foodProfile.name)
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Text("Producers: \(self.foodProfile.producer)")
            
            Text("Calories: \(self.foodProfile.calories)")
            
            Text("Protein: \(self.foodProfile.protein)")
            
            Text("Fat: \(self.foodProfile.fat)")
            
            Text("Carbon Hydrate: \(self.foodProfile.carbonHydrate)")
            
            Text("Calcium: \(self.foodProfile.calcium)")
            
            Text("Iron: \(self.foodProfile.iron)")
            
            Text("Phosporus: \(self.foodProfile.phosphrous)")
            
        }
    }
}

struct FoodDescription_Previews: PreviewProvider {
    static var previews: some View {
        FoodDescription(foodProfile: FoodProfile.default)
    }
}
