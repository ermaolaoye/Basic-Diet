//
//  Basic_DietApp.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//

import SwiftUI

@main
struct BasicDietApp: App {
    var server = Server()
    var body: some Scene {
        WindowGroup {
            foodPreviewTab(food: referenceFoods.chickenBreast)
        }
    }
}

