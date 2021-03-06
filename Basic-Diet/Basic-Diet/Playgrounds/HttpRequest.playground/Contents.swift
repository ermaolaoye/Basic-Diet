import Foundation
import SwiftUI

struct User: Codable {
    var userName: String = ""
    var userEmail: String = ""
    var userWeight: Float = 0.0
    var userHeight: Float = 0.0
    var userCalories: Float = 0.0
    var userBirthday: String = ""
    var userGender: String = ""
}

extension User: CustomStringConvertible{
    var description: String {
        return "userName = \(userName)"
    }
}

let user = User()

print(user.description)
