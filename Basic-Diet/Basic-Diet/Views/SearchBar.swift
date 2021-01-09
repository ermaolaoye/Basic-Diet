//
//  SearchBar.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    @State var isEditing = false
    @State var displayFoodList = false
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Search ...", text: $text, onCommit:{
                        self.isEditing = false
                        self.displayFoodList = true
                    })
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .padding(7)
                    .padding(.horizontal, 30)
                    .background(basicColors.basicGradient)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .animation(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.isEditing = true
                        self.displayFoodList = false
                    }
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20)
                                    .animation(.default)
                                
                                if isEditing {
                                    Button(action: {
                                        self.text = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 24)
                                            .animation(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        )
                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.text = ""
                            self.displayFoodList = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 241/255, green: 242/255,  blue: 246/255,opacity: 1), Color(red: 231/255, green: 238/255, blue:247/255, opacity: 1)]),
                                startPoint: .top,
                                endPoint: .bottom)
                                .mask(Image(systemName: "multiply.square.fill").resizable())
                                .frame(width: 20.0, height: 20.0)
                        }
                        .padding(.trailing, 15)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                if displayFoodList {
                    FoodList(foods: SearchFoodModel(searchContent: text))
                        .transition(.move(edge: .bottom))
                        .animation(.spring(blendDuration: 1))
                        .navigationTitle("")
                        .navigationBarHidden(true)
                }
                
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
