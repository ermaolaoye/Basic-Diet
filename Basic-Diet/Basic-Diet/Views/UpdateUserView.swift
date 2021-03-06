//
//  UpdateUserView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/6.
//

import SwiftUI

struct UpdateUserView: View {
    @State private var userName: String = ""
    @State private var userGender: String = "Male"
    @State private var userEmail: String = ""
    @State private var userWeight: Int = 0
    @State private var userHeight: Int = 0
    
    @State private var userWeightText: String = ""
    @State private var userHeightText: String = ""
    
    @State private var selectedGenderIndex: Int = 0
    private var genderOptions = ["👨 Male", "👩 Female"]
    
    @ObservedObject var manager = UserUpdateAPIManager() // Internet communication manager
    
    @State private var isEmailValid: Bool = true
    
    @State private var buttonClicked: Bool = false
    
    @State private var userJWT = UserDefaults.standard.string(forKey: "JWT")
    
    var body: some View {
        VStack(alignment: .leading){
            if self.manager.authenticated {
                Text(UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT)!) // Succeed if JWT is returned
                Text(UserDefaults.standard.string(forKey: UserDefaultKeys.User.userID)!)
            } else {
                VStack(alignment: .leading){
                    // Username
                    Text("Username")
                    TextField("Enter...", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                    
                    // Email
                    HStack{
                        Text("Email")
                        Spacer()
                        if !self.isEmailValid { // Showing Warning if email inputed is invalid
                            Text("Email is invalid")
                                .foregroundColor(.red)
                        }
                    }
                    TextField("Enter...", text: $userEmail, onEditingChanged: { (isChanged) in
                        if !isChanged {
                            // Email Validator
                            if textFieldValidator(string: self.userEmail, regularExpression: #"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$"#){
                                self.isEmailValid = true
                            } else {
                                // Set input content to none, if the email is invalid
                                self.isEmailValid = false
                                self.userEmail = ""
                            }
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray)
                    .autocapitalization(.none)
                }
                
                // Gender
                Text("Gender")
                Picker("Gender", selection: $selectedGenderIndex) {
                    ForEach(0..<genderOptions.count) {
                        Text(self.genderOptions[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedGenderIndex, perform: { value in
                    if selectedGenderIndex == 0{
                        userGender = "Male"
                    } else if selectedGenderIndex == 1 {
                        userGender = "Female"
                    }
                })
                
                VStack(alignment: .leading){
                    // Weight
                    Text("Weight")
                    TextField("Enter...", text: $userWeightText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad) // Only allows using number pad to input value
                        .onChange(of: userWeightText, perform: { value in
                            self.userWeight = Int(userWeightText) ?? 0 // Convert String to Integer
                        })
                    // Height
                    Text("Height")
                    TextField("Enter...", text: $userHeightText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad) // Only allows using number pad to input value
                        .onChange(of: userHeightText, perform: { value in
                            self.userHeight = Int(userHeightText) ?? 0 // Convert String to Integer
                        })
                }
                
                
                // Register button
                Button(action:{
                    self.manager.state = .loading
                    self.buttonClicked = true
                    self.manager.postAuth(user: UpdateUser(userName: userName, userGender: userGender, userEmail: userEmail, userWeight: userWeight, userHeight: userHeight)) // POST Request
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
                .disabled(self.userName.isEmpty || self.userEmail.isEmpty || self.userWeight == 0 || self.userHeight == 0 || self.buttonClicked == true) // Disable the register button if any field is empty
            }
        }.padding()
        .overlay(StatusOverlayUpdateUser(model: manager)) // Overlay view
    }
    
}

struct UpdateUserView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserView()
    }
}
