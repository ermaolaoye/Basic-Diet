//
//  StatusOverlay.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

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
