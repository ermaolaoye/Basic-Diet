//
//  SearchBar.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

struct SearchBar: View {
    @State var text: String = "" // User input
    @State var isEditing = false // Editing Status
    @State var displayFoodList = false
    @State var userCaloriesLeft = UserDefaults.standard.integer(forKey: UserDefaultKeys.User.caloriesLeft)
    @State var userCalPersent = UserDefaults.standard.double(forKey: UserDefaultKeys.User.calPercent)
    
    @State var showUserView = false
    
    @State var showAddFoodView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if !showUserView && !showAddFoodView{
                    VStack {
                        HStack{
                            VStack{
                                // Textfield
                                TextField("Search ...", text: $text, onCommit:{
                                    self.isEditing = false // Disable editing mode once commited the change
                                    self.displayFoodList = true // Display the food list once commited the change
                                })
                                .navigationTitle("")
                                .navigationBarHidden(true) // Hide navigation bar
                                .padding(7)
                                .padding(.horizontal, 30)
                                .background(basicColors.basicGradient)
                                .cornerRadius(8)
                                .padding(.horizontal, 10)
                                .animation(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/) // Provide smooth animation
                                .onTapGesture {
                                    self.isEditing = true // Enable editing mode
                                    self.displayFoodList = false // Disable food list view
                                }
                                .overlay(
                                    HStack{
                                        Image(systemName: "magnifyingglass") // ICON
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 20)
                                            .animation(.default)
                                        
                                        if isEditing {
                                            Button(action: { // The delete button that delete all contents entered
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
                                
                            }
                            
                            if isEditing {
                                Button(action: { // Quit search mode button
                                    self.isEditing = false
                                    self.text = ""
                                    self.displayFoodList = false
                                    UserDefaults.standard.set(false, forKey: UserDefaultKeys.System.searchBarIsEditing)
                                    UserDefaults.standard.set(false, forKey: UserDefaultKeys.System.searchBarIsEditing)
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // Disable keyboard
                                }) {
                                    VStack {
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color(red: 241/255, green: 242/255,  blue: 246/255,opacity: 1), Color(red: 231/255, green: 238/255, blue:247/255, opacity: 1)]),
                                            startPoint: .top,
                                            endPoint: .bottom)
                                            .mask(Image(systemName: "multiply.square.fill").resizable())
                                            .frame(width: 20.0, height: 20.0)
                                    }
                                }
                                .padding(.trailing, 15)
                                .transition(.move(edge: .trailing)) // Customize animation
                                .animation(.default) // Add smooth animation
                            }
                        }
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onEnded({ value in
                                        if value.translation.height > 0 { // Swipe Down
                                            withAnimation(.default){
                                                self.showUserView = true
                                            }
                                        }
                                        if value.translation.height < 0 { // Swipe Up
                                            withAnimation(.default){
                                                self.showAddFoodView = true
                                            }
                                        }
                                    }))
                        if displayFoodList {
                            FoodList(foods: SearchFoodModel(searchContent: text))
                                .transition(.move(edge: .bottom)) // Customize animation
                                .animation(.spring(blendDuration: 1)) // Smooth animation
                                .navigationTitle("")
                                .navigationBarHidden(true) // Hide navigation bar
                        }
                    }
                }
                
                if !isEditing && !displayFoodList && showUserView == true {
                    VStack {
                        UserView()
                            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                            .navigationBarHidden(true)
                        Button(action:{
                            withAnimation(.default){
                                self.showUserView = false
                            }
                        }){
                            Text("Close")
                        }
                    }
                }
                
                if !isEditing && !displayFoodList && showAddFoodView == true {
                    VStack {
                        AddFoodView()
                        Button(action:{
                            withAnimation(.default){
                                self.showAddFoodView = false
                            }
                        }){
                            Text("Close")
                        }
                    }
                }
                
                if !isEditing && !displayFoodList && !showAddFoodView && !showUserView{
                    VStack {
                        Text("Swipe down to enter user profile")
                            .padding()
                            .foregroundColor(.gray)
                        Spacer()
                        
                        Text("Swipe up to add food")
                            .padding()
                            .foregroundColor(.gray)
                    }
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
