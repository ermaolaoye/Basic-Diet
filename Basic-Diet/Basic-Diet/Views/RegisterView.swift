//
//  RegisterView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/9.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName: String = ""
    @State private var userGender: String = "Male"
    @State private var password: String = ""
    @State private var userEmail: String = ""
    @State private var userWeight: Int = 0
    @State private var userHeight: Int = 0
    @State private var userBirthday: String = ""
    
    @State private var userWeightText: String = ""
    @State private var userHeightText: String = ""
    @State private var passwordInput: String = ""
    
    @State private var userBirthdayDate = Date()
    
    @State private var selectedGenderIndex: Int = 0
    private var genderOptions = ["👨 Male", "👩 Female"]
    
    @ObservedObject var manager = UserRegisterAPIManager() // Internet communication manager
    
    @State private var isEmailValid: Bool = true // Check Email Valid
    
    @State private var buttonClicked: Bool = false // Check Register Button Clicked
    
    var body: some View {
        VStack(alignment: .leading){
            if self.manager.authenticated { // If register succeed
                Text(UserDefaults.standard.string(forKey: UserDefaultKeys.User.JWT)!) // Succeed if JWT is returned
                Text(UserDefaults.standard.string(forKey: UserDefaultKeys.User.userID)!)
                Text("Register Succeed")
                    .bold()
                    .foregroundColor(.red)
            } else {
                VStack(alignment: .leading){
                    // Username
                    Text("Username")
                    TextField("Enter...", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                    
                    // Password
                    Text("Password")
                    TextField("Enter...", text: $passwordInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                        .onChange(of: passwordInput, perform: { value in
                            self.password = hashText(string: passwordInput)
                        })
                    
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
                .pickerStyle(SegmentedPickerStyle()) // Picker Style
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
                
                // Birthday
                DatePicker(selection: $userBirthdayDate, in: ...Date(), displayedComponents: .date){
                    Text("Birthday")
                }
                .onChange(of: userBirthdayDate, perform: { value in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd" // Set date format
                    self.userBirthday = dateFormatter.string(from: userBirthdayDate) // Convert to String
                })
                
                // Register button
                Button(action:{
                    self.manager.state = .loading
                    self.buttonClicked = true
                    self.manager.postAuth(user: RegisterUser(userName: userName, userGender: userGender, password: password, userEmail: userEmail, userWeight: userWeight, userHeight: userHeight, userBirthday: userBirthday)) // POST Request
                }){
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .accentColor(basicColors.healthyColor) // Only showing green when all contents are filled
                            Text("Register")
                                .foregroundColor(basicColors.textColor)
                        }
                        .frame(width: 100.0, height: 40.0)
                        Spacer()
                    }
                }
                .disabled(self.userName.isEmpty || self.password.isEmpty || self.userEmail.isEmpty || self.userWeight == 0 || self.userHeight == 0 || self.userBirthday == "" || self.buttonClicked == true) // Disable the register button if any field is empty
            }
        }.padding()
        .overlay(StatusOverlayRegisterUser(model: manager)) // Overlay view
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

// Regular Expression TextField Validator
func textFieldValidator(string: String, regularExpression: String) -> Bool{
    /* Parameter:
       String       String that needs to be tested
       regularExpression The RegEx used to whether the string inputed is valid or not
     */
    let textPredicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
    return textPredicate.evaluate(with: string) // Return whether matched with the regular expression
}
