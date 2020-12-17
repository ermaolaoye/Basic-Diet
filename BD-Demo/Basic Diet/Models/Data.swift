//
//  Data.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import UIKit
import SwiftUI

let foodData: [FoodProfile] = load("foods.json")

// A function that decode json file
func load<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else{
        fatalError("Cannot find file \(filename)")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Cannot load \(filename)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}
