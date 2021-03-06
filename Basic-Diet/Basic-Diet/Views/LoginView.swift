//
//  LoginView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/11.
//

import SwiftUI

struct LoginView: View {
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    
    @State var buttonClicked: Bool = false
    
    @ObservedObject var manager = UserLoginManager()
    var body: some View {
        VStack(alignment: .leading){
            if self.manager.authenticated == true{
                Text(UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT)!)
                Spacer()
                Text(String(UserDefaults.standard.integer(forKey: UserDefaultKeys.User.userID)))
            } else {
                if self.manager.state == .wrongPassword{
                    // Display warning if login failed
                    Text("Wrong Password or accounts")
                }
                Text("Email")
                TextField("Enter ...", text: $userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray)
                    .autocapitalization(.none)
                
                Text("Password")
                TextField("Enter ...", text: $userPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray)
                    .autocapitalization(.none)
                
                Button(action:{
                    self.buttonClicked = true
                    self.manager.postAuth(user: LoginUser(userEmail: userEmail, password: hashText(string: userPassword)))
                }){
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .accentColor(basicColors.healthyColor)
                            Text("Login")
                                .foregroundColor(basicColors.textColor)
                        }
                        .frame(width: 100.0, height: 40.0)
                        Spacer()
                    }
                }
                .disabled(self.userEmail.isEmpty || self.userPassword.isEmpty)
            }
        }
        .overlay(StatusOverlayLoginUser(model: manager))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
