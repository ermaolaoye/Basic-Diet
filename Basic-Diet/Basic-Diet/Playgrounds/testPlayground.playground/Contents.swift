import SwiftUI

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let foodNameCHN: String
    let barcode: JSONNull?
    let foodID, calories, carbohydrate, fat: Int
    let protein, cholesterol, sodium, dietaryFiber: Int
    let vitaminA, carotene, vitaminE: Int
    let vitaminB1, vitaminB2: JSONNull?
    let vitaminC, niacin, phosphorus, potassium: Int
    let magnesium, calcium, iron, zinc: Int
    let selenium, copper, manganese: Int
    let addUser, type, imageID: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


// Create URL
let url = URL(string: "http://127.0.0.1:5000/api/Food/description/1")
guard let requestUrl = url else { fatalError() }

// Create URL Request
var request = URLRequest(url: requestUrl)

// Specify HTTP Method to use
request.httpMethod = "GET"
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
        let welcome = try? JSONDecoder().decode(Welcome.self, from: data)
        print(welcome)
    }
    
}
task.resume()
