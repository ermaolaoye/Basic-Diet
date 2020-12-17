//
//  FoodProfile.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import Foundation

struct FoodProfile: Decodable, Identifiable {
    var id: Int
    
    var name: String
    var producer: String
    var calories: Int
    var protein: Float
    var fat: Float
    var carbonHydrate : Float
    var calcium: Float
    var iron: Float
    var phosphrous: Float
    
    static let `default` = Self(name: "Original Recipe Chicken", producer:"KFC", calories:390, protein: 39.0, fat: 21.0)
    
    init(name: String, producer: String, calories: Int, protein: Float = 0.0, fat: Float = 0.0, carbonHydrate: Float = 0.0, calcium: Float = 0.0, iron:Float = 0.0, phosphrous: Float = 0.0, id: Int = 0) {
        self.name = name
        self.producer = producer
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbonHydrate = carbonHydrate
        self.calcium = calcium
        self.iron = iron
        self.phosphrous = phosphrous
        self.id = id
    }
}
