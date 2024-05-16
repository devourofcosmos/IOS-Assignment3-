import SwiftUI

struct Character: Identifiable, Equatable {
    var id: UUID
    var name: String
    var studyingImageName: String
    var tiredImageName: String
    var sleepingImageName: String
    var selectionImageName: String
    var isUnlocked: Bool = false  // Track if the character is unlocked

    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

let characters = [
    Character(id: UUID(), name: "Character 1", studyingImageName: "char1_studying", tiredImageName: "char1_tired", sleepingImageName: "char1_sleeping", selectionImageName: "character1", isUnlocked: true),
    Character(id: UUID(), name: "Character 2", studyingImageName: "char2_studying", tiredImageName: "char2_tired", sleepingImageName: "char2_sleeping", selectionImageName: "character2", isUnlocked: true),
    Character(id: UUID(), name: "Character 3", studyingImageName: "char3_studying", tiredImageName: "char3_tired", sleepingImageName: "char3_sleeping", selectionImageName: "character3", isUnlocked: true),
    Character(id: UUID(), name: "Character 4", studyingImageName: "char4_studying", tiredImageName: "char4_tired", sleepingImageName: "char4_sleeping", selectionImageName: "character4"),
    Character(id: UUID(), name: "Character 5", studyingImageName: "char5_studying", tiredImageName: "char5_tired", sleepingImageName: "char5_sleeping", selectionImageName: "character5"),
    Character(id: UUID(), name: "Character 6", studyingImageName: "char6_studying", tiredImageName: "char6_tired", sleepingImageName: "char6_sleeping", selectionImageName: "character6")
]
