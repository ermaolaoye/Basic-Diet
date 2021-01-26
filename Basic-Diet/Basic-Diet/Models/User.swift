//
//  Users.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//

import Foundation
import SwiftUI
import Combine

// MARK: - User
struct User {
    var userName: String = ""
    var userID: Int = 0
    var userEmail: String = ""
    var userWeight: Float = 0.0
    var userHeight: Float = 0.0
    var userCalories: Float = 0.0
    var userPassword: String = ""
    var userBirthday: String = ""
    var userGender: String
    var JWT: String
    var currentCalories: Float?
    var calPercent: Float = 0
    var caloriesLeft: Int?
}

// MARK: - Login User
struct LoginUser {
    var userEmail: String = ""
    var password: String = ""
}

class UserLoginAuth: ObservableObject {
    @Published var authenticated = false
    @Published var state: State = .ready
    
    enum State{
        case ready
        case loading
        case loaded
        case error
        case wrongPassword
    }
    
    func postAuth(user: LoginUser) {
        let url = URL(string: Server.url + "User/login")!

        let body: [String: Any] = ["userEmail": user.userEmail, "password": user.password]

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
            if contents?.isEmpty == false || contents?.contains("JWT:") == true {
                DispatchQueue.main.async {
                    let startRange = contents?.range(of: "JWT:")!
                    UserDefaults.standard.set(contents![(startRange?.upperBound...)!], forKey: "JWT")
                    self.authenticated = true
                    self.state = .loaded
                }
            } else if contents?.isEmpty == false || contents?.contains("WrongInput") == true {
                self.authenticated = false
                self.state = .wrongPassword
            }
        }.resume()
    }
    
}

// MARK: - Register User

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
            if contents?.isEmpty == false || contents?.contains("JWT:") == true {
                DispatchQueue.main.async {
                    let startRange = contents?.range(of: "JWT:")!
                    UserDefaults.standard.set(contents![(startRange?.upperBound...)!], forKey: "JWT")
                    self.authenticated = true
                    self.state = .loaded
                }
            }
        }.resume()
    }
}
