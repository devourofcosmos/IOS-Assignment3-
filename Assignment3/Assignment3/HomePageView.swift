import SwiftUI

struct HomePageView: View {
    @StateObject private var coinManager = CoinManager()
    @State private var selectedCharacter = characters.first!  // Default to the first character
    @State private var isHome = true

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Navigation Bar with icons
                    VStack(spacing: 30) {
                        Spacer()
                        if !isHome {
                            NavigationLink(destination: HomePageView().onAppear { isHome = false }) {
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
                        } else {
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
                        NavigationLink(destination: TimerView(selectedCharacter: $selectedCharacter).environmentObject(coinManager).onAppear { isHome = false }) {
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
                        NavigationLink(destination: CharacterSelectionView(selectedCharacter: $selectedCharacter, characters: characters).environmentObject(coinManager).onAppear { isHome = false }) {
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
                    .frame(width: geometry.size.width * 0.2)
                    .background(Color.blue)

                    // Main content area
                    VStack {
                        Spacer()
                        ZStack {
                            Image(selectedCharacter.studyingImageName)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                .padding()
                                .background(Circle().fill(Color.white).shadow(radius: 10))
                        }
                        Spacer()
                        HStack {
                            Image("coinIcon")
                                .resizable()
                                .frame(width: 32, height: 32)  // Bigger coin icon
                            Text("\(coinManager.coins)")
                                .font(.title)
                                .padding(.leading, 5)
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width * 0.8)
                    .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
                }
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
