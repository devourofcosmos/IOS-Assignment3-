import SwiftUI

struct HomePageView: View {
    @State private var selectedCharacter = characters.first!  // Default to the first character

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Sidebar with icons
                    VStack(spacing: 30) {
                        Spacer()
                        NavigationLink(destination: HomeView()) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Home")
                                    .font(.caption)
                            }
                        }
                        NavigationLink(destination: TimelineView()) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Timeline")
                                    .font(.caption)
                            }
                        }
                        NavigationLink(destination: TimerView(selectedCharacter: $selectedCharacter)) {
                            VStack {
                                Image(systemName: "clock.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Timer")
                                    .font(.caption)
                            }
                        }
                        NavigationLink(destination: CharacterSelectionView(selectedCharacter: $selectedCharacter, characters: characters)) {
                            VStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Character")
                                    .font(.caption)
                            }
                        }
                        NavigationLink(destination: AccountView()) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Account")
                                    .font(.caption)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.15)
                    .padding(.vertical, 20)
                    .background(Color.gray.opacity(0.2))

                    // Main content area
                    TimerView(selectedCharacter: $selectedCharacter)
                        .frame(width: geometry.size.width * 0.85)
                        .padding(.leading, geometry.size.width * 0.05)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
