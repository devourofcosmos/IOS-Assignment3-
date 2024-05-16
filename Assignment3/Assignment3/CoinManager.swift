import SwiftUI
import Combine

class CoinManager: ObservableObject {
    @Published var coins: Int = 0
}
