import SwiftUI
import Combine

class AccountViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var showSignUp: Bool = false
    @Published var signUpUsername: String = ""
    @Published var signUpPassword: String = ""

    func createAccount() {
        UserDefaults.standard.set(signUpUsername, forKey: "username")
        UserDefaults.standard.set(signUpPassword, forKey: "password")
        username = signUpUsername
        password = signUpPassword
        isLoggedIn = true
        showSignUp = false
    }

    func login() {
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        
        if username == storedUsername && password == storedPassword {
            isLoggedIn = true
        } else {
            // Handle invalid credentials
        }
    }

    func logout() {
        isLoggedIn = false
        username = ""
        password = ""
    }
}
