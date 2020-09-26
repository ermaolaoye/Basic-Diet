//
//  ContentView.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import SwiftUI

struct ContentView: View {
    @State var maxCalories: Int = 2000 //set max calories
    @State var currentCalories: Int = 0 //user calories
    
    var body: some View {
        VStack {
            ZStack{ //This means put all the content in a Z-direction stack view
                Circle() //This creates a circle
                    .fill(Color(red: 0.1, green: 1.0, blue: 0.7))
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Circle()
                    .fill(Color.white)
                    .padding(.all, 20)
                VStack{
                    Text(String(maxCalories-currentCalories))
                        .font(.largeTitle)
                    Text("Calories Left")
                        .font(.title)
                }
            }
            .padding(.all)
            .frame(width: 400.0, height: 500.0)
            
            
            Button(action:{self.currentCalories += 100}){Text("Add Record")}
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(Color.green)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .border(Color.green, width: 3)
                
        }
        .padding(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
