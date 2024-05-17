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
            HStack {
                Button(action: {
                    // Navigate back to the home page
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController as? UINavigationController {
                        rootViewController.popViewController(animated: true)
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }
            .zIndex(1)
            Spacer()
            ZStack {
                CircularProgressView(progress: viewModel.timeRemaining / (TimeInterval(minutes * 60 + seconds) + 1), diameter: 200)
                Image(currentCharacterImageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
            }
            .onChange(of: viewModel.timeRemaining) { _, _ in
                updateCharacterImage()
            }
            .onChange(of: selectedCharacter) { _, _ in
                updateCharacterImage()
            }

            TimerPicker(minutes: $minutes, seconds: $seconds)
                .onChange(of: minutes) { _, _ in updateRemainingTime() }
                .onChange(of: seconds) { _, _ in updateRemainingTime() }
                .padding(.top, 20)

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
                    .frame(width: 40, height: 40)  // Bigger coin icon
                Text("\(coinManager.coins)")
                    .font(.title)
                    .padding(.leading, 5)
                    .foregroundColor(Color.white)
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
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
        } else if timeRemainingRatio > 1/3 {
            currentCharacterImageName = selectedCharacter.tiredImageName
        } else {
            currentCharacterImageName = selectedCharacter.sleepingImageName
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(selectedCharacter: .constant(characters.first!))
            .environmentObject(CoinManager())
    }
}
