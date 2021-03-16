//
//  UpdatePasswordView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/15.
//

import SwiftUI

struct UpdatePasswordView: View {
    @State private var oriPassword=""
    @State private var newPassword=""
    
    @State private var buttonClicked = false
    
    @ObservedObject var manager = PasswordUpdateManager()
    
    var body: some View {
        if self.manager.authenticated {
            Text("Update Succeeded")
        } else {
            VStack {
                Text("Original Password")
                TextField("Enter...", text: $oriPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray)
                    .autocapitalization(.none)
                
                Text("New Password")
                TextField("Enter...", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray)
                    .autocapitalization(.none)
                
                Button(action:{
                    self.manager.state = .loading
                    self.buttonClicked = true
                    self.manager.postAuth(oriPassword: self.oriPassword, newPassword: self.newPassword)
                }){
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .accentColor(basicColors.healthyColor) // Only showing green when all contents are filled
                            Text("Submit")
                                .foregroundColor(basicColors.textColor)
                        }
                        .frame(width: 100.0, height: 40.0)
                        Spacer()
                    }
                }
                .disabled(self.oriPassword.isEmpty || self.newPassword.isEmpty)
            }
            .overlay(StatusOverlayUpdatePassword(manager: self.manager))
        }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}
