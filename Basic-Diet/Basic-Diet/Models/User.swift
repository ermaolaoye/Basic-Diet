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
struct User: Codable {
    var userName: String = ""
    var userEmail: String = ""
    var userWeight: Float = 0.0
    var userHeight: Float = 0.0
    var userCalories: Float = 0.0
    var userBirthday: String = ""
    var userGender: String = ""
}

class GetUserManager: ObservableObject{
    @Published var state: State = .ready
    @Published var user = [User()]
    
    enum State{
        case ready
        case loading
        case loaded
        case error(Error)
    }
    
    func postAuth() {
        let url = URL(string: Server.url + "User/description")!
        
        let body: [String: Any] = ["userJWT": UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT), "userID": UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID)] // Json Data
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert the data to JSON
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP Method
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { // Error Handling
                self.state = .error(error!) // Save Error
                return
            }
            // Get 401 error will log out user)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    logOut()
                }
            }
            // Check whether return value is correct or not
            let contents = String(data: data, encoding: .utf8)
            if contents!.isEmpty == false && contents!.contains("userName") == true {
                DispatchQueue.main.async {
                let decoder = JSONDecoder()
                do {
                    self.user = try decoder.decode([User].self, from: data)
                    self.state = .loaded
                } catch {
                    print(error.localizedDescription)
                    self.state = .error(error)
                }
                }
            }
        }.resume() // Start the URL Session
    }
    
}

// MARK: - Login User
struct LoginUser {
    var userEmail: String = ""
    var password: String = ""
}

class UserLoginManager: ObservableObject {
    @Published var authenticated = false // Whether authenticated or not
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
        
        let body: [String: Any] = ["userEmail": user.userEmail, "password": user.password] // Json Data
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert the data to JSON
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP Method
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { // Error Handling
                self.state = .error // Save Error
                return
            }

            let contents = String(data: data, encoding: .ascii)
            if contents?.isEmpty == false && contents?.contains("JWT:") == true {
                DispatchQueue.main.async {
                    let endRange = contents!.range(of: ";ID:")!
                    let startRange = contents!.range(of: "JWT:")!
                    UserDefaults.standard.set(contents![(startRange.upperBound..<endRange.lowerBound)], forKey: UserDefaultKeys.User.JWT) // Store JWT locally using UserDeafults
                    UserDefaults.standard.set(contents![(endRange.upperBound...)], forKey: UserDefaultKeys.User.userID) // Store ID locally using UserDefaults
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys.System.isLogin)
                    self.authenticated = true // Set authenticated to true
                    self.state = .loaded
                }
            } else if contents?.isEmpty == false && contents?.contains("WrongInput") == true { // If does not match with the database
                self.authenticated = false
                self.state = .wrongPassword
            }
        }.resume() // Start the URL Session
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


class UserRegisterAPIManager: ObservableObject {
    
    @Published var authenticated = false // Whether authenticated or not
    @Published var state: State = .ready
    
    enum State{
        case ready
        case loading
        case loaded
        case error
    }
    
    func postAuth(user: RegisterUser) {
        let url = URL(string: Server.url + "User/addUser")!
        
        let body: [String: Any] = ["userName": user.userName, "userGender": user.userGender, "password": user.password, "userEmail": user.userEmail, "userWeight": user.userWeight, "userHeight": user.userHeight, "userBirthday": user.userBirthday] // Json Data
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert data into JSON
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // HTTP Request Method
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in // Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion
            guard let data = data else { return }
            guard error == nil else {
                self.state = .error // Change the state to error
                return
            }
            let contents = String(data: data, encoding: .ascii) // Encode the data in ASCII character set
            // Check Start with JWT:
            if contents?.isEmpty == false && contents?.contains("JWT:") == true {
                DispatchQueue.main.async {
                    // Get JWT and ID
                    let endRange = contents!.range(of: ";ID:")!
                    let startRange = contents!.range(of: "JWT:")!
                    UserDefaults.standard.set(contents![(startRange.upperBound..<endRange.lowerBound)], forKey: UserDefaultKeys.User.JWT) // Store JWT locally using UserDeafults
                    UserDefaults.standard.set(contents![(endRange.upperBound...)], forKey: UserDefaultKeys.User.userID) // Store ID locally using UserDefaults
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys.System.isLogin) // Change login status
                    self.authenticated = true
                    self.state = .loaded
                }
            }
        }.resume()
    }
}

// MARK: - Update User
struct UpdateUser: Codable{
    var userName: String
    var userGender: String
    var userEmail: String = ""
    var userWeight: Int = 0
    var userHeight: Int = 0
}

class UserUpdateAPIManager: ObservableObject {
    
    @Published var authenticated = false // Whether authenticated or not
    @Published var state: State = .ready
    
    enum State{
        case ready
        case loading
        case loaded
        case error(Error)
    }
    
    func postAuth(user: UpdateUser) {
        let url = URL(string: Server.url + "User/update")!
        
        let body: [String: Any] = ["userJWT":UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT), "userID":UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID), "userName": user.userName, "userGender": user.userGender, "userEmail": user.userEmail, "userWeight": user.userWeight, "userHeight": user.userHeight] // Json Data
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert data into JSON
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // HTTP Request Method
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            // Get 401 error will log out user)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    logOut()
                }
            }
            guard error == nil else {
                self.state = .error(error!)
                return
            }
            let contents = String(data: data, encoding: .ascii) // Encode the data in ASCII character set
            // Check Succeed
            if contents?.isEmpty == false && contents?.contains("Succeed") == true {
                DispatchQueue.main.async {
                    self.authenticated = true
                    self.state = .loaded
                }
            }
        }.resume()
    }
}

class PasswordUpdateManager: ObservableObject{
    @Published var state: State = .ready
    @Published var authenticated = false
    
    enum State{
        case ready
        case loading
        case loaded
        case error(Error)
        case incorrectInput
    }
    
    func postAuth(oriPassword:String, newPassword:String){
        let url = URL(string: Server.url + "User/updatePassword")!
        
        let body: [String: Any] = ["oriPassword": hashText(string: oriPassword), "newPassword": hashText(string: newPassword), "userID": UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID)]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body) // Convert data into JSON
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // HTTP Request Method
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Value type
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else {
                self.state = .error(error!)
                return
            }
            let contents = String(data: data, encoding: .ascii) // Encode the data in ASCII character set
            // Check Update Succeed
            if contents?.isEmpty == false && contents?.contains("Succeed") == true {
                DispatchQueue.main.async {
                    self.authenticated = true
                    self.state = .loaded
                }
            } else if contents?.isEmpty == false && contents?.contains("Incorrect Input") == true{ // Wrong ori password
                DispatchQueue.main.async {
                    self.authenticated = false
                    self.state = .incorrectInput
                }
            }
        }.resume()
    }
}
