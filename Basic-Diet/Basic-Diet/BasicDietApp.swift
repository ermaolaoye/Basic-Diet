//
//  Basic_DietApp.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//

import SwiftUI

@main
struct BasicDietApp: App {
    var body: some Scene {
        WindowGroup {
            foodInfo(food: Food.default)
        }
    }
}