import SwiftUI

struct HomePageView: View {
    @State private var selectedCharacter = characters.first!  // Default to the first character
    @State private var isHome = true  // Track whether the user is on the home page

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Navigation Bar with icons
                    VStack(spacing: 30) {
                        Spacer()
                        if isHome {
                            VStack {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text("Home")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        } else {
                            NavigationLink(destination: HomePageView().onAppear { isHome = true }) {
                                VStack {
                                    Image(systemName: "house.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                    Text("Home")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        NavigationLink(destination: TimelineView().onAppear { isHome = false }) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text("Timeline")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        NavigationLink(destination: TimerView(selectedCharacter: $selectedCharacter).onAppear { isHome = false }) {
                            VStack {
                                Image(systemName: "clock.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text("Timer")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        NavigationLink(destination: CharacterSelectionView(selectedCharacter: $selectedCharacter, characters: characters).onAppear { isHome = false }) {
                            VStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text("Character")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        NavigationLink(destination: AccountView().onAppear { isHome = false }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text("Account")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 80)
                    .padding(.vertical, 20)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))

                    // Main content area
                    VStack {
                        Spacer()
                        Image(selectedCharacter.selectionImageName)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .padding()
                            .background(Circle().fill(Color.white).shadow(radius: 10))
                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.85)
                    .background(Color(UIColor.systemBackground))
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .accentColor(.black)  // Set the back button color to black
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
