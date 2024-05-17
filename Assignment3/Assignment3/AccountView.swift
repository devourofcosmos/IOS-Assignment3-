import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel

    var body: some View {
        VStack {
            if viewModel.isLoggedIn {
                Text("Welcome, \(viewModel.username)!")
                    .font(.title)
                    .padding()
                Button("Logout") {
                    viewModel.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                if viewModel.showSignUp {
                    VStack {
                        TextField("New Username", text: $viewModel.signUpUsername)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                        SecureField("New Password", text: $viewModel.signUpPassword)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                        Button("Create Account") {
                            viewModel.createAccount()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Button("Back to Login") {
                            viewModel.showSignUp = false
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        TextField("Username", text: $viewModel.username)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                        Button("Login") {
                            viewModel.login()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Button("Sign Up") {
                            viewModel.showSignUp = true
                        }
                        .padding()
                    }
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .navigationTitle("Account")
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountView(viewModel: AccountViewModel())
        }
    }
}
