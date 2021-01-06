//
//  Users.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//

import Foundation

struct User: Decodable {
    internal init(userName: String, userID: Int, userEmail: String, userWeight: Float, userHeight: Float, userCalories: Float, userPassword: String, userBirthday: Date, userGender: String, JWT: String, currentCalories: Float? = nil, calPercent: Float = 0, caloriesLeft: Float? = nil) {
        self.userName = userName
        self.userID = userID
        self.userEmail = userEmail
        self.userWeight = userWeight
        self.userHeight = userHeight
        self.userCalories = userCalories
        self.userPassword = userPassword
        self.userBirthday = userBirthday
        self.userGender = userGender
        self.JWT = JWT
        self.currentCalories = currentCalories
        self.calPercent = calPercent
        self.caloriesLeft = Int(userCalories - currentCalories!)
    }
    
    var userName: String
    let userID: Int
    var userEmail: String
    var userWeight: Float // In kg
    var userHeight: Float
    var userCalories: Float
    var userPassword: String
    var userBirthday: Date
    var userGender: String
    var JWT: String
    var currentCalories: Float?
    var calPercent: Float = 0
    var caloriesLeft: Int?
    
    mutating func updateCal(newCal: Float){
        currentCalories! += newCal
        calPercent = currentCalories! / userCalories * 100
        caloriesLeft = Int(userCalories - currentCalories!)
    }
    
    static let `default` = User(userName: "test", userID: 1, userEmail: "testEmazi@11.co", userWeight: 90, userHeight: 190, userCalories: 1900, userPassword: "test", userBirthday: Date(), userGender: "male", JWT: "test", currentCalories: 0, calPercent: 0)
}
