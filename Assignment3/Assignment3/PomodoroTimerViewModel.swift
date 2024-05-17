import Foundation
import SwiftUI

class PomodoroTimerViewModel: ObservableObject {
    @Published var timerIsActive = false  // Boolean to track if the timer is active
    @Published var timeRemaining: TimeInterval = 180 * 60 // Stores the time remaining, initialized to 180 minutes
    @Published var totalTimerUsage: TimeInterval = 0  // Track total timer usage
    @Published var coins: Int = 0  // Track earned coins
    @Published var selectedCharacter: Character = characters.first!  // Default character

    private var timer: Timer?  // Optional Timer object

    // Function to start the timer
    func startTimer() {
        timerIsActive = true  // Sets the timer state to active
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let strongSelf = self, strongSelf.timeRemaining > 0 {
                strongSelf.timeRemaining -= 1  // Decrease time remaining by 1 second
                strongSelf.totalTimerUsage += 1  // Increase total timer usage by 1 second
                strongSelf.checkForCoinReward()  // Check if coins should be awarded
            } else {
                self?.stopTimer()  // Stop the timer if time runs out
                self?.completeSession()  // Save the session when the timer completes
            }
        }
    }

    // Function to stop the timer
    func stopTimer() {
        timerIsActive = false  // Sets the timer state to inactive
        timer?.invalidate()  // Invalidates the timer
        timer = nil  // Clears the timer
        timeRemaining = 180 * 60 // Reset the time to 180 minutes
    }

    // Check if coins should be awarded
    private func checkForCoinReward() {
        let totalMinutes = Int(totalTimerUsage / 60)
        if totalMinutes > 0 && totalMinutes % 60 == 0 {
            coins += 1
            totalTimerUsage = 0  // Reset total usage after awarding a coin
        }
    }

    // Function to set the time
    func setTime(minutes: Int, seconds: Int) {
        timeRemaining = TimeInterval(minutes * 60 + seconds)
    }

    // Function to complete a study session and save it to UserDefaults
    func completeSession() {
        let newSession = StudySession(id: UUID(), duration: Int(totalTimerUsage / 60), characterBubble: selectedCharacter.selectionImageName, timestamp: Date())
        StudySessionManager.shared.saveStudySession(session: newSession)
    }
}
