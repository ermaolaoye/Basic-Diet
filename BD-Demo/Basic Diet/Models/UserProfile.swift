//
//  UserProfile.swift
//  Basic Diet
//
//  Created by 黄子航 on 2020/9/26.
//

import SwiftUI

struct User{
    var maxCalories: Int //set max calories
    var currentCalories: Int //user calories
    
    static let `default` = Self(maxCal: 2000, currentCal: 0)
    
    init(maxCal: Int, currentCal: Int = 0) {
        self.maxCalories = maxCal
        self.currentCalories = currentCal
    }
}
