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

func getFoodDescription(id: Int, userCompletionHandler: @escaping (Food?, Error?) -> Void) -> Void{
    if let url = URL(string : "http://127.0.0.1:5000/api/Food/description/"+String(id)){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder() // Create an JsonDecoder instance
                do {
                    let parsedJSON = try jsonDecoder.decode([Food].self, from: data) // try to decode the request
                    for food in parsedJSON {
                        userCompletionHandler(food, nil)
                    }
                } catch {
                    print ("JSON Parsing Error", error)
                    userCompletionHandler(nil, error) // Print Error Message if cannot perform the request
                }
            }
        }.resume()
    }
}
