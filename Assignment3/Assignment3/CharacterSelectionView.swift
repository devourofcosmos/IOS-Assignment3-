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
                    .frame(width: 32, height: 32)  // Bigger coin icon
                Text("\(coinManager.coins)")
                    .font(.title)
                    .padding(.leading, 5)
            }
            .padding()
        }
        .padding()
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
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

struct CharacterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelectionView(
            selectedCharacter: .constant(characters.first!),
            characters: characters
        ).environmentObject(CoinManager())
    }
}
