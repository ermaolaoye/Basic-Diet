//
//  Food.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//
import Foundation
import SwiftUI

enum FoodType{
    case meat
    case staple
    case desert
    case beverage
}

struct Food{
    var foodNameCHN: String
    var id: Int
    var barcode: String?
    var ingredients: String?
    var calories: Int
    var carbonhydrate: Float?
    var fat: Float?
    var protein: Float?
    var sodium: Float?
    var saturatedFat: Float?
    var transFat: Float?
    var cholesterol: Float?
    var sugar: Float?
    var dietaryFiber: Float?
    var vitaminA: Float?
    var carotene: Float?
    var vitaminD: Float?
    var vitaminE: Float?
    var vitaminK: Float?
    var vitaminB1: Float?
    var vitaminB2: Float?
    var vitaminB6: Float?
    var vitaminB12: Float?
    var vitaminC: Float?
    var niacin: Float?
    var folicAcid: Float?
    var phosphorus: Float?
    var potassium: Float?
    var magnesium: Float?
    var calcium: Float?
    var iron: Float?
    var zinc: Float?
    var iodine: Float?
    var selenium: Float?
    var copper: Float?
    var fluorine: Float?
    var manganese: Float?
    var unitMap: String?
    var addUserName: String?
    var type: FoodType?
    
    private var imageName: String?
    var image: Image {
        Image(imageName!)
    }
    // testInitialization
    init(name: String, id:Int, calories: Int, imageName: String?, type: FoodType){
        self.foodNameCHN = name
        self.id = id
        self.calories = calories
        self.imageName = imageName
        self.type = type
    }
    
    static let `default` = Food(name: "Original Recipie Chicken", id: 1, calories: 346, imageName: "test", type: FoodType.meat)
    
}

struct referenceFoods: Decodable{
    // per slice
    static var chickenBreast: Food = Food(name: "Chicken Breast", id: 764, calories: 133, imageName: nil, type: FoodType.meat)
    
    // per bowl
    static var rice: Food = Food(name: "Rice", id: 56, calories: 208, imageName: nil, type: FoodType.staple)
    
    // per slice
    static var oreo: Food = Food(name: "Oreo", id: -1, calories: 47, imageName: nil, type: FoodType.desert)
    
    // per cup
    static var cola: Food = Food(name: "Cola", id: -1, calories: 141, imageName: nil, type: FoodType.beverage)
}

