//
//  StatusOverlay.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

// MARK: - Food
struct StatusOverlayFood: View{
    @ObservedObject var model: FoodModel
    var body: some View{
        switch model.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            return AnyView(
                VStack(spacing: 10){
                    Text(error.localizedDescription).frame(maxWidth: 300) // Error Description
                    Button("Retry"){ // Retry button
                        self.model.load()
                    }
                }
                .padding()
                .background(Color.yellow)
            )
        }
    }
}

// MARK: - Search Food
struct StatusOverlaySearchFood: View{
    @ObservedObject var model: SearchFoodModel
    var body: some View{
        switch model.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            return AnyView(
                VStack(spacing: 10){
                    Text(error.localizedDescription).frame(maxWidth: 300)
                    Button("Retry"){
                        self.model.load()
                    }
                }
                .padding()
                .background(Color.yellow)
            )
        }
    }
}

// MARK: - Register User
struct StatusOverlayRegisterUser: View{
    @ObservedObject var model: UserRegisterAPIManager
    var body: some View{
        switch model.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(
                Text("Loading")
            )
        case .loaded:
            return AnyView(EmptyView())
        case .error:
            return AnyView(
                Text("Error Happended Please Retry")
                    .padding()
                    .background(Color.yellow)
            )
        }
    }
}

// MARK: - Login User
struct StatusOverlayLoginUser: View{
    @ObservedObject var model: UserLoginManager
    var body: some View{
        switch model.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(
                Text("Loading")
            )
        case .loaded:
            return AnyView(EmptyView())
        case .error:
            return AnyView(
                Text("Error Happended Please Retry")
                    .padding()
                    .background(Color.yellow)
            )
        case .wrongPassword:
            return AnyView(EmptyView())
        }
    }
}

// MARK: - Update User
struct StatusOverlayUpdateUser: View{
    @ObservedObject var model: UserUpdateAPIManager
    @State var showErrorBox: Bool = true
    var body: some View{
        switch model.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(
                Text("Loading")
            )
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            if showErrorBox{
                return AnyView(
                    VStack(spacing: 10){
                        Text(error.localizedDescription).frame(maxWidth: 300) // Error Description
                        Button("Close"){ // Retry button
                            self.showErrorBox = false
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                )
            } else {
                return AnyView(EmptyView())
            }
        }
    }
}

// MARK: - Update Food
struct StatusOverlayUpdateFood: View{
    @ObservedObject var manager: FoodUpdateAPIManager
    @State var showErrorBox: Bool = true
    var body: some View{
        switch manager.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case .requested:
            return AnyView(
                Text("request")
                    .offset(y: 30.0)
            )
        case let .error(error):
            if showErrorBox{
                return AnyView(
                    VStack(spacing: 10){
                        Text(error.localizedDescription).frame(maxWidth: 300) // Error Description
                        Button("Close"){ // Retry button
                            self.showErrorBox = false
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                )
            } else {
                return AnyView(EmptyView())
            }
        }
    }
}

// MARK: - Add Food
struct StatusOverlayAddFood: View{
    @ObservedObject var manager: AddFoodAPIManager
    @State var showErrorBox: Bool = true
    var body: some View{
        switch manager.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case .requested:
            return AnyView(
                Text("request")
                    .offset(y: 30.0)
            )
        case let .error(error):
            if showErrorBox{
                return AnyView(
                    VStack(spacing: 10){
                        Text(error.localizedDescription).frame(maxWidth: 300) // Error Description
                        Button("Close"){ // Retry button
                            self.showErrorBox = false
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                )
            } else {
                return AnyView(EmptyView())
            }
        }
    }
}

// MARK: - Update Password
struct StatusOverlayUpdatePassword: View{
    @ObservedObject var manager: PasswordUpdateManager
    @State var showErrorBox: Bool = true
    @State var showIncorrectBox: Bool = true
    var body: some View{
        switch manager.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case .incorrectInput: // Show Incorrect Box
            if showIncorrectBox{
            return AnyView(
                VStack(spacing:10){
                    Text("Incorrect original password")
                        .bold()
                        .frame(maxWidth: 300)
                        .foregroundColor(.red)
                    Button("Close"){
                        self.showIncorrectBox = false
                    }
                }
            )
            } else {
                return AnyView(EmptyView())
            }
        case let .error(error): // Show Error Box
            if showErrorBox{
                return AnyView(
                    VStack(spacing: 10){
                        Text(error.localizedDescription).frame(maxWidth: 300) // Error Description
                        Button("Close"){ // Retry button
                            self.showErrorBox = false
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                )
            } else {
                return AnyView(EmptyView())
            }
        }
    }
}
