import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel()
    @Binding var selectedCharacter: Character
    @EnvironmentObject var coinManager: CoinManager

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
            .onChange(of: viewModel.timeRemaining, perform: { _ in
                updateCharacterImage()
            })
            .onChange(of: selectedCharacter, perform: { _ in
                updateCharacterImage()
            })

            // Timer Picker
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

                Button("Reset") {
                    viewModel.stopTimer()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
            }

            Spacer()
            HStack {
                Image("coinIcon")
                    .resizable()
                    .frame(width: 32, height: 32)  // Bigger coin icon
                Text("\(coinManager.coins)")
                    .font(.title)
                    .padding(.leading, 5)
            }
            .padding()
        }
        .padding()
        .onAppear {
            updateCharacterImage()
        }
    }

    private func updateRemainingTime() {
        viewModel.setTime(minutes: minutes, seconds: seconds)
    }

    private func updateCharacterImage() {
        let totalSeconds = TimeInterval(minutes * 60 + seconds)
        let timeRemainingRatio = viewModel.timeRemaining / totalSeconds

        if timeRemainingRatio > 2/3 {
            currentCharacterImageName = selectedCharacter.studyingImageName
