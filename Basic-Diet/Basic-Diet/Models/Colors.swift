//
//  Colors.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//

import SwiftUI

struct basicColors{
    static var basicGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 241/255, green: 242/255,  blue: 246/255,opacity: 1), Color(red: 231/255, green: 238/255, blue:247/255, opacity: 1)]),
        startPoint: .top,
        endPoint: .bottom)
    
    static var healthyGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 123/255, green: 237/255,  blue: 159/255,opacity: 1), Color(red: 163/255, green: 255/255, blue:193/255, opacity: 1)]),
        startPoint: .top,
        endPoint: .bottom)
    
    static var textColor = Color(red: 47/255, green: 53/255, blue: 66/255)
    
    static var captionColor = Color(red: 177/255, green: 186/255, blue: 198/255)
    
    static var healthyColor = Color(red: 126/255, green: 230/255, blue: 159/255)
    
    static var healthyColorLight = Color(red: 150/255, green: 248/255, blue: 181/255)
    
    static var healthyColorStrong = Color(red: 93/255, green: 222/255, blue: 134/255)
}
