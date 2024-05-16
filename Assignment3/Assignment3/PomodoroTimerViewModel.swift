import Foundation
import Combine

class PomodoroTimerViewModel: ObservableObject {
    @Published var timerIsActive = false  // Boolean to track if the timer is active
    @Published var timeRemaining: TimeInterval = 5 * 60  // Default to 5 minutes for demonstration
    var totalTime: TimeInterval = 5 * 60  // To keep track of total time set initially

    private var timer: Timer?  // Optional Timer object

    // Function to start the timer
    func startTimer() {
        totalTime = timeRemaining // Set the total time to the initial time remaining
        timerIsActive = true  // Sets the timer state to active
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let strongSelf = self, strongSelf.timeRemaining > 0 {
                strongSelf.timeRemaining -= 1  // Decrease time remaining by 1 second
            } else {
                self?.stopTimer()  // Stop the timer if time runs out
            }
        }
    }

    // Function to stop the timer
    func stopTimer() {
        timerIsActive = false  // Sets the timer state to inactive
        timer?.invalidate()  // Invalidates the timer
        timer = nil  // Clears the timer
    }

    // Function to set time remaining directly
    func setTime(minutes: Int, seconds: Int) {
        timeRemaining = TimeInterval((minutes * 60) + seconds)
    }
}
