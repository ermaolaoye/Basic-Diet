//
//  RegisterView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/1/9.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName: String = ""
    @State private var userGender: String = ""
    @State private var password: String = ""
    @State private var userEmail: String = ""
    @State private var userWeight: Int = 0
    @State private var userHeight: Int = 0
    @State private var userBirthday: String = ""
    
    @State private var userWeightText: String = ""
    @State private var userHeightText: String = ""
    
    @State private var userBirthdayDate = Date()
    
    @State private var selectedGenderIndex: Int = 0
    private var genderOptions = ["👨 Male", "👩 Female"]
    
    @ObservedObject var manager = HttpAuth()
    
    
    var body: some View {
        VStack(alignment: .leading){
            if self.manager.authenticated {
                Text("Succeed")
            }
            Form{
                VStack(alignment: .leading){
                    Text("Username")
                    TextField("Enter...", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                    
                    Text("Password")
                    TextField("Enter...", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                    
                    Text("Email")
                    TextField("Enter...", text: $userEmail)
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
            }
            Button(action:{
                self.manager.postAuth(user: RegisterUser(userName: userName, userGender: userGender, password: password, userEmail: userEmail, userWeight: userWeight, userHeight: userHeight, userBirthday: userBirthday))
            }){
                HStack{
                    Spacer()
                    Text("Register")
                    Spacer()
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
