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
    init(foodNameCHN: String, id: Int, barcode: String? = nil, ingredients: String? = nil, calories: Int, carbohydrate: Float? = nil, fat: Float? = nil, protein: Float? = nil, sodium: Float? = nil, cholesterol: Float? = nil, dietaryFiber: Float? = nil, vitaminA: Float? = nil, carotene: Float? = nil, vitaminE: Float? = nil, vitaminB1: Float? = nil, vitaminB2: Float? = nil, vitaminC: Float? = nil, niacin: Float? = nil, phosphorus: Float? = nil, potassium: Float? = nil, magnesium: Float? = nil, calcium: Float? = nil, iron: Float? = nil, zinc: Float? = nil, selenium: Float? = nil, copper: Float? = nil, manganese: Float? = nil, unitMap: Dictionary<String, String>? = nil, addUserName: String? = nil, type: FoodType? = nil, imageName: String? = nil) {
        self.foodNameCHN = foodNameCHN
        self.id = id
        self.barcode = barcode
        self.ingredients = ingredients
        self.calories = calories
        self.carbohydrate = carbohydrate
        self.fat = fat
        self.protein = protein
        self.sodium = sodium
        self.cholesterol = cholesterol
        self.dietaryFiber = dietaryFiber
        self.vitaminA = vitaminA
        self.carotene = carotene
        self.vitaminE = vitaminE
        self.vitaminB1 = vitaminB1
        self.vitaminB2 = vitaminB2
        self.vitaminC = vitaminC
        self.niacin = niacin
        self.phosphorus = phosphorus
        self.potassium = potassium
        self.magnesium = magnesium
        self.calcium = calcium
        self.iron = iron
        self.zinc = zinc
        self.selenium = selenium
        self.copper = copper
        self.manganese = manganese
        self.unitMap = unitMap
        self.addUserName = addUserName
        self.type = type
        self.imageName = imageName
    }
    
    var foodNameCHN: String
    var id: Int
    var barcode: String?
    var ingredients: String?
    var calories: Int
    var carbohydrate: Float?
    var fat: Float?
    var protein: Float?
    var sodium: Float?
    var cholesterol: Float?
    var dietaryFiber: Float?
    var vitaminA: Float?
    var carotene: Float?
    var vitaminE: Float?
    var vitaminB1: Float?
    var vitaminB2: Float?
    var vitaminC: Float?
    var niacin: Float?
    var phosphorus: Float?
    var potassium: Float?
    var magnesium: Float?
    var calcium: Float?
    var iron: Float?
    var zinc: Float?
    var selenium: Float?
    var copper: Float?
    var manganese: Float?
    var unitMap: Dictionary<String, String>?
    var addUserName: String?
    var type: FoodType?
    
    private var imageName: String?
    var image: Image {
        Image(imageName!)
    }
    // testInitialization
    init(name: String, id:Int, calories: Int, imageName: String? = nil, type: FoodType? = nil){
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
    static var chickenBreast: Food = Food(foodNameCHN: "Chicken Breast", id: 764, calories: 133, carbohydrate: 2.0, fat: 5.0, protein: 19.0, sodium: 34.0, cholesterol: 82.0, dietaryFiber: 0.0,unitMap: ["calories":"Kcal","vitaminB1":"mg","calcium":"mg","protein":"g","vitaminB2":"mg","magnesium":"mg","fat":"g","niacin":"mg","iron":"mg","carbohydrate":"g","vitaminC":"mg","manganese":"mg","dietaryFiber":"g","vitaminE":"mg","zinc":"mg","vitaminA":"mcg","cholesterol":"mg","copper":"mg","carotene":"mcg","potassium":"mg","phosphorus":"mg","sodium":"mg","selenium":"mcg"], type: FoodType.meat, imageName: "test")
    
    // per bowl
    static var rice: Food = Food(name: "Rice", id: 56, calories: 208, imageName: nil, type: FoodType.staple)
    
    // per slice
    static var oreo: Food = Food(name: "Oreo", id: -1, calories: 47, imageName: nil, type: FoodType.desert)
    
    // per cup
    static var cola: Food = Food(name: "Cola", id: -1, calories: 141, imageName: nil, type: FoodType.beverage)
}

