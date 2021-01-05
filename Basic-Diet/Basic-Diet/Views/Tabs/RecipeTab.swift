//
//  RecipeTab.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/30.
//

import SwiftUI

struct RecipeTab: View {
    var food: Food
    var body: some View {
        if let ingredient = food.ingredients{
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(basicColors.basicGradient)
                    .frame(height: 200, alignment: .center)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0, y: 9.0)
                VStack {
                    HStack {    // Title
                        Text("Recipe")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundColor(basicColors.textColor)
                        Spacer()
                    }.padding()
                    VStack {
                        HStack {
                            Text(ingredient[0].key)
                                .font(.title)
                                
                            Spacer()
                            Text(ingredient[0].value)
                                .font(.title)
                                
                                
                        }
                        HStack {
                            Text(ingredient[1].key)
                                .font(.title)
                    
                            Spacer()
                            Text(ingredient[1].value)
                                .font(.title)
                             // More Button <++>
                        }
                    }.padding(.horizontal)
                    .offset(y: -15)
                }.offset(y: -20)
            }.padding()
        } else { // When Food does not have ingredient list
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(basicColors.basicGradient)
                    .frame(height: 140, alignment: .center)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0, y: 9.0)
                VStack {
                    HStack {    // Title
                        Text("Recipe")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundColor(basicColors.textColor)
                        Spacer()
                    }.padding()
                    HStack {
                        Text("No recipe for this food")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                }.offset(y: -15)
                
            }.padding()
        }
    }
}

struct RecipeTab_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTab(food: referenceFoods.chickenRice)
    }
}
