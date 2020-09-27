//
//  ContentView.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingDetail = false
    @State var user: User = User.init(maxCal: 2000)
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination:FoodList()){
                    Text("Food Menu")
                }
                ZStack{ //This means put all the content in a Z-direction stack view
                    Circle()
                        .fill(Color.green)
                        .frame(width: 400.0, height: 400.0) //This creates a circle
                    VStack{
                        Text(String(user.maxCalories-user.currentCalories))
                            .font(.largeTitle)
                        Text("Calories Left")
                            .font(.title)
                    }
                }
                
                Spacer()
    
                NavigationLink(destination:FoodListCal(isShowingDetail: $isShowingDetail, user: $user)) {
                    Text("Add Record")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .border(Color.green, width: 3)
                }
                
                Spacer()
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User.default)
    }
}
