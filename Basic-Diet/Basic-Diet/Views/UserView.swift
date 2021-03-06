//
//  UserView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/6.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var manager = GetUserManager()
    var body: some View {
        VStack {
            Spacer()
            List{
                NavigationLink(destination: UpdateUserView()){
                    Text("Edit User Profile")
                        .foregroundColor(.blue)
                }
                // UserName
                HStack{
                    Text("UserName")
                    Spacer()
                    Text(manager.user[0].userName)
                }
                HStack{
                    Text("UserWeight")
                    Spacer()
                    Text(String(manager.user[0].userWeight))
                }
                HStack{
                    Text("UserHeight")
                    Spacer()
                    Text(String(manager.user[0].userHeight))
                }
                HStack{
                    Text("Recommended Calories")
                    Spacer()
                    Text(String(manager.user[0].userCalories))
                }
                HStack{
                    Text("UserBirthday")
                    Spacer()
                    Text(String(manager.user[0].userBirthday))
                }
                HStack{
                    Text("UserGender")
                    Spacer()
                    Text(String(manager.user[0].userGender))
                }
                Button(action: {UserDefaults.standard.set(false, forKey: UserDefaultKeys.System.isLogin)}, label: {
                    HStack{
                        Spacer()
                        Text("Log Out")
                            .foregroundColor(.red)
                        Spacer()
                    }
                })
                Spacer()
                Button(action: { deleteUser() }, label: {
                    HStack{
                        Spacer()
                        Text("Delete User Profile")
                            .foregroundColor(.red)
                        Spacer()
                    }
                })
            }
            .onAppear{self.manager.postAuth()}
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
