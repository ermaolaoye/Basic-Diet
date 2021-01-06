import Combine
import SwiftUI
import PlaygroundSupport

struct Food: Codable{
    init(foodNameCHN: String, foodID: Float, calories: Float, carbohydrate: Float, fat: Float, protein: Float, cholesterol: Float, sodium: Float, dietaryFiber: Float = -1.0, vitaminA: Float, carotene: Float, vitaminE: Float, vitaminB1: Float, vitaminB2: Float, vitaminC: Float, niacin: Float, phosphorus: Float, potassium: Float, magnesium: Float, calcium: Float, iron: Float, zinc: Float, selenium: Float, copper: Float, manganese: Float, imageID: Int, type: Int) {
        self.foodNameCHN = foodNameCHN
        self.foodID = foodID
        self.calories = calories
        self.carbohydrate = carbohydrate
        self.fat = fat
        self.protein = protein
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.dietaryFiber = dietaryFiber
        self.vitaminA = vitaminA
        self.carotene = carotene
        self.vitaminE = vitaminE
        self.vitaminB1 = vitaminB1
        self.vitaminB2 = vitaminB2
        self.vitaminC = vitaminC
        self.niacin = niacin
        self.phosphorus = phosphorus
        self.potassium = potassium
        self.magnesium = magnesium
        self.calcium = calcium
        self.iron = iron
        self.zinc = zinc
        self.selenium = selenium
        self.copper = copper
        self.manganese = manganese
        self.imageID = imageID
        self.type = type
    }
    var foodNameCHN: String
    var foodID, calories, carbohydrate, fat, protein, cholesterol, sodium, dietaryFiber, vitaminA, carotene, vitaminE, vitaminB1, vitaminB2, vitaminC, niacin, phosphorus, potassium, magnesium, calcium, iron, zinc, selenium, copper, manganese: Float
    var imageID, type: Int
}


func getFoodDescription(id: Int, userCompletionHandler: @escaping (Food?, Error?) -> Void) -> Void{
    if let url = URL(string : "http://127.0.0.1:5000/api/Food/description/"+String(id)){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder() // Create an JsonDecoder instance
                do {
                    let parsedJSON = try jsonDecoder.decode([Food].self, from: data) // try to decode the request
                    userCompletionHandler(parsedJSON[0], nil)
                } catch {
                    print ("JSON Parsing Error", error)
                    userCompletionHandler(nil, error) // Print Error Message if cannot perform the request
                }
            }
        }.resume()
    }
}

struct Server{
    static let url: String = "http://127.0.0.1:5000/api/"
}

struct referenceFoods: Decodable{
    // per slice
    static var chickenBreast: Food = Food(foodNameCHN: "Chicken Breast", foodID: 764, calories: 133, carbohydrate: 2.0, fat: 5.0, protein: 19.0, cholesterol: 82.0, sodium: 34.0, dietaryFiber: 0.0, vitaminA: 16.0, carotene: 1.0, vitaminE: 0.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: 0.0, niacin: 11.0, phosphorus: 214.0, potassium: 338.0, magnesium: 28.0, calcium: 3.0, iron: 1.0, zinc: 1.0, selenium: 10.0, copper: 0.0, manganese: 0.0, imageID: -1, type: 0)
    
    // per bowl
    static var rice: Food = Food(foodNameCHN: "Rice", foodID: 56, calories: 116.0, carbohydrate: 26.0, fat: 0.0, protein: 3.0, cholesterol: 0.0, sodium: 2.0, dietaryFiber: 0.0, vitaminA: 0.0, carotene: 0.0, vitaminE: 0.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: 0, niacin: 2.0, phosphorus: 62.0, potassium: 30.0, magnesium: 15.0, calcium: 7.0, iron: 1.0, zinc: 1.0, selenium: 0.0, copper: 0.0, manganese: 1.0, imageID: -1, type: 1)
    
    // per slice
    static var oreo: Food = Food(foodNameCHN: "Oreo", foodID: -1, calories: 491.0, carbohydrate: 70.8, fat: 21.2, protein: 4.2, cholesterol: 0.0, sodium: -1.0, dietaryFiber: -1.0, vitaminA: -1.0, carotene: -1.0, vitaminE: -1.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: -1.0, niacin: -1.0, phosphorus: -1.0, potassium: -1.0, magnesium: -1.0, calcium: -1.0, iron: -1.0, zinc: -1.0, selenium: -1.0, copper: -1.0, manganese: -1.0, imageID: -1, type: 2)
    
    // per cup
    static var cola: Food = Food(foodNameCHN: "Cola", foodID: -1, calories: 45, carbohydrate: 11.2, fat: 0.0, protein: 0.0, cholesterol: 0.0, sodium: 11.4, dietaryFiber: 0.0, vitaminA: 0.0, carotene: 0.0, vitaminE: -1.0, vitaminB1: -1.0, vitaminB2: -1.0, vitaminC: -1.0, niacin: -1.0, phosphorus: -1.0, potassium: -1.0, magnesium: -1.0, calcium: -1.0, iron: -1.0, zinc: -1.0, selenium: -1.0, copper: -1.0, manganese: -1.0, imageID: -1, type: 3)
    
    static var unitMap: Dictionary<String, String> = ["calories":"Kcal","vitaminB1":"mg","calcium":"mg","protein":"g","vitaminB2":"mg","magnesium":"mg","fat":"g","niacin":"mg","iron":"mg","carbohydrate":"g","vitaminC":"mg","manganese":"mg","dietaryFiber":"g","vitaminE":"mg","zinc":"mg","vitaminA":"mcg","cholesterol":"mg","copper":"mg","carotene":"mcg","potassium":"mg","phosphorus":"mg","sodium":"mg","selenium":"mcg"]
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
    
    var url = URL(string: "127.0.0.1:5000/api/Food/description/1")!
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

struct foodExampleView: View {
    @ObservedObject var model = foodModel()
    var body: some View{
        Text(model.foods[0].foodNameCHN)
            .overlay(StatusOverlay(model: model))
            .onAppear{self.model.loadIfNeeded()}
    }
}

struct StatusOverlay: View{
    @ObservedObject var model: foodModel
    
    var body: some View{
        switch model.state{
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            return AnyView(
                VStack(spacing: 10){
                    Text(error.localizedDescription).frame(maxWidth: 300)
                    Button("Retry"){
                        self.model.load()
                    }
                }
                .padding()
                .background(Color.yellow)
            )
        }
    }
}
