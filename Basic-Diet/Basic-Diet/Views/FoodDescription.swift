//
//  SwiftUIView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct foodInfo: View {
    var food: Food
    var body: some View {
        ScrollView {
            foodPreviewTab(food: Food.default)
            caloriesDesTab(food: Food.default)
        }
    }
}

struct foodInfo_Previews: PreviewProvider {
    static var previews: some View {
        foodInfo(food: Food.default)
    }
}
