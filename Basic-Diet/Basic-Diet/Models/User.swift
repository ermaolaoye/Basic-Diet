//
//  Users.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//

import Foundation
import SwiftUI
import Combine

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

struct RegisterUser: Codable{
    var userName: String = ""
    var userGender: String = "Male"
    var password: String = ""
    var userEmail: String = ""
    var userWeight: Int = 0
    var userHeight: Int = 0
    var userBirthday: String = ""
}

struct JWT: Codable{
    var JWT: String
}


class HttpAuth: ObservableObject {

    @Published var authenticated = false
    @Published var state: State = .ready
    
    enum State{
        case ready
        case loading
        case loaded
        case error
    }

    func postAuth(user: RegisterUser) {
        let url = URL(string: Server.url + "User/addUser")!

        let body: [String: Any] = ["userName": user.userName, "userGender": user.userGender, "password": user.password, "userEmail": user.userEmail, "userWeight": user.userWeight, "userHeight": user.userHeight, "userBirthday": user.userBirthday]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else {
                self.state = .error
                return
            }
            let contents = String(data: data, encoding: .ascii)
            if contents?.isEmpty == false {
                DispatchQueue.main.async {
                    self.authenticated = true
                    self.state = .loaded
                }
            }
        }.resume()
    }
}
