import SwiftUI

// ViewModel for managing the timer
class PomodoroTimerViewModel: ObservableObject {
    @Published var timerIsActive = false  // Boolean to track if the timer is active
    @Published var timeRemaining: TimeInterval = 180 * 60 // Stores the time remaining, initialized to 180 minutes

    private var timer: Timer?  // Optional Timer object

    // Function to start the timer
    func startTimer() {
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
        timeRemaining = 180 * 60 // Reset the time to 180 minutes
    }
}

// SwiftUI view that acts as the main interface for the application
struct HomePageView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel() // ViewModel instance
    @State private var selectedCharacter = "character1"  // Currently selected character image
    @State private var adjustingTime = false  // State to track if time adjustment mode is active

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Sidebar with icons
                VStack {
                    Spacer()
                    Image(systemName: "bell").resizable().frame(width: 40, height: 40)
                    Spacer()
                    Image(systemName: "clock.fill").resizable().frame(width: 60, height: 60)
                    Spacer()
                    Image(systemName: "alarm").resizable().frame(width: 40, height: 40)
                    Spacer()
                    Image(systemName: "stopwatch").resizable().frame(width: 40, height: 40)
                    Spacer()
                    Image(systemName: "timer").resizable().frame(width: 40, height: 40)
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.15)
                .padding(.leading, 20)
                .background(Color.gray.opacity(0.2))

                // Main content area
                VStack {
                    Spacer()
                    ZStack {
                        CircularSlider(timeRemaining: $viewModel.timeRemaining, maxTime: 180 * 60, diameter: geometry.size.width * 0.6)
                        Image(selectedCharacter).resizable().scaledToFit().clipShape(Circle()).frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    }

                    Text("\(Int(viewModel.timeRemaining / 60)) minutes").font(.title).padding(.top, 20)

                    HStack {
                        Button(action: {
                            if viewModel.timerIsActive {
                                viewModel.stopTimer()
                            } else {
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
    }
}

// Custom SwiftUI view for the circular slider
struct CircularSlider: View {
    @Binding var timeRemaining: TimeInterval  // Binding to the time remaining
    var maxTime: TimeInterval  // Maximum time for the timer
    var diameter: CGFloat  // Diameter of the slider

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2

            Path { path in
                path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360 * Double(timeRemaining / maxTime)), clockwise: false)
            }
            .stroke(Color.green, lineWidth: 20)
            .gesture(
                DragGesture().onChanged { value in
                    let vector = CGVector(dx: value.location.x - center.x, dy: value.location.y - center.y)
                    let angle = atan2(vector.dy, vector.dx)
                    let fixedAngle = angle < 0 ? angle + 2 * .pi : angle
                    let percentage = fixedAngle / (2 * .pi)
                    timeRemaining = maxTime * Double(percentage)
                }
            )
        }
    }
}

// SwiftUI preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
