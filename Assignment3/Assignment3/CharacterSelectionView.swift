import SwiftUI

struct CharacterSelectionView: View {
    @Binding var selectedCharacter: Character
    let characters: [Character]

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
                                .overlay(Circle().stroke(selectedCharacter.id == character.id ? Color.blue : Color.clear, lineWidth: 4))
                                .onTapGesture {
                                    selectedCharacter = character
                                }
                            
                            Text(character.name)
                                .font(.headline)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .background(selectedCharacter.id == character.id ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.top, 20)
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

struct CharacterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelectionView(selectedCharacter: .constant(characters.first!), characters: characters)
    }
}
