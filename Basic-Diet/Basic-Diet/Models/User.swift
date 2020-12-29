//
//  Users.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//

import Foundation

struct User {
    var name: String
    let id: Int
    var email: String
    var weight: Float // In kg
    var height: Float
    var recCalories: Float
    var password: String
    var birthdate: Date
    var gender: String
    var JWT: String
    
    static let `default` = User(name:"Mark", id:1, email:"test@gmail.com", weight:90.0, height: 180.0, recCalories: 1000.0, password: "123123123", birthdate:Date(), gender: "Male", JWT:"test")
}
