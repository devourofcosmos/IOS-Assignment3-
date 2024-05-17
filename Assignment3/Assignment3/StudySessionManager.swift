import Foundation

class StudySessionManager {
    static let shared = StudySessionManager()
    private let userDefaultsKey = "StudySessions"

    private init() {}

    func saveStudySession(session: StudySession) {
        var sessions = fetchStudySessions()
        sessions.append(session)
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func fetchStudySessions() -> [StudySession] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let sessions = try? JSONDecoder().decode([StudySession].self, from: data) {
            return sessions
        }
        return []
    }
}
