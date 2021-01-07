//
//  Server.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/5.
//

import Foundation

struct Server{
    static let url: String = "http://127.0.0.1:5000/api/"
}

class ServerAPIConnection: ObservableObject {
    @Published var value = referenceFoods.loadingFood
    @Published var state: State = State.ready
    var mode: Mode = Mode.food
    
    enum Mode{
        case food
        case searchFood
    }
    
    enum State{
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    var url = URL(string: "http://127.0.0.1:5000/api/Food/description/1")!
    let urlSession = URLSession.shared
    
    var dataTask: AnyPublisher<[], Error> {
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
        self.mode = Mode.food
    }
    init(searchContent: String){
        self.url = URL(string: Server.url + "Food/list/" + searchContent)!
        self.mode = Mode.searchFood
    }
    
}
