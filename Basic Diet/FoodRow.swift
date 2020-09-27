//
//  FoodRow.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import SwiftUI

struct FoodRow: View {
    var food: FoodProfile
        
    var body: some View {
        HStack {
            Text(food.name)
            
            Spacer()
            
            Text(String(food.calories))
        
            
        }.padding()
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(food: FoodProfile.default)
    }
}
