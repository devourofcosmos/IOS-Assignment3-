import SwiftUI

@main
struct YourAppNameApp: App {
    var body: some Scene {
        WindowGroup {
            HomePageView()
        }
    }
}

struct ContentView: View {
    @StateObject private var coinManager = CoinManager()
    @State private var selectedCharacter = characters.first!

    var body: some View {
        HomePageView()
            .environmentObject(coinManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoinManager())
    }
}
