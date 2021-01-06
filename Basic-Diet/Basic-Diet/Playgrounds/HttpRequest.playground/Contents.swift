import SwiftUI
struct Food: Codable {
    let foodNameCHN: String
    let barcode: String?
    let foodID: Int?
    let calories, carbohydrate, fat: Float?
    let protein, cholesterol, sodium, dietaryFiber: Float?
    let vitaminA, carotene, vitaminE: Float?
    let vitaminB1, vitaminB2: Float?
    let vitaminC, niacin, phosphorus, potassium: Float?
    let magnesium, calcium, iron, zinc: Float?
    let selenium, copper, manganese: Float?
    let addUser, imageID: Int?
    let type: String
}



// Create URL
let url = URL(string: "http://127.0.0.1:5000/api/Food/description/1")
guard let requestUrl = url else { fatalError() }

// Create URL Request
var request = URLRequest(url: requestUrl)

// Specify HTTP Method to use
request.httpMethod = "GET"

func parseJSON(data: Data) -> [Food]? {
    
    var returnValue: [Food]?
    do {
        returnValue = try JSONDecoder().decode([Food].self, from: data)
    } catch {
        print("Error took place\(error.localizedDescription).")
    }
    
    return returnValue
}
// Send HTTP Request
let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    
    // Check if Error took place
    if let error = error {
        print("Error took place \(error)")
        return
    }
    
    // Read HTTP Response Status code
    if let response = response as? HTTPURLResponse {
        print("Response HTTP Status code: \(response.statusCode)")
    }
    
    // Convert HTTP Response Data to a simple String
    if let data = data {
        print(parseJSON(data: data)![0])
    }
    
}
task.resume()
