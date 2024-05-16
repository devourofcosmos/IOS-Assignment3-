import SwiftUI

class CoinManager: ObservableObject {
    @Published var coins: Int = 0

    func addCoins(_ amount: Int) {
        coins += amount
    }

    func spendCoins(_ amount: Int) {
        if coins >= amount {
            coins -= amount
        }
    }
}
