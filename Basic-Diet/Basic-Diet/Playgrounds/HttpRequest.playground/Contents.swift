import Foundation

struct Food: Codable {
    let foodNameCHN: String
    let calories, carbohydrate, fat, protein: Int
    let cholesterol: Int
}


// if this is posible then ->
func getFoodDescription(id: Int, returnFood: Food) -> Void{
    if let url = URL(string : "http://127.0.0.1:5000/api/Food/description/"+String(id)){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder() // Create an JsonDecoder instance
                do {
                    let parsedJSON = try jsonDecoder.decode([Food].self, from: data) // try to decode the request
                    for food in parsedJSON{
                        //returnFood = food
                    }
                } catch {
                    print(error) // Print Error Message if cannot perform the request
                }
            }
        }.resume() // Perform the URL request
    }
}

//var xiaoMai: Food = getc()

