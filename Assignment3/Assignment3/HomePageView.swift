import SwiftUI

// ViewModel for managing the timer
class PomodoroTimerViewModel: ObservableObject {
    @Published var timerIsActive = false  // Boolean to track if the timer is active
    @Published var timeRemaining: TimeInterval = 5 * 60  // Default to 5 minutes for demonstration
    @Published var totalTime: TimeInterval = 5 * 60  // To keep track of total time set initially

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

// SwiftUI view that acts as the main interface for the application
struct HomePageView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel() // ViewModel instance

    @State private var minutes = 5
    @State private var seconds = 0
    @State private var selectedCharacter = "girl studying"  // Initial character image

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Sidebar with icons
                VStack {
                    Spacer()
                    Image(systemName: "house.fill").resizable().frame(width: 40, height: 40) // Home
                    Spacer()
                    Image(systemName: "list.bullet").resizable().frame(width: 40, height: 40) // Timeline
                    Spacer()
                    Image(systemName: "clock.fill").resizable().frame(width: 40, height: 40) // Timer
                    Spacer()
                    Image(systemName: "person.crop.circle").resizable().frame(width: 40, height: 40) // Character
                    Spacer()
                    Image(systemName: "person.fill").resizable().frame(width: 40, height: 40) // Account
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.15)
                .padding(.leading, 20)
                .background(Color.gray.opacity(0.2))

                // Main content area
                VStack {
                    Spacer()
                    ZStack {
                        CircularProgressView(progress: viewModel.timeRemaining / (TimeInterval(minutes * 60 + seconds) + 1), diameter: geometry.size.width * 0.5)
                        Image(selectedCharacter).resizable().scaledToFit().clipShape(Circle()).frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    }
                    
                    // Timer Picker
                    TimerPicker(minutes: $minutes, seconds: $seconds)
                        .onChange(of: minutes) { _ in updateRemainingTime() }
                        .onChange(of: seconds) { _ in updateRemainingTime() }
                    
                    Text("\(Int(viewModel.timeRemaining / 60)) minutes \(Int(viewModel.timeRemaining.truncatingRemainder(dividingBy: 60))) seconds").font(.title).padding(.top, 20)

                    HStack {
                        Button(action: {
                            if viewModel.timerIsActive {
                                viewModel.stopTimer()
                            } else {
                                viewModel.setTime(minutes: minutes, seconds: seconds)
                                viewModel.startTimer()
                            }
                        }) {
                            Text(viewModel.timerIsActive ? "Stop" : "Start")
                                .foregroundColor(.white)
                                .padding()
                                .background(viewModel.timerIsActive ? Color.red : Color.green)
                                .clipShape(Circle())
                        }

                        Button("Reset") {
                            viewModel.stopTimer()
                            updateRemainingTime()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.leading, geometry.size.width * 0.1)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: viewModel.timeRemaining, perform: { value in
            updateCharacterImage()
        })
    }
    
    private func updateRemainingTime() {
        viewModel.setTime(minutes: minutes, seconds: seconds)
    }

    private func updateCharacterImage() {
        let twoThirdsTime = viewModel.totalTime * (2.0 / 3.0)
        let oneThirdTime = viewModel.totalTime * (1.0 / 3.0)

        if viewModel.timeRemaining <= oneThirdTime {
            selectedCharacter = "girl sleeping"
        } else if viewModel.timeRemaining <= twoThirdsTime {
            selectedCharacter = "girl tired"
        } else {
            selectedCharacter = "girl studying"
        }
    }
}

// Custom SwiftUI view for the Timer Picker
struct TimerPicker: View {
    @Binding var minutes: Int
    @Binding var seconds: Int

    var body: some View {
        HStack {
            Picker(selection: $minutes, label: Text("Minutes")) {
                ForEach(0..<181) { minute in
                    Text("\(minute) m").tag(minute)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            .clipped()

            Picker(selection: $seconds, label: Text("Seconds")) {
                ForEach(0..<60) { second in
                    Text("\(second) s").tag(second)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            .clipped()
        }
    }
}

// Custom SwiftUI view for the circular progress indicator
struct CircularProgressView: View {
    var progress: Double
    var diameter: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.green)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
        .frame(width: diameter, height: diameter)
    }
}

