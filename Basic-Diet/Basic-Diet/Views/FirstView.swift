//
//  FirstView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/5.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Welcome to Basic-Diet")
                // Register
                NavigationLink(destination: RegisterView()){
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .accentColor(basicColors.healthyColorLight)
                            Text("Register")
                                .foregroundColor(basicColors.textColor)
                        }
                        .frame(width: 100.0, height: 40.0)
                        Spacer()
                    }
                }
                // Login
                NavigationLink(destination: LoginView()){
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .accentColor(basicColors.healthyColorStrong)
                            Text("Login")
                                .foregroundColor(basicColors.textColor)
                        }
                        .frame(width: 100.0, height: 40.0)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
