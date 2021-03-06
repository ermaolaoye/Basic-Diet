//
//  SearchFood.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/7.
//

import Combine
import SwiftUI

struct SearchFood: Codable, Identifiable{
    var foodNameCHN: String
    var id: Int
    var imageID: Int
}

// MARK: - Search Food View Model
class SearchFoodModel: ObservableObject{
    @Published var foods = [SearchFood]()
    @Published var state: State = State.ready
    // State of the model
    enum State{
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    // default URL
    @Published var url = URL(string: "http://127.0.0.1:5000/api/Food/list/1")!
    let urlSession = URLSession.shared
    
    // HTTP Request
    var dataTask: AnyPublisher<[SearchFood], Error> {
        self.urlSession
            .dataTaskPublisher(for: self.url) // Returns a publisher that wraps a URL session data task for a given URL
            .map { $0.data } // Mapped to URLSession.DataTaskPublisher.Output
            .decode(type: [SearchFood].self, decoder: JSONDecoder()) // Json Decode
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
                                    self.foods = value // Update self food model
                                    
                                }))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return } // If already have data, stop lodaing
        self.load()
    }
    
    // Update URL
    func updateURL(searchContent: String) {
        self.url = URL(string: String(Server.url + "Food/list/" + searchContent).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    // Initializer
    // Get food data from database by using foodID
    init(searchContent: String){
        self.url = URL(string: String(Server.url + "Food/list/" + searchContent).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
}
