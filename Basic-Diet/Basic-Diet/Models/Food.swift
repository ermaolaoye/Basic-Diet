//
//  Food.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//
import Combine
import SwiftUI

// MARK: - Food Model

enum FoodType{
    case meat
    case staple
    case desert
    case beverage
}

struct Food: Codable{
    var foodNameCHN: String
    var id: Int
    var calories, carbohydrate, fat, protein, cholesterol, sodium, dietaryFiber, vitaminA, carotene, vitaminE, vitaminB1, vitaminB2, vitaminC, niacin, phosphorus, potassium, magnesium, calcium, iron, zinc, selenium, copper, manganese: Float
    var imageID, type: Int
    
    // Type 0:Meat, 1:Staple, 2:Desert, 3:Beverage
}

extension Food: CustomStringConvertible {
    // Generate Update Food API Parameter
    var description: String {
        return "foodNameCHN = '\(foodNameCHN)', calories = '\(calories)', carbohydrate = '\(carbohydrate)', fat = '\(fat)', protein = '\(protein)', cholesterol = '\(cholesterol)', sodium = '\(sodium)', dietaryFiber = '\(dietaryFiber)', vitaminA = '\(vitaminA)', carotene = '\(carotene)', vitaminE = '\(vitaminE)', vitaminB1 = '\(vitaminB1)', vitaminB2 = '\(vitaminB2)', vitaminC = '\(vitaminC)', niacin = '\(niacin)', phosphorus = '\(phosphorus)', potassium = '\(potassium)', magnesium = '\(magnesium)', calcium = '\(calcium)', iron = '\(iron)', zinc = '\(zinc)', selenium = '\(selenium)', copper = '\(copper)', manganese = '\(manganese)'"
    }
    
    // Generate Add Food API Parameter
    var descriptionNutriSelect: String {
        return "carbohydrate, fat, protein, cholesterol, sodium, dietaryFiber, vitaminA, carotene, vitaminE, vitaminB1, vitaminB2, vitaminC, niacin, phosphorus, potassium, magnesium, calcium, iron, zinc, selenium, copper, manganese"
    }
    var descriptionNutriVal: String{
        return "'\(carbohydrate)', '\(fat)', '\(protein)', '\(cholesterol)', '\(sodium)', '\(dietaryFiber)', '\(vitaminA)', '\(carotene)', '\(vitaminE)', '\(vitaminB1)', '\(vitaminB2)', '\(vitaminC)', '\(niacin)', '\(phosphorus)', '\(potassium)', '\(magnesium)', '\(calcium)', '\(iron)', '\(zinc)', '\(selenium)', '\(copper)', '\(manganese)'"
    }
}


struct foodImage {
    var imageID: Int
    var image: Image{
        Image(String(imageID))
    }
}

// MARK: - Food View Model
class FoodModel: ObservableObject{
    @Published var food = referenceFoods.loadingFood
    @Published var state: State = State.ready
    // State of the model
    enum State{
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    // default URL
    var url = URL(string: "http://127.0.0.1:5000/api/Food/description/0")!
    let urlSession = URLSession.shared
    
    // HTTP Request
    var dataTask: AnyPublisher<[Food], Error> {
        self.urlSession
            .dataTaskPublisher(for: self.url) // Returns a publisher that wraps a URL session data task for a given URL
            .map { $0.data } // Mapped to URLSession.DataTaskPublisher.Output
            .decode(type: [Food].self, decoder: JSONDecoder()) // Json Decode
            .receive(on: RunLoop.main) // Returns the run loop of the main thread when receive the data
            .eraseToAnyPublisher() // Wraps this publisher with a type eraser
    }
    
    // Load food from database
    func load() {
        assert(Thread.isMainThread)
        self.state = .loading(self.dataTask.sink(
                                receiveCompletion: { completion in
                                    switch completion {
                                    case .finished:
                                        break
                                    case let .failure(error): // Fail to load the data
                                        self.state = .error(error) // Store error message
                                    }
                                }, receiveValue: { value in
                                    self.state = .loaded // Change state
                                    for food in value{
                                        self.food = food // Update self food model
                                    }
                                }))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return } // If already have data, stop lodaing
        self.load()
    }
    
    // Initializer
    // Get food data from database by using foodID
    init(foodID: Int){
        self.url = URL(string: Server.url + "Food/description/" + String(foodID))!
    }
}
// MARK: - Update Food
struct UpdateFood: Codable{
    var foodID: Int = 0
    var updatePara: String = ""
}

class FoodUpdateAPIManager: ObservableObject {
    
    @Published var authenticated = false // Whether authenticated or not
    @Published var state: State = .ready
    
    enum State{
        case ready
        case loading
        case loaded
        case requested
        case error(Error)
    }
    
    func postAuth(food: UpdateFood) {
        let url = URL(string: Server.url + "Food/update")!
        
        let body: [String: Any] = ["userID":UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID), "userJWT":UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT), "foodID": food.foodID, "updatePara": food.updatePara] // Json Data
        
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
            
            // Get 401 error will log out user)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    logOut()
                }
            }
            
            let contents = String(data: data, encoding: .ascii) // Encode the data in ASCII character set
            // Check Start with JWT:
            if contents?.isEmpty == false && contents?.contains("Succeed") == true {
                DispatchQueue.main.async {
                    self.authenticated = true
                    self.state = .loaded
                }
            } else if contents?.contains("succeedRequested") == true{
                DispatchQueue.main.async {
                    self.state = .requested
                    self.authenticated = true
                }
            }
        }.resume()
    }
}

// MARK: - Add Food
struct AddFood{
    var foodNameCHN: String
    var calories: Float
    var nutriSelect: String
    var nutriVal: String
}

class AddFoodAPIManager: ObservableObject {
    
    @Published var authenticated = false // Whether authenticated or not
    @Published var state: State = .ready
    
    enum State{
        case ready
        case loading
        case loaded
        case requested
        case error(Error)
    }
    
    func postAuth(food: AddFood) {
        let url = URL(string: Server.url + "Food/add")!
        
        let body: [String: Any] = ["userID":UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID), "userJWT":UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT), "foodName": food.foodNameCHN, "calories": food.calories, "nutriSelect": food.nutriSelect, "nutriVal": food.nutriVal] // Json Data
        
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
            
            // Get 401 error will log out user)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    logOut()
                }
            }
            
            let contents = String(data: data, encoding: .ascii) // Encode the data in ASCII character set
            // Check Start with JWT:
            if contents?.isEmpty == false && contents?.contains("Succeed") == true {
                DispatchQueue.main.async {
                    self.authenticated = true
                    self.state = .loaded
                }
            } else if contents?.contains("succeedRequested") == true{
                DispatchQueue.main.async {
                    self.state = .requested
                    self.authenticated = true
                }
            }
        }.resume()
    }
}
