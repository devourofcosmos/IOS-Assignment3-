import SwiftUI

struct CharacterSelectionView: View {
    @Binding var selectedCharacter: Character
    @EnvironmentObject var coinManager: CoinManager
    @State private var showUnlockAlert = false
    @State private var characterToUnlock: Character?
    @State private var characters: [Character]

    init(selectedCharacter: Binding<Character>, characters: [Character]) {
        self._selectedCharacter = selectedCharacter
        self._characters = State(initialValue: characters)
    }

    var body: some View {
        VStack {
            Text("Select a Character")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(Color.white)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(characters) { character in
                        HStack {
                            Image(character.selectionImageName)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .padding()
                                .overlay(
                                    Circle().stroke(character.isUnlocked ? (character.id == selectedCharacter.id ? Color.green : Color.blue) : Color.gray, lineWidth: 4)
                                )
                                .onTapGesture {
                                    if character.isUnlocked {
                                        selectedCharacter = character
                                    } else {
                                        showUnlockAlert = true
                                        characterToUnlock = character
                                    }
                                }

                            Text(character.name)
                                .font(.headline)
                                .padding(.leading, 10)
                                .foregroundColor(Color.white)

                            Spacer()

                            if !character.isUnlocked {
                                Text("Locked")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        .padding(.vertical, 10)
                        .background(character.isUnlocked ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.top, 20)
            }
            Spacer()

            HStack {
                Image("coinIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("\(coinManager.coins)")
                    .font(.title)
                    .padding(.leading, 5)
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showUnlockAlert) {
            Alert(
                title: Text("Unlock Character"),
                message: Text("Do you want to unlock this character for 3 coins?"),
                primaryButton: .default(Text("Unlock")) {
                    if let character = characterToUnlock, coinManager.coins >= 3 {
                        if let index = characters.firstIndex(where: { $0.id == character.id }) {
                            characters[index].isUnlocked = true
                            coinManager.coins -= 3
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct CharacterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelectionView(
            selectedCharacter: .constant(
                Character(id: UUID(), name: "Character 1", studyingImageName: "char1_studying", tiredImageName: "char1_tired", sleepingImageName: "char1_sleeping", selectionImageName: "character1", isUnlocked: true)
            ),
            characters: [
                Character(id: UUID(), name: "Character 1", studyingImageName: "char1_studying", tiredImageName: "char1_tired", sleepingImageName: "char1_sleeping", selectionImageName: "character1", isUnlocked: true),
                Character(id: UUID(), name: "Character 2", studyingImageName: "char2_studying", tiredImageName: "char2_tired", sleepingImageName: "char2_sleeping", selectionImageName: "character2", isUnlocked: true),
                Character(id: UUID(), name: "Character 3", studyingImageName: "char3_studying", tiredImageName: "char3_tired", sleepingImageName: "char3_sleeping", selectionImageName: "character3", isUnlocked: true),
                Character(id: UUID(), name: "Character 4", studyingImageName: "char4_studying", tiredImageName: "char4_tired", sleepingImageName: "char4_sleeping", selectionImageName: "character4"),
                Character(id: UUID(), name: "Character 5", studyingImageName: "char5_studying", tiredImageName: "char5_tired", sleepingImageName: "char5_sleeping", selectionImageName: "character5"),
                Character(id: UUID(), name: "Character 6", studyingImageName: "char6_studying", tiredImageName: "char6_tired", sleepingImageName: "char6_sleeping", selectionImageName: "character6")
            ]
        )
        .environmentObject(CoinManager())
    }
}
