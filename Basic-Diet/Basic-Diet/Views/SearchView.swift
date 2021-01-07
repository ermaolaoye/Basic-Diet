//
//  SearchView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
            FoodList(foods: SearchFoodModel(searchContent: searchText))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: "3")
    }
}
