import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Navigate back to the home page
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController as? UINavigationController {
                        rootViewController.popViewController(animated: true)
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }
            .zIndex(1)
            if viewModel.isLoggedIn {
                Text("Welcome, \(viewModel.username)!")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
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
                            .foregroundColor(.black)
                        SecureField("New Password", text: $viewModel.signUpPassword)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .foregroundColor(.black)
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
                        .foregroundColor(.white)
                    }
                } else {
                    VStack {
                        TextField("Username", text: $viewModel.username)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .foregroundColor(.black)
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
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
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
