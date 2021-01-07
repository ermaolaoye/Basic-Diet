//
//  Food.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/18.
//
import Combine
import SwiftUI

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


struct foodImage {
    var imageID: Int
    var image: Image{
        Image(String(imageID))
    }
}

// MARK: - Food Model
class FoodModel: ObservableObject{
    @Published var food = referenceFoods.loadingFood
    @Published var state: State = State.ready
    enum State{
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    var url = URL(string: "http://127.0.0.1:5000/api/Food/description/0")!
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
                                    for food in value{
                                        self.food = food
                                    }
                                }))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return }
        self.load()
    }
    
    init(foodID: Int){
        self.url = URL(string: Server.url + "Food/description/" + String(foodID))!
    }
}
