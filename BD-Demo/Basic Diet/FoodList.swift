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
                NavigationLink(destination: FoodDescription(foodProfile: food)) {
                    FoodRow(food: food)
                }
            }.navigationTitle("Food Menu")
        }
    }
}


struct FoodListCal: View {
    @Binding var isShowingDetail: Bool
    @Binding var user: User
    
    var body: some View {
        NavigationView{
            List(foodData) { food in
                Button(action: {
                    user.currentCalories += food.calories
                }, label: {
                    FoodRow(food: food)
                })
                .contextMenu {
                    Button(action: {self.isShowingDetail.toggle()}){
                        Text("Show Detail")
                    }.sheet(isPresented: $isShowingDetail) {
                        FoodDescription(foodProfile: food)
                    }
                }
            }
            .navigationTitle("Select Food")
            
        }
    }
}
struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodListCal(isShowingDetail: ContentView().$isShowingDetail, user: ContentView().$user)
    }
}
