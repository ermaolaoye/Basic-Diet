//
//  Food.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//
import Combine
import SwiftUI

extension Dictionary {
    subscript(i: Int) -> (key:Key, value: Value){
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
}

struct Food: Codable{
    var foodNameCHN: String
    var id: Int
    var calories, carbohydrate, fat, protein, cholesterol, sodium, dietaryFiber, vitaminA, carotene, vitaminE, vitaminB1, vitaminB2, vitaminC, niacin, phosphorus, potassium, magnesium, calcium, iron, zinc, selenium, copper, manganese: Float
    var imageID, type: Int
    
    // Type 0:Meat, 1:Staple, 2:Desert, 3:Beverage
}

// MARK: - Food Model
class foodModel: ObservableObject{
    @Published var foods = [Food]()
    @Published var state: State = State.ready
    enum State{
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    var url = URL(string: "http://127.0.0.1:5000/api/Food/description/2")!
    let urlSession = URLSession.shared
    
    var dataTask: AnyPublisher<[Food], Error> {
        self.urlSession
            .dataTaskPublisher(for: self.url)
            .map { $0.data }
            .decode(type: [Food].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func load() {
        assert(Thread.isMainThread)
        self.state = .loading(self.dataTask.sink(
                                receiveCompletion: { completion in
                                    switch completion {
                                    case .finished:
                                        break
                                    case let .failure(error):
                                        self.state = .error(error)
                                    }
                                }, receiveValue: { value in
                                    self.state = .loaded
                                    self.foods = value
                                }))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return }
        self.load()
    }
    
}
struct foodImage {
    var imageID: Int
    var image: Image{
        Image(String(imageID))
    }
}

struct referenceFoods: Decodable{
    // per slice
    static var chickenBreast: Food = Food(foodNameCHN: "Chicken Breast", id: 764, calories: 133, carbohydrate: 2.0, fat: 5.0, protein: 19.0, cholesterol: 82.0, sodium: 34.0, dietaryFiber: 0.0, vitaminA: 16.0, carotene: 1.0, vitaminE: 0.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: 0.0, niacin: 11.0, phosphorus: 214.0, potassium: 338.0, magnesium: 28.0, calcium: 3.0, iron: 1.0, zinc: 1.0, selenium: 10.0, copper: 0.0, manganese: 0.0, imageID: -1, type: 0)
    
    // per bowl
    static var rice: Food = Food(foodNameCHN: "Rice", id: 56, calories: 116.0, carbohydrate: 26.0, fat: 0.0, protein: 3.0, cholesterol: 0.0, sodium: 2.0, dietaryFiber: 0.0, vitaminA: 0.0, carotene: 0.0, vitaminE: 0.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: 0, niacin: 2.0, phosphorus: 62.0, potassium: 30.0, magnesium: 15.0, calcium: 7.0, iron: 1.0, zinc: 1.0, selenium: 0.0, copper: 0.0, manganese: 1.0, imageID: -1, type: 1)
    
    // per slice
    static var oreo: Food = Food(foodNameCHN: "Oreo", id: -1, calories: 491.0, carbohydrate: 70.8, fat: 21.2, protein: 4.2, cholesterol: 0.0, sodium: -1.0, dietaryFiber: -1.0, vitaminA: -1.0, carotene: -1.0, vitaminE: -1.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: -1.0, niacin: -1.0, phosphorus: -1.0, potassium: -1.0, magnesium: -1.0, calcium: -1.0, iron: -1.0, zinc: -1.0, selenium: -1.0, copper: -1.0, manganese: -1.0, imageID: -1, type: 2)
    
    // per cup
    static var cola: Food = Food(foodNameCHN: "Cola", id: -1, calories: 45, carbohydrate: 11.2, fat: 0.0, protein: 0.0, cholesterol: 0.0, sodium: 11.4, dietaryFiber: 0.0, vitaminA: 0.0, carotene: 0.0, vitaminE: -1.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: -1.0, niacin: -1.0, phosphorus: -1.0, potassium: -1.0, magnesium: -1.0, calcium: -1.0, iron: -1.0, zinc: -1.0, selenium: -1.0, copper: -1.0, manganese: -1.0, imageID: -1, type: 3)
    
    static var unitMap: Dictionary<String, String> = ["calories":"Kcal","vitaminB1":"mg","calcium":"mg","protein":"g","vitaminB2":"mg","magnesium":"mg","fat":"g","niacin":"mg","iron":"mg","carbohydrate":"g","vitaminC":"mg","manganese":"mg","dietaryFiber":"g","vitaminE":"mg","zinc":"mg","vitaminA":"mcg","cholesterol":"mg","copper":"mg","carotene":"mcg","potassium":"mg","phosphorus":"mg","sodium":"mg","selenium":"mcg"]
}
