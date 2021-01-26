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
    
    @ObservedObject var manager = HttpAuth()
    
    @State private var isEmailValid: Bool = true
    
    @State private var buttonClicked: Bool = false
    
    @State private var userJWT = UserDefaults.standard.string(forKey: "JWT")
    
    var body: some View {
        VStack(alignment: .leading){
            if self.manager.authenticated {
                Text(UserDefaults.standard.string(forKey: "JWT")!)
            } else {
                VStack(alignment: .leading){
                    Text("Username")
                    TextField("Enter...", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                    
                    Text("Password")
                    TextField("Enter...", text: $passwordInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                        .onChange(of: passwordInput, perform: { value in
                            self.password = hashText(string: passwordInput)
                        })
                    
                    
                    HStack{
                        Text("Email")
                        Spacer()
                        if !self.isEmailValid {
                            Text("Email is invalid")
                                .foregroundColor(.red)
                        }
                    }
                    TextField("Enter...", text: $userEmail, onEditingChanged: { (isChanged) in
                        if !isChanged {
                            if textFieldValidator(string: self.userEmail, regularExpression: #"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$"#){
                                self.isEmailValid = true
                            } else {
                                self.isEmailValid = false
                                self.userEmail = ""
                            }
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray)
                    .autocapitalization(.none)
                }
                
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
                    Text("Weight")
                    TextField("Enter...", text: $userWeightText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                        .onChange(of: userWeightText, perform: { value in
                            self.userWeight = Int(userWeightText) ?? 0
                        })
                    
                    Text("Height")
                    TextField("Enter...", text: $userHeightText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                        .onChange(of: userHeightText, perform: { value in
                            self.userHeight = Int(userHeightText) ?? 0
                        })
                }
                
                DatePicker(selection: $userBirthdayDate, in: ...Date(), displayedComponents: .date){
                    Text("Birthday")
                }
                .onChange(of: userBirthdayDate, perform: { value in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    self.userBirthday = dateFormatter.string(from: userBirthdayDate)
                })
                
                
                Button(action:{
                    self.manager.state = .loading
                    self.buttonClicked = true
                    self.manager.postAuth(user: RegisterUser(userName: userName, userGender: userGender, password: password, userEmail: userEmail, userWeight: userWeight, userHeight: userHeight, userBirthday: userBirthday))
                }){
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .accentColor(basicColors.healthyColor)
                            Text("Register")
                                .foregroundColor(basicColors.textColor)
                        }
                        .frame(width: 100.0, height: 40.0)
                        Spacer()
                    }
                }
                .disabled(self.userName.isEmpty || self.password.isEmpty || self.userEmail.isEmpty || self.userWeight == 0 || self.userHeight == 0 || self.userBirthday == "" || self.buttonClicked == true)
            }
        }.padding()
        .overlay(StatusOverlayRegisterUser(model: manager))
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

func textFieldValidator(string: String, regularExpression: String) -> Bool{
    let textPredicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
    return textPredicate.evaluate(with: string)
}
