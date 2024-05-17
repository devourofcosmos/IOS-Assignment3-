import Foundation

struct StudySession: Identifiable, Codable {
    let id: UUID
    let duration: Int
    let characterBubble: String
    let timestamp: Date
}
