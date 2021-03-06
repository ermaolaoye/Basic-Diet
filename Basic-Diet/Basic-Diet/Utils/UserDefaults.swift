//
//  UserDefaults.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/5.
//

import Foundation
import SwiftUI

struct UserDefaultKeys {
    struct User{
        static var userName: String = "userName"
        static var userID: String = "userID"
        static var userEmail: String = "userEmail"
        static var userWeight: String = "userWeight"
        static var userHeight: String = "userHeight"
        static var userCalories: String = "userCalories"
        static var userPassword: String = "userPassword"
        static var userBirthday: String = "userBirthday"
        static var userGender: String = "userGender"
        static var JWT: String = "JWT"
        static var currentCalories: String = "currentCalories"
        static var calPercent: String = "calPercent"
        static var caloriesLeft: String = "caloriesLeft"
    }
    struct System{
        static var isLogin: String = "isLogin"
        static var searchBarIsEditing: String = "searchBarIsEditing"
    }
    struct SystemVariables{
        static var searchBarOffset: CGFloat = -390.0
    }
}

func logOut() -> Void{
    UserDefaults.standard.set(false, forKey: UserDefaultKeys.System.isLogin)
}

// MARK: - Delete User
func deleteUser() -> Void{
    let url = URL(string: Server.url + "User/delUser")!
    
    let body: [String: Any] = ["userID": UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID), "userJWT": UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT)] // Json Data
    
    let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert the data to JSON
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST" // Set HTTP Method
    request.httpBody = finalBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else { return }
        guard error == nil else { // Error Handling
            return
        }
        // Check whether return value is correct or not
        let contents = String(data: data, encoding: .utf8)
        if contents!.isEmpty == false && contents!.contains("Succeed") == true {
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.System.isLogin)
            }
        }
    }.resume() // Start the URL Session
}
// MARK: - Delete Food

func deleteFood(food: Food) -> Void{
    let url = URL(string: Server.url + "Food/del")!
    
    let body: [String: Any] = ["userID": UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID), "userJWT": UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT), "foodID": food.id] // Json Data
    
    let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert the data to JSON
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST" // Set HTTP Method
    request.httpBody = finalBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else { return }
        guard error == nil else { // Error Handling
            return
        }
        // Check whether return value is correct or not
        let contents = String(data: data, encoding: .utf8)
        if contents!.isEmpty == false && contents!.contains("Succeed") == true {
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.System.isLogin)
            }
        }
    }.resume() // Start the URL Session
}
