import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel() // ViewModel instance
    @Binding var selectedCharacter: Character  // Binding to the selected character

    @State private var minutes = 5
    @State private var seconds = 0
    @State private var currentCharacterImageName = "char1_studying"  // Default to the first character's studying image

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                CircularProgressView(progress: viewModel.timeRemaining / (TimeInterval(minutes * 60 + seconds) + 1), diameter: 200)
                Image(currentCharacterImageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
            }

            TimerPicker(minutes: $minutes, seconds: $seconds)
                .onChange(of: minutes) { _ in updateRemainingTime() }
                .onChange(of: seconds) { _ in updateRemainingTime() }

            Text("\(Int(viewModel.timeRemaining / 60)) minutes \(Int(viewModel.timeRemaining.truncatingRemainder(dividingBy: 60))) seconds")
                .font(.title)
                .padding(.top, 20)

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
                .padding(.horizontal)

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
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onChange(of: viewModel.timeRemaining, perform: { value in
            updateCharacterImage()
        })
        .onChange(of: selectedCharacter, perform: { _ in
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
            currentCharacterImageName = selectedCharacter.sleepingImageName
        } else if viewModel.timeRemaining <= twoThirdsTime {
            currentCharacterImageName = selectedCharacter.tiredImageName
        } else {
            currentCharacterImageName = selectedCharacter.studyingImageName
        }
    }
}
