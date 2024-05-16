import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel() // ViewModel instance
    @Binding var selectedCharacter: Character  // Binding to the selected character

    @State private var minutes = 5
    @State private var seconds = 0
    @State private var currentCharacterImageName: String

    init(selectedCharacter: Binding<Character>) {
        self._selectedCharacter = selectedCharacter
        self._currentCharacterImageName = State(initialValue: selectedCharacter.wrappedValue.studyingImageName)
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                CircularProgressView(progress: viewModel.timeRemaining / (TimeInterval(minutes * 60 + seconds) + 1), diameter: 200)
                    .shadow(radius: 10)
                Image(currentCharacterImageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                    .padding()
                    .background(Circle().fill(Color.white).shadow(radius: 10))
            }

            TimerPicker(minutes: $minutes, seconds: $seconds)
                .onChange(of: minutes) { _ in updateRemainingTime() }
                .onChange(of: seconds) { _ in updateRemainingTime() }
                .padding()

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
                        .shadow(radius: 10)
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
                .shadow(radius: 10)
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onChange(of: viewModel.timeRemaining, perform: { value in
            updateCharacterImage()
        })
        .onChange(of: selectedCharacter, perform: { newValue in
            currentCharacterImageName = newValue.studyingImageName
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
