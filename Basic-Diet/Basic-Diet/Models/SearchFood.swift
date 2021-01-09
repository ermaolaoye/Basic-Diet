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

class SearchFoodModel: ObservableObject{
    @Published var foods = [SearchFood]()
    @Published var state: State = State.ready
    enum State{
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    @Published var url = URL(string: "http://127.0.0.1:5000/api/Food/list/1")!
    let urlSession = URLSession.shared
    
    var dataTask: AnyPublisher<[SearchFood], Error> {
        self.urlSession
            .dataTaskPublisher(for: self.url)
            .map { $0.data }
            .decode(type: [SearchFood].self, decoder: JSONDecoder())
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
    
    func updateURL(searchContent: String) {
        self.url = URL(string: String(Server.url + "Food/list/" + searchContent).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    init(searchContent: String){
        self.url = URL(string: String(Server.url + "Food/list/" + searchContent).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
}
