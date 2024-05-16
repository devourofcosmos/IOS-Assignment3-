import Foundation

struct Character: Identifiable, Equatable {
    var id: UUID
    var name: String
    var selectionImageName: String
    var studyingImageName: String
    var tiredImageName: String
    var sleepingImageName: String
}

let characters = [
    Character(id: UUID(), name: "Character 1", selectionImageName: "char1_selection", studyingImageName: "char1_studying", tiredImageName: "char1_tired", sleepingImageName: "char1_sleeping"),
    Character(id: UUID(), name: "Character 2", selectionImageName: "char2_selection", studyingImageName: "char2_studying", tiredImageName: "char2_tired", sleepingImageName: "char2_sleeping"),
    Character(id: UUID(), name: "Character 3", selectionImageName: "char3_selection", studyingImageName: "char3_studying", tiredImageName: "char3_tired", sleepingImageName: "char3_sleeping")
]
