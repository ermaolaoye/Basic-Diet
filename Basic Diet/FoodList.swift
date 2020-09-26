//
//  FoodList.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import SwiftUI

struct FoodList: View {
    var body: some View {
        NavigationView{
            List(foodData) { food in
                NavigationLink(destination: FoodDescription(foodProfile: food)){
                    FoodRow(food: food)
                }
            }
        }
    }
}

struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodList()
    }
}
